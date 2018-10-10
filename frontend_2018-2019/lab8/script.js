'use strict';

const { sqrt, round } = Math;

function el(str) {
  if (str.startsWith('#'))
    return document.getElementById(str.slice(1));
  else if (str.startsWith('.'))
    return document.getElementsByClassName(str.slice(1));
}

HTMLElement.prototype.ael = function (str, callback, params) {
  this.addEventListener(str, callback, params);
}

el('#result1').ael('click', function () {
  const
    len = (x1, y1, x2, y2) => Math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2),
    x1 = el('#x1').value,
    y1 = el('#y1').value,

    x2 = el('#x2').value,
    y2 = el('#y2').value,

    x3 = el('#x3').value,
    y3 = el('#y3').value,

    a = len(x1, y1, x2, y2),
    b = len(x2, y2, x3, y3),
    c = len(x1, y1, x3, y3),
    p = (a + b + c) / 2,
    s = sqrt(p * (p - a) * (p - b) * (p - c));

  this.innerText = round(s * 100) / 100;
});
