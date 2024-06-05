window.RevealSVGPanZoom = window.RevealSVGPanZoom || {
  id: 'RevealSVGPanZoom',
  init: function (deck) {
    initRevealSVGPanZoom(deck);
  }
};

const initRevealSVGPanZoom = function (Reveal) {

  // generalizing a svg-pan-zoom example from 2 -> n
  var couplePanZooms = function (from, tos) {
    from.setOnZoom(function (level) {
      tos.forEach(function (to) {
        if (to !== from) {
          to.zoom(level);
          to.pan(from.getPan());
        }
      });
    });
    from.setOnPan(function (pan) {
      tos.forEach(function (to) {
        if (to !== from) {
          to.pan(pan);
        }
      });
    });
  };

  // borrowed directly from svg-pan-zoom example
  var beforePan = function (oldPan, newPan) {
    var stopHorizontal = false, 
        stopVertical = false, 
        gutterWidth = 100, 
        gutterHeight = 100,
      // Computed variables
      sizes = this.getSizes(),
      leftLimit = -((sizes.viewBox.x + sizes.viewBox.width) * sizes.realZoom) + gutterWidth,
      rightLimit = sizes.width - gutterWidth - (sizes.viewBox.x * sizes.realZoom),
      topLimit = -((sizes.viewBox.y + sizes.viewBox.height) * sizes.realZoom) + gutterHeight,
      bottomLimit = sizes.height - gutterHeight - (sizes.viewBox.y * sizes.realZoom);

    var customPan = {};
    customPan.x = Math.max(leftLimit, Math.min(rightLimit, newPan.x));
    customPan.y = Math.max(topLimit, Math.min(bottomLimit, newPan.y));

    return customPan;
  };

  var onSlide = function(slide) {
    const config = Reveal.getConfig();
    
    var svgs = Array.from(slide.querySelectorAll('svg, object.img'));
    var slidePanZooms = svgs.map(function (svg) {
        var options = { zoomEnabled: true, 
                        minZoom: 1, 
                        beforePan: beforePan, 
                        controlIconsEnabled: config.panzoom.controls && svg === svgs.at(-1) };
        return svgPanZoom(svg, options);
    });
    slidePanZooms.forEach(function (from) { couplePanZooms(from, slidePanZooms); });
  }
  
  Reveal.addEventListener('slidechanged', function (event) { onSlide(event.currentSlide); });
  window.addEventListener('load', function () { onSlide(Reveal.getCurrentSlide()); });
};
