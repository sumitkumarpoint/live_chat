$(document).ready(function () {
    $('.search_users_select2').select2({
        placeholder: 'Search users',
        ajax: {
            url: '/search_users',
            processResults: function (response) {
                // Transforms the top-level key of the response object from 'items' to 'results'
                return {
                    results: response['data']
                };
            }
        }
    })
    //     .on("select2:select", function (e) {
    //     $('form.destination_addresses_form').valid();
    //     update_list();
    // }).on("select2:unselect", function (e) {
    //     $('form.destination_addresses_form').valid();
    //     update_list();
    // });
    if (typeof $(".message_chat_room_id").val() != 'undefined') {
        createMessageChannel();
    }

    check_online();
});