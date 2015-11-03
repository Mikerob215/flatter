$(document).ready(function() {
//  Hide all change divs until user clicks edit
  $('.hideme').hide();
// Display editor divs when edit button clicked
  $('.edit-username').on('click', function(event) {
    event.preventDefault();
    $('.edit-uname').show();
  });
  $('.edit-email').on('click', function(event) {
    event.preventDefault();
    $('.changeemail').show();
  });
  $('.edit-location').on('click', function(event) {
    event.preventDefault();
    $('.changelocation').show();
  });
  $('.edit-about').on('click', function(event) {
    event.preventDefault();
    $('.changeabout').show();
  });
  $('.edit-password').on('click', function(event) {
    event.preventDefault();
    $('.changepassword').show();
  });
  $('.delete-account').on('click', function(event) {
    event.preventDefault();
    $('.deleteaccount').show();
  });

// Hide editor divs if user clicks cancel
$('.cancelme').on('click', function(event) {
  event.preventDefault();
  $(this).closest('div').hide();
});
// Character count
$('.text').keyup(function() {
    var cs = $(this).val().length;
    $('.count').text(cs + " characters");
});
// Follow
$('.follow').click(function(event) {
  var username = $('.follow').siblings('.username').text();
  console.log(username);
  $.post("/follow", { followname: username } );
});
});
