function createMessageChannel() {
    App.chat = App.cable.subscriptions.create({
        channel: 'ChatChannel',
        chat_room_id: parseInt($(".message_chat_room_id").val())
    }, {
        connected: function () {
            console.log("connected");
        },
        disconnected: function () {
            console.log("disconnected");
        },
        received: function (data) {
            $('.messages').html(data['message']);
            $('.common_class').addClass("others_message");
            $('.user_'+$('.current_user').val()).addClass("clearfix my_message");
            $('.user_'+$('.current_user').val()).removeClass("others_message");

            $('.input_user_'+data['current_user_id'])[0].value="";
            // $(".messages").scrollTop($(".messages")[0].scrollHeight);
        }
    })
}