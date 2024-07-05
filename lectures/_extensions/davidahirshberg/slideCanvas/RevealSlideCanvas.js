window.RevealSlideCanvas = window.RevealSlideCanvas || {
  id: 'RevealSlideCanvas',
  init: function (deck) {
    initRevealSlideCanvas(deck);
  }
};

initRevealSlideCanvas = function (Reveal) {
  window.addEventListener('load', function (event) { 
    initializePenSettings(Reveal.getConfig())
    Reveal.on('slidechanged', switchCanvas)
    switchCanvas({ currentSlide: Reveal.getCurrentSlide() })
  }, false)
}

// Gets coordinates of touch events on iPad.
function offsetCoords(e) { 
    var slides = document.querySelector('.slides')
    var r = slides.getBoundingClientRect();
    var scalex = r.width  / slides.offsetWidth
    var scaley = r.height / slides.offsetHeight
    var out = {x: (e.touches[0].clientX - r.left) / scalex, 
               y: (e.touches[0].clientY - r.top)  / scaley }
    return out;
}

//
const requestIdleCallback = window.requestIdleCallback || function (fn) { setTimeout(fn, 1) };


// state

var strokePersistence = Infinity;
var tool = 'pen';
var lineWidth=5;
var strokeStyle='#00000000'; 
var fadeSteps;

var isMousedown;
var toolsize;
const canvases = {};

// persistent stroke + layer info
const db = new Dexie('RevealSlideCanvasDatabase');
db.delete().then(()=>db.open())
db.version(1).stores({
   layers: '++id, slide, visible, zindex',
   strokes: '++id, [layerid+drawn+erased], persistence',
   tool: '++id, type, instance' 
});

// assumes at least one layer exists, which should be true
function currentCanvas(slide) {
    if(slide === undefined) { slide = Reveal.getCurrentSlide(); }
    return db.layers
    .where('slide').equals(slide.id)
    .and(slide => slide.visible)
    .sortBy('zindex')
    .then(layers => canvases[layers[layers.length-1].id] )
} 
function updateTool(newTool) {
  tool = newTool;
  currentCanvas().then(canvasWrapper => 
	canvasWrapper.canvas.style['pointer-events'] = tool == 'pointer' ? 'none' : 'auto'
  );
}
function switchCanvas(event) {
    let slide = Reveal.getCurrentSlide();
    isMousedown = false
    lineWidth = 0

    let shown = db.layers.where({slide: slide.id})
    shown.count()
	 .then(ct => { 
		if(ct > 0) { 
	           shown.each(initializeLayer).then(() => updateTool())
		} else {
	    	   let layer = { slide: slide.id, visible: true, zindex: 1 };
	           db.layers
		     .add(layer)
	             .then(id => {
			layer[id]=id;
			initializeLayer(layer);
		     })
		  }
	       })
}
function initializeLayer(layer) {
   if(canvases[layer.id] !== undefined) return;
   let canvas = new SlideCanvas(layer.slide, layer.id);
   canvases[layer.id] = canvas;
   canvas.addEventListeners();
   requestIdleCallback(() => canvas.redraw());
}


function initializePenSettings(config) {
  // set up color/size picker
  var swatches = config.pen.swatches;
  function updateColor(color, force=false) {
    if(color == swatches[0] ) { 
      updateTool('pen'); 
      strokeStyle = color;
      strokePersistence = config.pen['highlight-fade-time'];  
    } else if(color == swatches.at(-2)) { 
      updateTool('eraser'); 
    } else if(color == swatches.at(-1)) { 
      updateTool('pointer'); 
    } else {
      updateTool('pen') 
      strokeStyle = color;
      strokePersistence = Infinity;
    }

    if(force) { 
      var colorPicker = document.querySelector('.coloris')
      colorPicker.value = color
      colorPicker.dispatchEvent(new Event('input', { bubbles: true }));
    }
  }

  document.addEventListener('coloris:pick', event => {
    updateColor(event.detail.color);
  });
   

  var penSettings = document.createElement('div')
    penSettings.setAttribute('class', 'pen-settings circle')
    penSettings.setAttribute('style', 'position: absolute; bottom: 12px; left: 12px; z-index: 11')
  var colorPicker = document.createElement('input')
    colorPicker.setAttribute('type', 'text')
    colorPicker.setAttribute('class', 'coloris')
    colorPicker.setAttribute('value', '#000000')
    penSettings.append(colorPicker)
  
  var reveal = document.querySelector('.reveal')
  var controls = document.querySelector('.controls')
  reveal.insertBefore(penSettings, controls)
  
  Coloris({
  el: '.coloris', 
  theme: 'polaroid',
  swatchesOnly: true,  
  swatches: swatches })

  var hueSelector = document.querySelector('.clr-hue')
  var alphaSelector = document.querySelector('.clr-alpha')
  var sizeSelector  = alphaSelector.cloneNode(true)
    sizeSelector.setAttribute('class', 'clr-size')
  var sizeSlider = sizeSelector.childNodes[0]
  var sizeMarker = sizeSelector.childNodes[1]
  sizeSlider.setAttribute('id', 'size-slider')
  sizeSlider.setAttribute('name', 'size-slider')
  sizeSlider.setAttribute('min',   config.pen['min-size'])
  sizeSlider.setAttribute('max',   config.pen['max-size'])
  sizeSlider.setAttribute('value', config.pen['default-size'])
  sizeMarker.setAttribute('id', 'size-marker')
  sizeMarker.setAttribute('name', 'size-marker')
  sizeSlider.oninput = function() { 
        sizeMarker.style.left = (this.value-this.min) / (this.max-this.min) * 100 + '%';
        toolsize = this.value; 
  }
  
  // initialize state/config variables
  sizeSlider.oninput()
  hueSelector.parentNode.insertBefore(sizeSelector, hueSelector)

  var colorPicker = document.querySelector('.coloris')
  colorPicker.value = swatches[0];
  strokeStyle = swatches[0]
  strokePersistence = config.pen['highlight-fade-time'];  
  fadeSteps = config.pen['highlight-fade-steps'];
  colorPicker.dispatchEvent(new Event('input', { bubbles: true }));
}

SlideCanvas = function(slideid, layerid) {   
  this.layerid = layerid;
  
  let slide = document.getElementById(slideid) 
  let outer_container   = document.createElement('div')
        outer_container.className = 'slide-container'
        outer_container.setAttribute('style', 'position: relative; width: 100%; height: 100%;')
  let canvas = document.createElement('canvas')
        canvas.setAttribute('style', 'position:absolute; top:0; left:0; width:100%; height:100%; z-index: 2;')
  let content_container = document.createElement('div')
        content_container.className = 'slide-content-container'
        content_container.setAttribute('style', 'position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 1')
  Array.from(slide.childNodes).forEach(child => { content_container.append(child) })
  outer_container.append(canvas)
  outer_container.append(content_container)
  slide.append(outer_container)

  canvas.width = outer_container.offsetWidth
  canvas.height = outer_container.offsetHeight

  this.canvas = canvas;
  this.context = canvas.getContext('2d');
}

SlideCanvas.prototype.addEventListeners = function() { 

var thisSlideCanvas = this;
var canvas = this.canvas;
var context = canvas.getContext('2d');
var points = [];

for (const ev of ["touchstart", "mousedown"]) {
  canvas.addEventListener(ev, function (e) {
    if(e.touches && e.touches[0] && e.touches[0].touchType === 'direct') return
    let pressure = 0.1;
    let x, y;
    let r = e.target.getBoundingClientRect();
    if (e.touches && e.touches[0] && typeof e.touches[0]["force"] !== "undefined") {
      if (e.touches[0]["force"] > 0) {
        pressure = e.touches[0]["force"]
      }
      var coords = offsetCoords(e)
      x = coords.x
      y = coords.y
    } else {
      pressure = 1.0
      x = e.offsetX;
      y = e.offsetY;
    }

    isMousedown = true

    lineWidth = Math.log(pressure + 1) * toolsize
    context.lineWidth = lineWidth// pressure * 50;

    points.push({ x, y, lineWidth, strokeStyle })
    thisSlideCanvas.drawOnCanvas(points)
    })
  }

for (const ev of ['touchmove', 'mousemove']) {
  canvas.addEventListener(ev, function (e) {
    if (!isMousedown) return
    if(e.touches && e.touches[0] && e.touches[0].touchType === 'direct') return
    e.preventDefault()

    let pressure = 0.1
    let x, y
    let r = e.target.getBoundingClientRect();
    if (e.touches && e.touches[0] && typeof e.touches[0]["force"] !== "undefined") {
      if (e.touches[0]["force"] > 0) {
        pressure = e.touches[0]["force"]
      }
      var coords = offsetCoords(e)
      x = coords.x
      y = coords.y
    } else {
      pressure = 1.0
      x = e.offsetX;
      y = e.offsetY;
    }

    // smooth line width
    lineWidth = Math.log(pressure + 1) * toolsize * 0.2 + lineWidth * 0.8
    points.push({ x, y, lineWidth, strokeStyle })

    thisSlideCanvas.drawOnCanvas(points);
  })
}

for (const ev of ['touchend', 'mouseup']) {
  canvas.addEventListener(ev, function (e) {
    let pressure = 0.1;
    let x, y;
    if(e.touches && e.touches[0] && e.touches[0].touchType === 'direct') return;
    if (e.touches && e.touches[0] && typeof e.touches[0]["force"] !== "undefined") {
      if (e.touches[0]["force"] > 0) {
        pressure = e.touches[0]["force"]
      }
      var coords = offsetCoords(e)
      x = coords.x
      y = coords.y
    } else {
      pressure = 1.0
      x = e.offsetX;
      y = e.offsetY;
    }

    isMousedown = false
    if(tool==='pen' && points.length > 1) { 
    	stroke = { points: [...points], layerid: thisSlideCanvas.layerid, drawn: Date.now(), erased: Infinity, persistence: strokePersistence }
    	thisSlideCanvas.recordStroke(stroke)
    }    
    points = []; 
  })
}

}

/*
 *
 */


SlideCanvas.prototype.drawOnCanvas = function(stroke) {
    if(tool === 'pen') 
      this.penOnCanvas(stroke)
    if(tool === 'eraser') 
      this.eraserOnCanvas(stroke)
}

SlideCanvas.prototype.penOnCanvas = function(stroke) {
  const context = this.context;
  context.strokeStyle = stroke[0].strokeStyle;
  context.lineCap = 'round'
  context.lineJoin = 'round'

  const l = stroke.length - 1
  if (stroke.length >= 3) {
    const xc = (stroke[l].x + stroke[l - 1].x) / 2
    const yc = (stroke[l].y + stroke[l - 1].y) / 2
    context.lineWidth = stroke[l - 1].lineWidth
    context.quadraticCurveTo(stroke[l - 1].x, stroke[l - 1].y, xc, yc)
    context.stroke()
    context.beginPath()
    context.moveTo(xc, yc)
  } else {
    const point = stroke[l];
    context.lineWidth = point.lineWidth
    context.strokeStyle = point.color
    context.moveTo(point.x, point.y)
    context.stroke()
  }
}

SlideCanvas.prototype.liveStrokes = function(now) { 
  if(now === undefined) 
    now = Date.now()
  const theBeginningOfTime = -Infinity;
  const theEndOfTime = Infinity;
  const layerid = this.layerid;

  return db.strokes
      .where('[layerid+drawn+erased]')
      .between(
	[layerid, theBeginningOfTime, now],
	[layerid, now,                theEndOfTime],
	includeLower=true, includeUpper=true)
}


SlideCanvas.prototype.eraserOnCanvas =  function(eraserstroke) {
  this.liveStrokes()
      .modify(stroke => {
        let erase = false;
        stroke.points.forEach(strokepoint => {
            eraserstroke.forEach(eraserpoint => {
                erase = erase || ((eraserpoint.x - strokepoint.x) ** 2 + (eraserpoint.y - strokepoint.y) ** 2 < toolsize ** 2) 
            })
        })
        if(erase) stroke.erased = now;
    }).then( () => this.redraw() )
}

SlideCanvas.prototype.redraw = function(now) {
  if(now === undefined) 
    now = Date.now()

  this.context.clearRect(0, 0, this.canvas.width, this.canvas.height)
  this.liveStrokes()
      .filter(stroke => stroke.points.length > 1 && now < stroke.drawn + stroke.persistence)
      .each(stroke => {
          let drawnStroke = [];
          this.context.beginPath();
          stroke.map(function (point) {
              point.lineWidth = point.lineWidth * Math.max(0, 1 - (now - stroke.drawn) / stroke.persistence)
              drawnStroke.push(point)
              this.penOnCanvas(drawnStroke)
          })
        })
}


  let context=canvases[1].context
  await canvases[1].liveStrokes()
      .filter(stroke => stroke.points.length > 1 && now < stroke.drawn + stroke.persistence)
      .each(stroke => {
          let drawnStroke = [];
          context.beginPath();
	  console.log('stroke')
          console.log(stroke.map(function (point) {
              point.lineWidth = point.lineWidth * Math.max(0, 1 - (now - stroke.drawn) / stroke.persistence)
              drawnStroke.push(point)
              canvases[1].penOnCanvas(drawnStroke)
          }))
        })

SlideCanvas.prototype.recordStroke = function(stroke) {
   db.strokes 
     .add(stroke)
     .then( () => { 
        if(stroke.persistence < Infinity) 
          for(let i = 0; i < fadeSteps; i++) 
             setTimeout( ()=>this.redraw(), stroke.persistence*i/fadeSteps)
       
     })
}


