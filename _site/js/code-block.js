// function openTab(evt, tabName) {
//   // Declare all variables
//   var i, tabcontent, tablinks;

//   // Get all elements with class="tabcontent" and hide them
//   tabcontent = document.getElementsByClassName("tabcontent");
//   for (i = 0; i < tabcontent.length; i++) {
//     tabcontent[i].style.display = "none";
//   }

//   // Get all elements with class="tablinks" and remove the class "active"
//   tablinks = document.getElementsByClassName("tablinks");
//   for (i = 0; i < tablinks.length; i++) {
//     tablinks[i].className = tablinks[i].className.replace(" active", "");
//   }

//   // Show the current tab, and add an "active" class to the button that opened the tab
//   document.getElementById(tabName).style.display = "block";
//   evt.currentTarget.className += " active";
// }

// function createTabs(tabData, idPrefix) {
//   let tabs = '';
//   let content = '';

//   for (let i = 0; i < tabData.length; i++) {
//     let tabName = tabData[i].name;
//     let tabContent = tabData[i].content;

//     // Append the idPrefix to the id
//     let id = idPrefix + tabName;

//     tabs += `<button class="tablinks" onclick="openTab(event, '${id}')">${tabName}</button>\n`;

//     content += `<div id="${id}" class="tabcontent">\n<pre id="${id.toLowerCase()}" class="code-block active">\n${tabContent}\n</pre>\n</div>\n`;
//   }

//   return `<div class="tab">\n${tabs}\n</div>\n${content}`;
// }


function openTab(evt, tabName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get the parent element of the clicked tab
  var parent = evt.currentTarget.parentElement;

  // Get all sibling elements with class="tabcontent" and hide them
  tabcontent = parent.querySelectorAll(".tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all sibling elements with class="tablinks" and remove the class "active"
  tablinks = parent.querySelectorAll(".tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";
}



function createTabs(tabData, idPrefix) {
  let tabs = '';
  let content = '';

  for (let i = 0; i < tabData.length; i++) {
    let tabName = tabData[i].name;
    let tabContent = tabData[i].content;

    // Append the idPrefix to the id
    let id = idPrefix + tabName;

    tabs += `<button class="tablinks" onclick="openTab(event, '${id}')">${tabName}</button>\n`;

    content += `<div id="${id}" class="tabcontent">\n<pre id="${id.toLowerCase()}" class="code-block active">\n${tabContent}\n</pre>\n</div>\n`;
  }

  return `<div class="tab">\n${tabs}\n</div>\n${content}`;
}