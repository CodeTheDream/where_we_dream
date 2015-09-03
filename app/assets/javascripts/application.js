//= require jquery
//= require jquery_ujs
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
      $('header').addClass('header--hidden');
    } else {                                                              //scroll up
      $('header').removeClass('header--hidden');
    };
    previous = $(window).scrollTop();
  });
};

function addQuestionsPartial() {
  $("#new-question").click(
    function() {
      // $(this).hide();
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
        // sendQuestionUpdate(this);
        $(document.activeElement).blur();
      }} // close e function
    );
  });
};

function sendQuestionUpdate(question) {
  var value = $(question).val();
  var id = $(question).attr('id');
  console.log(value);
  console.log(id);
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

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNavs);
$(autoHideHeader);
$(addQuestionsPartial);
$(deleteQuestion);
$(updateQuestion);
