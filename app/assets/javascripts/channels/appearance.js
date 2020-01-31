App.chat = App.cable.subscriptions.create("AppearanceChannel", {
    connected: function(){
        console.log("connected");
    },
    disconnected: function(){
        console.log("disconnected");
    },
    received: function(data){
        $('.online_count').html("Online Users: "+data['users']);
    }
})