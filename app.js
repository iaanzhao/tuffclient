document.querySelectorAll('.nav-btn').forEach(function (btn) {
  btn.addEventListener('click', function () {
    document.querySelectorAll('.nav-btn').forEach(function (b) { b.classList.remove('active'); });
    document.querySelectorAll('.section').forEach(function (s) { s.classList.remove('active'); });
    btn.classList.add('active');
    document.getElementById(btn.dataset.section).classList.add('active');
  });
});

if ('serviceWorker' in navigator) {
  var swReady = navigator.serviceWorker.register('/sw.js').then(function () {
    if (navigator.serviceWorker.controller) return;
    return new Promise(function (r) {
      navigator.serviceWorker.addEventListener('controllerchange', r, { once: true });
    });
  });

  document.addEventListener('click', function (e) {
    var link = e.target.closest('a[href*="/files/"]');
    if (!link) return;
    e.preventDefault();
    swReady.then(function () { location.href = link.href; });
  });
}
