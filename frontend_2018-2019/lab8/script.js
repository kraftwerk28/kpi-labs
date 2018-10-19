'use strict';

const { sqrt, round } = Math;

function el(str) {
  if (str.startsWith('#'))
    return document.getElementById(str.slice(1));
  else if (str.startsWith('.'))
    return document.getElementsByClassName(str.slice(1));
}

HTMLElement.prototype.ael = function (str, callback, params) {
  this.addEventListener.call(this, str, callback, params);
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


el('#t2text2').ael('blur', function () {
  const temp = this.value;
  this.value = el('#t2text1').value;
  el('#t2text1').value = temp;
});

el('#t3submit').ael('click', function () {
  const nums = el('#t3')
    .value
    .trim()
    .replace(/\s+/g, ' ')
    .split(' ')
    .map(v => +v);
  const max = Math.max(...nums);
  let res = 0;
  nums.forEach(v => {
    if (v === max) res++;
  });

  el('#t3res').innerText = res;

});

el('#t4check').ael('click', function () {
  const s1 = +el('#t4s1').value;
  const s2 = +el('#t4s2').value;
  const s3 = +el('#t4s3').value;

  if (s1 <= s2 + s3 && s2 <= s1 + s3 && s3 <= s1 + s2) {
    el('#t4res').innerText = 'можна побудувати';
  } else {
    el('#t4res').innerText = 'не можна побудувати';
  }
});


const scaler = el('#scaler');
const w = el('#t5img').offsetWidth;
const h = el('#t5img').offsetHeight;
scaler.style.backgroundSize = w * 2 + 'px';
// const koefX = 1000 / el('#t4img').offsetWidth;
// const koefY = 1000 / el('#t4img').offsetHeight;
el('#t5img').ael('mousemove', function ({ clientX, clientY }) {
  scaler.style.display = 'block';
  scaler.style.left = clientX + 10 + 'px';
  scaler.style.top = clientY + 10 + 'px';

  scaler.style.backgroundPositionX = (-clientX + this.offsetLeft) * 2 + w / 4 + 'px';
  scaler.style.backgroundPositionY = (-clientY + this.offsetTop) * 2 + h / 4 + 'px';
});

el('#t5img').ael('mouseleave', function () {
  scaler.style.display = 'none';
})

const hr = el('#t6');
function t6setAl() {
  const r1 = el('#t6left');
  const r2 = el('#t6center');
  const r3 = el('#t6right');
  hr.setAttribute('align', r1.checked ? 'left' : (r2.checked ? 'center' : 'right'));
}
el('#t6left').oninput = t6setAl;
el('#t6center').oninput = t6setAl;
el('#t6right').oninput = t6setAl;
el('#t6size').ael('input', function () {
  hr.setAttribute('size', this.value);
});


// t10
el('#t10submit').ael('click', function () {
  el('#t10').value = +el('#t10').value.toString().split('').reverse().join('');
});

el('#t14').ael('input', function () {
  el('#t14res').innerText = this.value.trim().replace(/\s+/g, ' ').split(' ').length;
});

el('#cl').ael('change', function () {
  console.log(this.value);
});
