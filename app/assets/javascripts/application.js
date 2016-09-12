// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require_tree .
// $ (document).ready(function() {
//   $('#myupToolTip').click(function() {
//       $('.total_vote').html('<%= @post.total_votes %>');
//   });
// });
// $('.vote-arrows')
//     .on('ajax:success', function (e, data, status, xhr) {
//  $('.total_vote').html(@post.data);


//     })
//     .on('ajax:send', function () {
//         $(this).addClass('loading');
//     })
//     .on('ajax:complete', function () {
//         $(this).removeClass('loading');
//     })
//     .on('ajax:error', function (e, xhr, status, error) {
//         console.log(status);
//         console.log(error);
//     })


$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip();
});
// $(document).ready(function() {
//   $('#mydownToolTip').tooltip();
// });
