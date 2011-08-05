$(function() {
  createWYSIWYG('page-content');
  createWYSIWYG('product-content');

  $('*[data-tooltip]').tipsy({
    fade: true,
    gravity: function() {
      var customGravity = this.getAttribute('data-gravity');
      if(customGravity !== undefined && customGravity !== null) {
        return customGravity;
      }
      return 'w';
    },
    opacity: 0.8,
    title: 'data-tooltip'
  });

  $('.fancybox').fancybox();
});

function createWYSIWYG(textareaId) {
    // handle the mini-WYSIWYG
    var textarea = document.getElementById(textareaId);

    $('.insert-paragraph').click(function() {
      var text = '<p></p>\r\n';

      insertAtCursor(text);

      return false;
    });

    $('.insert-green-box').click(function() {
      console.log('foo');
      var text = '<div class="green box">\r\n\t<div class="head">[INSERT TITLE HERE]</div>\r\n\t<div class="body">\r\n\t\t[MAIN BOX CONTENT HERE]\r\n\t</div>\r\n\t<div class="footer"></div>\r\n</div>\r\n';

      insertAtCursor(text);

      return false;
    });

    $('.insert-yellow-box').click(function() {
      var text = '<div class="yellow box">\r\n\t<div class="head">[INSERT TITLE HERE]</div>\r\n\t<div class="body">\r\n\t\t[MAIN BOX CONTENT HERE]\r\n\t</div>\r\n\t<div class="footer"></div>\r\n</div>\r\n';

      insertAtCursor(text);

      return false;
    });

    $('.insert-ul').click(function() {
      var text = '<ul class="bullets">\r\n\t<li></li>\r\n</ul>\r\n';

      insertAtCursor(text);

      return false;
    });

    $('.insert-a').click(function() {
      var text = '<a href="[LINK PATH HERE]">[LINK TEXT HERE]</a>\r\n';

      insertAtCursor(text);

      return false;
    });

    function insertAtCursor(text) {
      if(document.selection) {
        textarea.focus();
        selection = document.selection.createRange();
        selection.text = text;
      } else if(textarea.selectionStart || textarea.selectionStart == '0') {
        var startPosition = textarea.selectionStart;
        var endPosition = textarea.selectionEnd;
        textarea.value = textarea.value.substring(0, startPosition) + text + textarea.value.substring(endPosition, textarea.value.length)
      } else {
        textarea.value += text;
      }
    }
}

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
          depth = $link.parents('ul').size();
          console.log(depth);
          if(e.offsetX < 15*depth) {
            sidebarNavigation._toggle(this, true);
            return false;
          }
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

var mainNavigation = {
  adminFunctions: function(path) {
    var sortableOpts = {
      axis: 'x',
      items: 'li[id]',
      update: function(event, ui) {
        var serializedData = $(this).sortable('serialize');
        $.get(path+'?'+serializedData);
      }
    }

    $('ul#main-nav').sortable(sortableOpts);
  }
}