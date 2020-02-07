function check_online(){
    // alert("A")
    App.chat = App.cable.subscriptions.create("AppearanceChannel", {
        connected: function(){
            console.log("connected");
        },
        disconnected: function(){
            console.log("disconnected");
        },
        received: function(data){
            // alert("B")
            $('.online_count').html("Online Users: "+data['users']);
            var is_online = $('.is_online');
            $.each(is_online, function( index, value ) {
                if(data['online_user_ids'].includes(parseInt(value.id))){
                    value.style="color:green"
                }else{
                    value.style="color:red"
                }
            });
        }
    })
}
// check_online();