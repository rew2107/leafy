$.isolatePage('setPage', "shoppings", ->

  $('#country_name').text($('.country_radio:checked').attr('country_name'))

  sharedFunctions.countryPicker()
  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#shopping_location').tooltip({placement: 'right'})

  $('#price_slide').slider({
    tooltip: 'show'
  }).on('slide', (ev) ->
    val = $(ev.target).slider('getValue').val().split(",")
    $('#slider_left').text("$#{val[0]}")
    $('#slider_right').text("$#{val[1]}")
  )

)
