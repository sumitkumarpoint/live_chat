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
            $('.messages').append(data['message']);
            $('.common_class').addClass("others_message");
            $('.user_' + $('.current_user').val()).addClass("clearfix my_message");
            $('.user_' + $('.current_user').val()).removeClass("others_message");
            if (typeof $('.input_form_' + data['current_user_id'])[0] != 'undefined') {
                $('.input_form_' + data['current_user_id'])[0].reset();
            }

            // document.getElementsByClassName('input_user_' + data['current_user_id'])[0].click();
            $(".chat-history").scrollTop($(".chat-history")[0].scrollHeight);
        }
    })
}