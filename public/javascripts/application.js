$(function() {
  $('*[data-tooltip]').tipsy({
    fade: true,
    gravity: 'w',
    opacity: 0.8,
    title: 'data-tooltip'
  });
});

var sidebarNavigation = {
  _toggle: function(link, animate) {
    // ensure we have a jQuery object
    var $link = $(link);
    
    $link.toggleClass('active');
    if(animate === true) {
      $link.parent('li').children('ul').slideToggle('fast');
    } else {
      $link.parent('li').children('ul').toggle();
    }
  },
  create: function() {
    var $sidebarNavigation = $('ul#sidebar-navigation');
    var $links = $sidebarNavigation.find('a');

    $.each($links, function(i, link) {
      var $link = $(link);
      var $subNav = $link.parent().children('ul');
      if($subNav.size() !== 0) {
        $link.click(function(e) {
          sidebarNavigation._toggle(this, true);
          return false; 
        });
      }    
    });
    
    // Now expand the proper path
    var path = window.location.pathname;
    var $currentLink = $('a[data-path="'+path+'"]');
    var $parentLinks = $currentLink.parents('ul li').children('a');
    $.each($parentLinks, function(i, item) {
      sidebarNavigation._toggle(item, false);
    });
  },
  adminFunctions: function(path) {
    var sortableOpts = {
      axis: 'y',
      update: function(event, ui) {
        var serializedData = $(this).sortable('serialize');
        $.get(path+'?'+serializedData);
      }
    }
    
    $('ul#sidebar-navigation, ul#sidebar-navigation * ul').sortable(sortableOpts);
  }
}