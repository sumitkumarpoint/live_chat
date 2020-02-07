function updateUserList() {
    App.chat = App.cable.subscriptions.create({
        channel: 'UserListChannel'
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
            $('.user_'+$('.current_user').val()).addClass("clearfix my_message");
            $('.user_'+$('.current_user').val()).removeClass("others_message");

            $('.input_user_'+data['current_user_id'])[0].value="";
            document.getElementsByClassName('input_user_'+data['current_user_id'])[0].click();
            $(".chat-history").scrollTop($(".chat-history")[0].scrollHeight);
        }
    })
}