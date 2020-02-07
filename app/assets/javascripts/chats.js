$(document).ready(function () {
    if(typeof $(".chat-history") != 'undefined'){
        $(".chat-history").scrollTop($(".chat-history")[0].scrollHeight);
    }

    $(document).on('keyup', '.search_user_input', function () {
        var url = $('.search_user_form').attr('action');
        var data = $('.search_user_form').serialize();
        $.ajax({
            url: url,
            data: data
        })
    });

    if ($('.pagination').length >= 0) {
        $('.chat-history').scroll(function () {
            var url = $('.pagination .next_page').attr('href');
            var chk_val = $('.check_pagination_div').val();
            if ((url && $('.chat-history').scrollTop() < 50)) {
                $('.pagination').text("Please Wait...");
                 $.getScript(url);
            }
        });

    }
    // $('.search_users_select2').select2({
    //     placeholder: 'Search users',
    //     ajax: {
    //         url: '/search_users',
    //         processResults: function (response) {
    //             // Transforms the top-level key of the response object from 'items' to 'results'
    //             return {
    //                 results: response['data']
    //             };
    //         }
    //     }
    // })
    //     .on("select2:select", function (e) {
    //     $('form.destination_addresses_form').valid();
    //     update_list();
    // }).on("select2:unselect", function (e) {
    //     $('form.destination_addresses_form').valid();
    //     update_list();
    // });
    if (typeof $(".message_chat_room_id").val() != 'undefined') {
        createMessageChannel();
        updateUserList();
    }

    check_online();

});