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

// state
var tool = 'pen';
var toolsize = 10;
var strokeStyle = 'black';
var canvases = {}
var lineWidth;
var isMousedown;

const requestIdleCallback = window.requestIdleCallback || function (fn) { setTimeout(fn, 1) };
document.addEventListener("DOMContentLoaded", function(event) {
    initializePenSettings()
    Reveal.on('ready', switchCanvas)
    Reveal.on('slidechanged', switchCanvas)
}, false)

function switchCanvas(event) {
    isMousedown = false
    lineWidth = 0
    var slide = event.currentSlide;
    if(!(slide.id in canvases)) {
        canvases[slide.id] = [addCanvas(slide)]
    }
}

function initializePenSettings() {
  // set up color/size picker
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
  
  swatches: [
    '#ffffff00',
    '#067bc2',
    '#84bcda',
    '#80e377',
    '#ecc30b',
    '#f37748',
  ], onChange: (color) => { 
                if(color == '#ffffff00') { tool = 'eraser'; }
                else { tool = 'pen'; strokeStyle = color;}
  }})
  var hueSelector = document.querySelector('.clr-hue')
  var alphaSelector = document.querySelector('.clr-alpha')
  var sizeSelector  = alphaSelector.cloneNode(true)
    sizeSelector.setAttribute('class', 'clr-size')
  var sizeSlider = sizeSelector.childNodes[0]
  var sizeMarker = sizeSelector.childNodes[1]
  sizeSlider.setAttribute('id', 'size-slider')
  sizeSlider.setAttribute('min', '5')
  sizeSlider.setAttribute('max', '50')
  sizeSlider.setAttribute('value', '15')
  sizeMarker.setAttribute('id', 'size-marker')
  sizeSlider.oninput = function() { 
        toolsize = this.value; 
  }
  hueSelector.parentNode.insertBefore(sizeSelector, hueSelector)
}



function addCanvas(slide) {
    var outer_container   = document.createElement('div')
        outer_container.className = 'slide-container'
        outer_container.setAttribute('style', 'position: relative; width: 100%; height: 100%;')
    var canvas = document.createElement('canvas')
        canvas.setAttribute('style', 'position:absolute; top:0; left:0; width:100%; height:100%; z-index: 2;')
    var content_container = document.createElement('div')
        content_container.className = 'slide-content-container'
        content_container.setAttribute('style', 'position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 1')
        Array.from(slide.childNodes).forEach(child => { content_container.append(child) })

    outer_container.append(canvas)
    outer_container.append(content_container)
    slide.append(outer_container)

    canvas.width = outer_container.offsetWidth
    canvas.height = outer_container.offsetHeight
    addCanvasListeners(canvas)
    return canvas;
}

function addCanvasListeners(canvas) {
    var context = canvas.getContext('2d');
    var points = []
    var strokeHistory = []

function drawOnCanvas(stroke) {
    if(tool === 'pen') 
        penOnCanvas(stroke)
    if(tool === 'eraser') 
        eraserOnCanvas(stroke)
}

function eraserOnCanvas (eraserstroke) {
    var newStrokeHistory = [];
    strokeHistory.forEach(stroke => {
        var erase = false;
        stroke.forEach(strokepoint => {
            eraserstroke.forEach(eraserpoint => {
                erase = erase || ((eraserpoint.x - strokepoint.x) ** 2 + (eraserpoint.y - strokepoint.y) ** 2 < toolsize ** 2) 
            })
        })
        if(!erase) newStrokeHistory.push(stroke);
    })
    strokeHistory = newStrokeHistory;
    redraw();
}

/**
 * This function takes in an array of points and draws them onto the canvas.
 * @param {array} stroke array of points to draw on the canvas
 * @return {void}
 */
function penOnCanvas (stroke) {
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
    context.beginPath()
    context.moveTo(point.x, point.y)
    context.stroke()
  }
}

/**
 * Remove the previous stroke from history and repaint the entire canvas based on history
 * @return {void}
 */
function undoDraw () {
  strokeHistory.pop()
  redraw();
}

function redraw() {
  context.clearRect(0, 0, canvas.width, canvas.height)

  strokeHistory.map(function (stroke) {
    if (stroke.length > 1) {
        context.beginPath()
        let strokePath = [];
        stroke.map(function (point) {
            strokePath.push(point)
            penOnCanvas(strokePath)
        })
    }
  })
}

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
    drawOnCanvas(points)
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

    // smoothen line width
    lineWidth = Math.log(pressure + 1) * toolsize * 0.2 + lineWidth * 0.8
    points.push({ x, y, lineWidth, strokeStyle })

    drawOnCanvas(points);
  })
}

for (const ev of ['touchend', 'touchleave', 'mouseup']) {
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
    if(tool==='pen') {
        requestIdleCallback(function () { strokeHistory.push([...points]); points = []})
    }
    if(tool==='eraser') { points = []; }
    lineWidth = 0
  })
}
}