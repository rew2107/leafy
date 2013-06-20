$.isolatePage('setPage', "shoppings", ->

  $('.country_radio').change( (event) ->
    name = $(event.target).attr('country_name')
    $('#country_name').text(name)
  )

  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#shopping_location').tooltip({placement: 'right'})

)
