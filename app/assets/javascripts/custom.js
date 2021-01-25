callback = function() {
  console.log("callback called!")
  div = this.childNodes[3]
  div.style.display = ""
  for (let i=0; i<menus.length; i++) {
    if (this != menus[i]) {
      menus[i].childNodes[3].style.display = "none"
    }
  }
}

function onload() {
  console.log("onload called!")
  menus = document.getElementsByClassName("ilist")
  for (let i=0; i<menus.length; i++) {
    menus[i].childNodes[3].style.display = "none"
  }
  for (let i=0; i<menus.length; i++) {
    menus[i].onclick = callback
  }
}
document.addEventListener("DOMContentLoaded", onload);
