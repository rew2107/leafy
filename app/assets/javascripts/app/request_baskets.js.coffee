$.isolatePage('setPage', "request_baskets", ->

  sharedFunctions.countryPicker()
  sharedFunctions.multiPic('#new_request_basket', 'POST')

  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#request_location').tooltip({placement: 'right'})

)
