window.tldreveal = window.tldreveal || {
  id: 'tldreveal',
  init: function (deck) {
     let doctitle = document.head.querySelector('title').text.replace(/\s/g, "-");
     document.querySelector('.reveal').setAttribute('data-tlid', doctitle);
     Tldreveal.Tldreveal().init(deck);
  }
};
