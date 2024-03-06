function changeTab(tab, language) {
  var tabs = tab.parentNode.getElementsByClassName('tab');
  for (var i = 0; i < tabs.length; i++) {
      tabs[i].className = tabs[i].className.replace(' active', '');
  }
  var codeBlocks = tab.parentNode.nextElementSibling.getElementsByTagName('pre');
  for (var i = 0; i < codeBlocks.length; i++) {
      codeBlocks[i].style.display = codeBlocks[i].className === language ? 'block' : 'none';
  }
  tab.className += ' active';
}