$.isolatePage('setPage', "requests", ->

  $('.country_radio').change( (event) ->
    name = $(event.target).attr('country_name')
    $('#country_name').text(name)
  )

  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#request_location').tooltip({placement: 'right'})

  elem = $('#new_request')
  photoInput = elem.find('#photo_input')

  photoInput.change( (input) ->
    reader = new FileReader()
    reader.onload = (e) ->
      elem.find('img').attr('src', e.target.result)

    reader.readAsDataURL(input.target.files[0])
  )

  elem.find('.pic').click( (e) ->
    photoInput.click()
  )
)
