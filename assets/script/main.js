---
---
function onAutoLoad() {
  // https://katex.org/docs/supported.html
  renderMathInElement(document.body, {
      delimiters: [
        {left: '$$', right: '$$', display: true},
        {left: '$', right: '$', display: false}
      ],
      macros: {
        '\\greenhl': '\\textcolor{#{{ site.text_colors.green }}}{#1}',
        '\\bluehl': '\\textcolor{#{{ site.text_colors.blue }}}{#1}',
        '\\redhl': '\\textcolor{#{{ site.text_colors.red }}}{#1}',
        '\\dredhl': '\\textcolor{#{{ site.text_colors.darkred }}}{#1}',
        '\\purplehl': '\\textcolor{#{{ site.text_colors.purple }}}{#1}',
        '\\tealhl': '\\textcolor{#{{ site.text_colors.teal }}}{#1}'
      }
  });
}
