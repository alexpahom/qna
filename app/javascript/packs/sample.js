import 'jquery'

$(document).on('turbolinks:load', function() {
    $('#new_answer').on('ajax:success', function (e) {
        const answer = e.detail[0];
        $('.answers').append(answer.body);
    }).on('ajax:error', function (e) {
        const errors = e.detail[0];
        $.each(errors, function(index, value) {
            $('.answer-errors').append(value)
        })
    })
})
