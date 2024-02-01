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

    $('.rank-wrapper').on('ajax:success', function (e) {
        console.log('here')
        const rankInfo = e.detail[0]
        const resource = `${rankInfo.class.toLowerCase()}_${rankInfo.resource_id}`

        let rankingElement = $(`.${resource}_ranking span`)
        rankingElement.text(rankInfo.ranking)

        let buttonToHighlight = $(`[name=${resource}][data-value=${rankInfo.rank_given}]`)
        let buttonsToSuppress = $(`[name=${resource}][data-value!=${rankInfo.rank_given}]`)

        buttonToHighlight.attr('class', 'btn btn-success')

        $.each(buttonsToSuppress, function (i, element) {
            element.setAttribute('class', 'btn btn-secondary')
        })
    })
})

