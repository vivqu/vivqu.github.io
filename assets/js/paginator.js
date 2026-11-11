// Image paginator: wraps a .paginator element containing <figure> children.
// Adds prev/next buttons, a counter, arrow-key paging (when focused), and swipe.
(function () {
  document.querySelectorAll('.paginator').forEach(function (root) {
    var slides = Array.prototype.slice.call(root.querySelectorAll(':scope > figure'));
    if (slides.length < 2) return;

    var index = 0;
    var nav = document.createElement('div');
    nav.className = 'paginator-nav';

    var prev = document.createElement('button');
    prev.type = 'button';
    prev.className = 'paginator-prev';
    prev.setAttribute('aria-label', 'Previous image');
    prev.textContent = '←';

    var next = document.createElement('button');
    next.type = 'button';
    next.className = 'paginator-next';
    next.setAttribute('aria-label', 'Next image');
    next.textContent = '→';

    var counter = document.createElement('span');
    counter.className = 'paginator-counter';

    nav.appendChild(prev);
    nav.appendChild(counter);
    nav.appendChild(next);
    root.appendChild(nav);

    function show(i) {
      index = (i + slides.length) % slides.length;
      slides.forEach(function (slide, j) {
        slide.classList.toggle('is-active', j === index);
      });
      counter.textContent = (index + 1) + ' / ' + slides.length;
    }

    prev.addEventListener('click', function () { show(index - 1); });
    next.addEventListener('click', function () { show(index + 1); });

    root.addEventListener('keydown', function (e) {
      if (e.key === 'ArrowLeft') { e.preventDefault(); show(index - 1); }
      else if (e.key === 'ArrowRight') { e.preventDefault(); show(index + 1); }
    });

    var touchX = null;
    root.addEventListener('touchstart', function (e) { touchX = e.changedTouches[0].clientX; }, { passive: true });
    root.addEventListener('touchend', function (e) {
      if (touchX === null) return;
      var dx = e.changedTouches[0].clientX - touchX;
      touchX = null;
      if (Math.abs(dx) < 40) return;
      show(dx < 0 ? index + 1 : index - 1);
    }, { passive: true });

    root.classList.add('is-ready');
    show(0);
  });
})();
