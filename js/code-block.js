function openTab(evt, tabName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";
}

function createTabs(tabData) {
    let tabs = '';
    let content = '';
  
    for (let i = 0; i < tabData.length; i++) {
      let tabName = tabData[i].name;
      let tabContent = tabData[i].content;
  
      tabs += `<button class="tablinks" onclick="openTab(event, '${tabName}')">${tabName}</button>\n`;
  
      content += `<div id="${tabName}" class="tabcontent">\n<pre id="${tabName.toLowerCase()}" class="code-block active">\n${tabContent}\n</pre>\n</div>\n`;
    }
  
    return `<div class="tab">\n${tabs}\n</div>\n${content}`;
  }
  
  
