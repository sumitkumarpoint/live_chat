App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function(){
      console.log("connected");
  },
  disconnected: function(){
      console.log("disconnected");
  },
  received: function(data){
      $('.messages_input').val("");
      $('.messages').html(data['message']);
  }
})