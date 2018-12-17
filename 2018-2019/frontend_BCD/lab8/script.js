'use strict';

const { sqrt, round } = Math;

function el(str) {
  if (str.startsWith('#'))
    return document.getElementById(str.slice(1));
  else if (str.startsWith('.'))
    return document.getElementsByClassName(str.slice(1));
}

HTMLElement.prototype.ael = function(str, callback, params) {
  this.addEventListener.call(this, str, callback, params);
}

HTMLCollection.prototype.each = function(callback) {
  Array.prototype.forEach.call(this, callback);
}

el('#result1').ael('click', function() {
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


el('#t2text2').ael('blur', function() {
  const temp = this.value;
  this.value = el('#t2text1').value;
  el('#t2text1').value = temp;
});

el('#t3submit').ael('click', function() {
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

el('#t4check').ael('click', function() {
  const s1 = +el('#t4s1').value;
  const s2 = +el('#t4s2').value;
  const s3 = +el('#t4s3').value;

  if (s1 < s2 + s3 && s2 <= s1 + s3 && s3 <= s1 + s2) {
    el('#t4res').innerText = 'можна побудувати';
  } else {
    el('#t4res').innerText = 'не можна побудувати';
  }
});

// t5
const scaler = el('#scaler');
const { width, height } = el('#t5img').getBoundingClientRect();
// const w = el('#t5img').offsetWidth;
// const h = el('#t5img').offsetHeight;
// console.log(w, h);
scaler.style.backgroundSize = width * 2 + 'px';
// const koefX = 1000 / el('#t4img').offsetWidth;
// const koefY = 1000 / el('#t4img').offsetHeight;
el('#t5img').ael('mousemove', function({ clientX, clientY }) {
  const { left, top } = this.getBoundingClientRect();
  scaler.style.display = 'block';
  scaler.style.left = clientX + 10 + 'px';
  scaler.style.top = clientY + 10 + 'px';

  scaler.style.backgroundPositionX = (-clientX + left) * 2 + width / 4 + 'px';
  scaler.style.backgroundPositionY = (-clientY + top) * 2 + height / 4 + 'px';
});

el('#t5img').ael('mouseleave', function() {
  scaler.style.display = 'none';
})

// t6
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
el('#t6size').ael('input', function() {
  hr.setAttribute('size', this.value);
});

// t7
const prices1 = [100, 150, 120];
const prices2 = [30, 55, 100];
const prices3 = [50, 50, 70];
el('#t7').ael('click', function() {
  this.innerText = '$' +
    (prices1[el('#t71').selectedIndex] +
      prices2[el('#t72').selectedIndex] +
      prices3[el('#t73').selectedIndex]);
});

// t8
el('#t8color').ael('change', function() {
  el('#t8').style.backgroundColor = this.value;
});
el('#t8file').ael('change', function() {
  el('#t8').getElementsByTagName('td').each((el) => {
    el.style.backgroundImage = `url(${this.value})`;
  });
});

// t9
const prices4 = [20, 15, 35, 40];
el('#t9').ael('click', function() {
  this.innerText = (prices4[el('#t9prds').selectedIndex] * +el('#t9num').value) + 'грн.'
});


// t10
el('#t10submit').ael('click', function() {
  el('#t10').value = +el('#t10').value.toString().split('').reverse().join('');
});

// t11
el('#t11num').ael('input', function() {
  let num = +this.value;
  if (isNaN(num)) return;
  let res = '';
  let diver = 1;
  while (true) {
    if ((num / diver) - Math.floor(num / diver) === 0) {
      res += diver + ', ';
      diver++
    } else {
      diver++;
    }
    if (diver > num) break;
  }

  el('#t11').innerText = res.slice(0, res.length - 2);
});

el('#t12').innerText = (() => {
  let res = 0;
  for (let i = 111111; i < 999999; ++i) {
    const str = i.toString();
    if (+str[0] + +str[1] + +str[2] === +str[3] + +str[4] + +str[5]) {
      res++;
    }
  }
  return res;
})();

// t13
function getWeekNumber(d) {
  d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
  d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
  let yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  let weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
  return [d.getUTCFullYear(), weekNo];
}

el('#t13in').ael('input', function() {
  el('#t13').innerText = getWeekNumber(new Date(Date.parse(this.value)))[1];
});

// t14
el('#t14').ael('input', function() {
  el('#t14res').innerText = this.value.trim().replace(/\s+/g, ' ').split(' ').length;
});


// t15
let t15ann = 'a1';
el('#t15img').ael('click', function() {
  t15ann = t15ann === 'a1' ? 'a2' : 'a1';
  this.style.animationName = t15ann;
});

// t12



