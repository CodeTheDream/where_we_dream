//= require jquery
//= require jquery_ujs
//= require parsley
//= require_tree .
function setCoverHeight() {
  var height = $(window).height();
  $('.cover').height( height );
};

function responsiveCoverHeight() {
  $( window ).resize( setCoverHeight );
};

function toggleMobileNavs() {
  $('#js-navigation-menu li').click( function() {
    $(window).resize( setMobileNavHeight );
    var id = $(this).attr('id');
    if ($('#nav-' + id).css('display') == 'none') {
      $('#mobile-nav').show();
      $('#nav-' + id ).show();
      if (id=='admin') {
        $('#nav-features').hide();
      } else {
        $('#nav-admin').hide();
      }
      setMobileNavHeight();
    } else {
      $('#mobile-nav').hide();
      $('#nav-features').hide();
      $('#nav-admin').hide();
    };
  });
};

function setMobileNavHeight() {
  var headerHeight = $('#header-wrapper').height();
  var height1 = $(window).height() - headerHeight;
  $('#mobile-nav').height( height1 );
  var features = $('.feature:visible').length;
  var featureHeight = $('.feature:visible').height();
  var height2=($(window).height()-(headerHeight+(features*featureHeight)))/(features*2);
  $('.feature:visible').css('padding', height2 + 'px 0');
};

previous = 0;
function autoHideHeader() {
  $(window).scroll(function(){
    // clearTimeout(timer);
    if ($(window).scrollTop() > previous  && $(window).width() <= 768) {  //scroll down
      if ( !( $('#mobile-nav').is(":visible") ) ) {
        $('header').addClass('header--hidden');
      }
    } else {                                                              //scroll up
      $('header').removeClass('header--hidden');
    };
    previous = $(window).scrollTop();
  });
};

// pretty sure we can get rid of this method and make the link remote nah mean
function addQuestionsPartial() {
  $("#new-question").click(
    function() {
      $.ajax({
        url: "/new_question_partial",
        type: "PATCH",
      });
    }
  )
}

function deleteQuestion() {
  $('.destroy-button').click(function() {
    $($(this).closest('div')).hide();
  });
};

function updateQuestion() {
  $(".edit-question").blur(function() {
    sendQuestionUpdate(this);
  }).focus(function(){
    this.addEventListener('keypress', function (e) {
      var key = e.which || e.keyCode;
      if (key === 13) { // once ENTER key is presssed, do this:
        $(this).blur();
      }} // close e function
    );
  });
};

function sendQuestionUpdate(question) {
  var value = $(question).val();
  var id = $(question).attr('id');
  $.ajax({
    url: "/admin/questions/" + id,
    type: "PATCH",
    data: {
      'question' : {
        'value': value
      }
    }
  })
}

function makeTextareaElastic() {
  $(window).on('load resize', function() {
    goThruArray();
  });
};

function goThruArray() {
  if ($('.edit-question').length > 0) {
    var array = $('.edit-question');
  } else {
    var array = $('.details');
  }
  $.each(array, function() {
    $(this).height(this.scrollHeight - 4);
  });
}

function showAdditionalDetails() {
  $(window).on('load', function() {
    $.each($('.rule'), function() {
      var val = $('input:checked',$(this)).val();
      if (val == "true" || val == "false") {
        $('.details-container', $(this)).show()
      };
    });
  });
  $('input[type="radio"]').click(function() {
    var val = $(this).val();
    var container = $('.details-container',$($(this)).closest('.rule'));
    if (val == "true" || val == "false") {
      container.show()
      goThruArray();
    } else {
      container.hide()
    }
  });
};

function clickableTableRows(){
  $('*[data-href]').click(function(){
    window.location = $(this).data('href');
    return false;
  });
};

function toggleDropdown() {
  $(".dropdown-button").click(function() {
    var button = $(this);
    var menu = button.siblings(".dropdown-menu");
    menu.toggleClass("show-menu");
    menu.children("li").click(function() {
      menu.removeClass("show-menu");
    });
  });
};

function addNewReply(){
  $('.reply').click(function() {
    var clicked = $(this);
    var comment_id = clicked.attr('comment-id');
    var comment = clicked.closest('.comment');
    var name = $('.comment-name', comment).html() + ", ";
    if ($("#new_reply").length > 0) {
      var new_comment = $('#new_reply');
    } else {
      var new_comment = $('form').clone().attr('id','new_reply');
      $('.user-image', new_comment).addClass('reply-spacing reply-image').removeClass('user-image');
      $('.new-comment-container', new_comment).addClass('reply-spacing');
    };
    $('textarea', new_comment).val(name).attr('rows',2)
    $('.original-comment-id', new_comment).attr('value', comment_id);
    comment.after(new_comment);
    elasticNewCommentInput();
  });
};

function toggleOpinions(){
  $('.opinion').click(function(){
    var clicked = $(this);
    var sibling = clicked.siblings(".opinion");
    var opinionable = clicked.closest(".opinionable");
    var opinionable_id = opinionable.attr("id");
    if (opinionable.is(".comment")) {
      var opinionable_type = "Comment";
    } else if (opinionable.is(".school")) {
      var opinionable_type = "School";
    } else if (opinionable.is(".scholarship")) {
      var opinionable_type = "Scholarship";
    } else if (opinionable.is(".story")) {
      var opinionable_type = "Story";
    }
    if (clicked.hasClass("fa-thumbs-up")) {
      clicked.siblings(".likes").toggleClass("hide");
      clicked.siblings(".dislikes").addClass("hide");
      clicked.toggleClass("liked");
      sibling.removeClass("disliked");
    } else {
      clicked.siblings(".dislikes").toggleClass("hide");
      clicked.siblings(".likes").addClass("hide");
      clicked.toggleClass("disliked");
      sibling.removeClass("liked");
    };
    var liked = clicked.is(".liked");
    var disliked = clicked.is(".disliked");
    if (liked) {
      value = true;
    } else if (disliked) {
      value = false;
    } else {
      value = ""
    }
    $.ajax({
      url: "/opinions",
      type: "POST",
      data: {
        'like' : {
          'opinionable_id': opinionable_id,
          'opinionable_type': opinionable_type,
          'value': value
        }
      }
    })
  });
};

function elasticNewCommentInput(){
  $('.new-comment').keyup(function() {
    var height = this.scrollHeight;
    var rows = (height - 10)/19
    $(this).attr('rows',rows)
  });
};

function commentOptions(){
  $('span.dropdown li').click(function() {
    var action = $(this).html();
    var comment = $(this).closest('.comment');
    var id = comment.attr('id');
    if (!(comment.is('.comment-reply'))) {
      comment = $(this).closest('.comment-thread')
    }
    if (action == "Remove this comment") {
      comment.replaceWith('<div class="comment-deleted">Comment deleted.</div>')
      $('.comment-deleted').fadeOut(3000);
      $.ajax({
        url: "/comments/" + id + "/delete",
        type: "DELETE",
      });
    } else if (action == "Edit") {
      // console.log("edit")
    } else {
      // console.log("report")
    };
  });
};

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.profile-pic-account').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

function showChosenProfilePic() {
  $("#profilePicFileField").change(function () {
    readURL(this);
  });
};

function loadLikesBars() {
  $(window).load(function(){
    $.each($(".likes-bar"), function() {
      $(this).css("width", $(this).attr("width") + "%");
    });
    $.each($(".no-opinions-bar"), function() {
      $(this).css("background-color", "lightgray")
    });
  })
}

function moveAnchorTags() {
  $(window).on("hashchange", function() {
    if ($(window).width() > 768) {
      old_position = $(window).scrollTop()
      new_position = old_position - 85;
      window.scrollTo(window.scrollX, new_position)
    };
  });
}

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNavs);
$(autoHideHeader);
$(addQuestionsPartial);
$(deleteQuestion);
$(updateQuestion);
$(showAdditionalDetails);
$(makeTextareaElastic);
$(clickableTableRows);
$(toggleDropdown);
$(addNewReply);
$(toggleOpinions);
$(elasticNewCommentInput);
$(commentOptions);
$(showChosenProfilePic);
$(loadLikesBars);
$(moveAnchorTags);
