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
)
