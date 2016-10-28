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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


$(document).ready(function(){
  $('#mymodal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var filename = button.data('filename') // Extract info from data-* attributes
    var desc = button.data('desc')
    var name = button.data('name')
    var lastname = button.data('lastname')
    var comments = button.data('comments')
    var mail = button.data('mail')
    var vurl = button.data('vurl')
    var modal = $(this)
    var player = videojs('my-video')   

    modal.find('.modal-title').text(filename)
    modal.find('#desc').text(desc)
    modal.find('#user').text(name + ' ' + lastname + ' said: ')
    modal.find('#comments').text(comments)
    modal.find('#contact').text(mail)

    player.src(vurl)
    player.play()
  })
  $('#mymodal').on('hidden.bs.modal', function (event) {
  	var modal = $(this)
  	var player = videojs('my-video')
  	console.log('Good to go!')
  	player.pause()
  	player.src('')
  })
})
