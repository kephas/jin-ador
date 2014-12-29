$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$(document).ready(function($) {
    $('#foobar').on('click', function (event) {
	$.ajax({
	    type: 'GET',
	    url: '/test',
	    data: {number: $(this).attr('href').substr(1)},
	    success: function(result) {
		$('#target').html(result);
	    }
	});
    });
});
