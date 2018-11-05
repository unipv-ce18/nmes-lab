---
---
function onAutoLoad() {
  // https://katex.org/docs/supported.html

  const texMacros = {
      '\\greenhl': '\\textcolor{#{{ site.text_colors.green }}}{#1}',
      '\\bluehl': '\\textcolor{#{{ site.text_colors.blue }}}{#1}',
      '\\redhl': '\\textcolor{#{{ site.text_colors.red }}}{#1}',
      '\\dredhl': '\\textcolor{#{{ site.text_colors.darkred }}}{#1}',
      '\\purplehl': '\\textcolor{#{{ site.text_colors.purple }}}{#1}',
      '\\tealhl': '\\textcolor{#{{ site.text_colors.teal }}}{#1}'
  }

  function replaceTex(node, isDisplay) {
    let el = document.createElement(isDisplay ? 'div' : 'span');
    el.classList.add(isDisplay ? 'equation' : 'inline-equation');
    katex.render(node.text, el, { displayMode: isDisplay, macros: texMacros });
    node.replaceWith(el);
  }

  let inlineTex = document.querySelectorAll('script[type="math/tex"]');
  for (item of inlineTex) replaceTex(item, false);

  let displayTex = document.querySelectorAll('script[type="math/tex; mode=display"]');
  for (item of displayTex) replaceTex(item, true);

  // Autoload TeX surrounded by $$ and $ in HTML body
  renderMathInElement(document.body, {
      delimiters: [
        {left: '$$', right: '$$', display: true},
        {left: '$', right: '$', display: false}
      ],
      macros: texMacros
  });
}
