$(document).ready(function(){

  var $inputText = $('#input_text').val();

    var createChatMessage = function() {
      $.ajax({
        url: '/chats',
        method: 'post',
        dataType: 'json',
        data: {
          // input_text:,
        },
        success: function (response) {
          console.log(response); // update the page with the response somehow
        }
      });

    };

  // $('#speak').on('click', createChatMessage);

});

