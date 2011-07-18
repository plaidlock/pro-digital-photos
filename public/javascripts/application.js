$(function() {
  $('*[data-tooltip]').tipsy({
    fade: true,
    gravity: 'w',
    opacity: 0.8,
    title: 'data-tooltip'
  });
});

function createSidebarNavigationTree() {
  var $sidebarNavigation = $('ul#sidebar-navigation');
  var $links = $sidebarNavigation.find('a');
  
  $.each($links, function(i, link) {
    var $link = $(link);
    var $subNav = $link.parent().children('ul');
    if($subNav.size() !== 0) {
      $link.click(function(e) {
        toggle(this, true);
        return false; 
      });
    }    
  });

  
  // Now expand the proper path
  var path = window.location.pathname;
  var $currentLink = $('a[data-path="'+path+'"]');
  var $parentLinks = $currentLink.parents('ul li').children('a');
  $.each($parentLinks, function(i, item) {
    toggle(item);
  });
  
  
  // Helper functions
  function toggle(link, animate) {
    // ensure we have a jQuery object
    var $link = $(link);
    
    $link.toggleClass('active');
    if(animate === true) {
      $link.parent('li').children('ul').slideToggle('fast');
    } else {
      $link.parent('li').children('ul').toggle();
    }
  }
}