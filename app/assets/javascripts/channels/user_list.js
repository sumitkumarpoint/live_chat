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
        received: function (response) {
            if (response['user_ids'].includes(parseInt($('.current_login_user').val()))) {
                if (response['data'][$('.current_login_user').val()]) {
                    resent_user=response['data'][$('.current_user').val()]
                } else {
                    resent_user=response['data']['users_list']
                }
                $('.default_user_list').append(resent_user);
            }
        }
    })
}