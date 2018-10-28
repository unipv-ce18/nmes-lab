function getClassColor(cl) {
  let elem = document.querySelector('.' + cl);
  if (elem === null) return '#ffffff';

  let rgbDef = getComputedStyle(elem)['color'];
  let parts = rgbDef.substring(4, rgbDef.length - 1).split(', ');

  return '#' + parseInt(parts[0]).toString(16) +
               parseInt(parts[1]).toString(16) +
               parseInt(parts[2]).toString(16);
}

function onAutoLoad() {
  // https://katex.org/docs/supported.html
  renderMathInElement(document.body, {
      delimiters: [
        {left: '$$', right: '$$', display: true},
        {left: '$', right: '$', display: false}
      ],
      macros: {
        '\\greenhl': '\\textcolor{#' + getClassColor('greenhl') + '}{#1}',
        '\\bluehl': '\\textcolor{#' + getClassColor('bluehl') + '}{#1}',
        '\\redhl': '\\textcolor{#' + getClassColor('redhl') + '}{#1}',
        '\\dredhl': '\\textcolor{#' + getClassColor('dredhl') + '}{#1}'
      }
  });
}
