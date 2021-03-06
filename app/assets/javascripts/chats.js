$(document).ready(function(){

    var createChat = function() {

      var $chatLanguage = $('#chat_language').val();
      var $chatLanguageText = $("#chat_language option:selected").text();
        $.ajax({
          url: '/chats',
          method: 'post',
          dataType: 'json',
          data: {
            language: $chatLanguage
          },
          success: function (response) {
            $("#chat_language option[value=" + $chatLanguage + "]").remove();
            var $chat = $('<li/>');         // Add li for the new chat
            var $chatLink = $('<a/>');      // Add link for the new chat
            $chatLink.attr("href","/chats/" + response.id);
            $chatLink.text($chatLanguageText);
            $chat.append($chatLink);

            var $form = $('<form/>');
            $form.attr('action', "/chats/" + response.id)

            var $button = $('<button/>');
            $button.text('x');
            $button.attr("href","/chats/" + response.id);
            $button.addClass('show_delete_chat');
            $form.append($button);
            $chat.append($form);
            $('#my_chats ul').prepend($chat);
          }
        });

    };

    var deleteChat = function(event) {
      event.preventDefault();
      var $this = $(this);
      $this.closest('li').remove(); // removes the li from the page of the remove link you click

      $.ajax({
        url: $this.closest('form').attr('action'),
        method: 'post',
        dataType: 'json',
        data: {
          "_method":"delete",
        },
        success: function (response) {
          // GREAT SUCCESS
        }
      });
      return false;
    };

  $('#new_chat_button').on('click', function() {
    $('#new_chat').toggle();
  })
  $('#create_new_chat').on('click', createChat);
  $('#my_chats').on('click', '.show_delete_chat', deleteChat);

});