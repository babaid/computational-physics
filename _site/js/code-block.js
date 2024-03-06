function changeTab(language) {
  var tabs = document.getElementsByClassName('tab');
  for (var i = 0; i < tabs.length; i++) {
      tabs[i].className = tabs[i].className.replace(' active', '');
  }
  document.getElementById(language).style.display = 'none';
  document.getElementById('python').style.display = 'none';
  document.getElementById('javascript').style.display = 'none';
  document.getElementById('java').style.display = 'none';
  document.getElementById(language).style.display = 'block';
  event.currentTarget.className += ' active';
}