function createSidebarNavigationTree() {
  var $sidebarNavigation = $('ul#sidebar-navigation');
  
  $.each($sidebarNavigation.find('ul'), function(i, ul) {
    var $ul = $(ul);
    var $parentLink = $ul.parent().children('a');
    
    $parentLink.click(function(e) {
      if(e.offsetX < 25) {
        $parentLink.toggleClass('active');
        $ul.slideToggle('fast');
        console.log(e);
        return false; 
      }
    });
  });
  
  // Now expand the proper path
}