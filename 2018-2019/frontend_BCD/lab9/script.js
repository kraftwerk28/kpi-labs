$(function () {
  $('table:nth-of-type(1) tr td').append('<p>текст у клітинці</p>');
  $('table:nth-of-type(1) tr td[colspan]').css('background', 'red');
  $('table:nth-of-type(1) tr td[rowspan]').css('font-size', '200%');

  $('table:nth-of-type(3) tr td').append('<p>текст у клітинці</p>');
  $('table:nth-of-type(3)').css('background', 'blue');
  $('table:nth-of-type(3) tr:nth-of-type(3n) td').css('font-style', 'italic');
  $('table:nth-of-type(3) tr:nth-of-type(n + 3) td')
    .css('text-transform', 'uppercase');

  $('table:nth-of-type(4) tr:nth-of-type(1) td')
    .append('<pre>текст у клітинці</pre>');
  $('table:nth-of-type(4) tr:nth-of-type(1) td:nth-of-type(2n)')
    .css('background', 'green');
  $('table:nth-of-type(4) tr:nth-of-type(1) td:nth-of-type(n + 2)')
    .append('<hr>');
  $('table:nth-of-type(4) tr:nth-last-of-type(1) td:nth-of-type(1)')
    .append(`
    <ul>
      <li>1 рядок</li>
      <li>2 рядок</li>
      <li>3 рядок</li>
      <li>4 рядок</li>
    </ul>
  `);
  setTimeout(() => {
    $('table:nth-of-type(4) tr:nth-last-of-type(1) td:nth-of-type(1) ul li')
      .each(function () {
        alert($(this).text());
      });
  }, 100);

});
