export function addShowOnlyTabpanelEvent(menu_class, tabpanel_class) {
   var menus = document.getElementsByClassName(menu_class);
    //console.log(menus);
    for(var i=0;i<menus.length;i++){
      console.log(menus[i]);
        menus[i].addEventListener('click', function(event) {
            //event.preventDefault();
            console.log(this);
            var tabid=this.getAttribute("href").slice(1);
            // we add extra tabpanel attribute to menu in R
            if (this.getAttribute("tabpanel") === "hide"){
              event.preventDefault();
              showOnlyTabpanelOf(tabid, tabpanel_class);

            }
            changeArriaCurrent(this.getAttribute("id"), menu_class);

            }, false);

    }
    var first_tabid = document.getElementsByClassName(menu_class)[0]
      .getAttribute("href")
      .slice(1);
    console.log(first_tabid);
    showOnlyTabpanelOf(first_tabid, tabpanel_class);
}

function changeArriaCurrent(menuid, menu_class) {
  var menus = document.getElementsByClassName(menu_class);
  for(var i=0;i<menus.length;i++){
    menus[i].removeAttribute("aria-current");
  }
   var menu = document.getElementById(menuid);
   console.log(menu);
   menu.setAttribute("aria-current", "page");
}

function showOnlyTabpanelOf(tabid, tabpanel_class) {
    var tabpanel = document.getElementsByClassName(tabpanel_class);
    for(var i=0;i<tabpanel.length;i++){
    tabpanel[i].hidden = true;
    }
    document.getElementById(tabid).hidden = false;
}


