$.isolatePage('setPage', "shoppings", ->

  $('#country_name').text($('.country_radio:checked').attr('country_name'))

  sharedFunctions.countryPicker()
  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#shopping_location').tooltip({placement: 'right'})

)
