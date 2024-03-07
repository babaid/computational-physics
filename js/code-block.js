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

  // Get the note element within the parent
  var note = parent.querySelector('.CppNote');
  // Check if the C++ tab is selected
  if (codeName === 'Cpp' && note) {
    // If it is, display the note
    note.style.display = 'block';
  } else if (note) {
    // If it's not, hide the note
    note.style.display = 'none';
  }
}




window.onload = function() {
  var codeBlocks = document.getElementsByClassName("code-block");
  for (var i = 0; i < codeBlocks.length; i++) {
    codeBlocks[i].querySelector(".defaultOpen").click();
  }

  // var codeBlocks = document.getElementsByClassName('tabcontent');


  //   var codeContents = document.getElementsByClassName('tabcontent');
  //   var maxHeight = 0;
  
  //   // Find the maximum height
  //   for (var i = 0; i < codeContents.length; i++) {
  //     if (codeContents[i].clientHeight > maxHeight) {
  //       maxHeight = codeContents[i].clientHeight;
  //     }
  //   }
  
  //   // Set the height of all code contents to the maximum height
  //   for (var i = 0; i < codeContents.length; i++) {
  //     codeContents[i].style.height = 2.5*maxHeight + 'px';
  //   }
  

  
};
