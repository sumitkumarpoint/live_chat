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
            $('.messages_input').val("");
            $('.messages').html(data['message']);
        }
    })
}