// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$( document ).ready(function() {

	if($(".song") || $(".playlist"))
	{
		$(".btn-danger").click(function() {
			var classe = $(this).attr("id").split('_').shift();
			var id = $(this).attr("id").split('_').pop();
			var row = $(this).closest("."+classe)

			if(confirm("Are you sure to delete this "+classe+" ?"))
				$.ajax({
					type: "POST",
					url: "/"+classe+"s/"+id,
					dataType: "json",
					data: {"_method":"delete"},
					complete: function(){
						flash(classe+" Successfully deleted");
						row.remove();
					}
				});
		});

		$(".dropdown-menu a").click(function() {
			var id = $(this).attr("id").split('_').pop();
			var song = $(this).closest("ul").attr("id").split('_').pop();
			var that = $(this);
			var action = "add_song";

			if(that.hasClass("remove")) action = "remove_song";

			$.ajax({
				type: "POST",
				url: "/playlists/"+id+"/"+action+"/"+song,
				dataType: "json",
				data: {"_method": action},
				complete: function(){
					
					that.toggleClass("add remove");
					if(action == "add_song"){
						that.prepend('<span class="glyphicon glyphicon-ok"></span> ');
						flash("Song Successfully Added to "+that.text());
					}
						
					else{
						flash("Song Successfully removed from "+that.text());
						that.html(that.text());
					}
				}
			});
		});
	}
});

function flash(msg){
	$('main').prepend('<div class="alert alert-success"><button aria-hidden="true" class="close" data-dismiss="alert" type="button">×</button><div id="flash_notice">'+msg+'</div></div>');
}

function toggle_added(that){
	if(that.children()){
		that.has("span").remove();
	}
	else{
		that.prependTo('<span class="glyphicon glyphicon-ok"></span>');
	}
}