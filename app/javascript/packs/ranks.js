import 'jquery'

$(document).on('turbolinks:load', function() {
    $('.rank-wrapper').on('ajax:success', function (e) {
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

