function openCode(evt, codeName) {
  var i, tabcontent, tablinks;
  var parent = evt.currentTarget.parentElement.parentElement;
  tabcontent = parent.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = parent.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  parent.querySelector(`.${codeName}`).style.display = "block";
  evt.currentTarget.className += " active";

  // Get the note element
  var note = document.getElementById('CppNote');
  // Check if the C++ tab is selected
  if (codeName === 'Cpp') {
    // If it is, display the note
    note.style.display = 'block';
  } else {
    // If it's not, hide the note
    note.style.display = 'none';
  }
}


// Get the element with id="defaultOpen" and click on it
window.onload = function() {
  var codeBlocks = document.getElementsByClassName("code-block");
  for (var i = 0; i < codeBlocks.length; i++) {
    codeBlocks[i].querySelector(".defaultOpen").click();
  }
};
