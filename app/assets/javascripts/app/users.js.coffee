$.isolatePage('setPage', "users", ->
  $('#self_star').raty({
    readOnly: true,
    cancelOff   : 'assets/cancel-off.png',
    cancelOn    : 'assets/cancel-on.png',
    starHalf    : 'assets/star-half.png',
    starOff     : 'assets/star-off.png',
    starOn      : 'assets/star-on.png',
    width       : 145,
    score       : gon.user_rating
  })

  $('.fav_tip').tooltip({placement: 'bottom'})

  setFavClick = (favoritesId) ->
    details = '' + favoritesId + ' .fav_details'
    tips = '' + favoritesId + ' .fav_tip'

    $(details).first().show()

    $(tips).click( (event) ->
      id = $(event.target).closest('.fav_tip').attr('fav_id')
      $(details).hide()
      $('#fav_details_' + id).fadeIn()
    )

  setFavClick('#locals')
  setFavClick('#foreigns')
)
