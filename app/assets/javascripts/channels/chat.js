App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function(){},
  disconnected: function(){},
  received: function(data){
      $('.messages_input').val("");
      $('.messages').html(data['message']);
  }
})