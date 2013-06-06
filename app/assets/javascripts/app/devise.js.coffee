$.isolatePage('setPage', "registrations", ->

  picClicked = {}

  for elem in $('.photo_edit_span')
    elem = $(elem)
    photoInput = elem.find('.photo_input')
    photoInput.change( (input) ->
      reader = new FileReader()
      reader.onload = (e) ->
        picClicked.find('img').attr('src', e.target.result)

      reader.readAsDataURL(input.target.files[0])
    )

    elem.find('.pic').click( (e) ->
      picClicked = $(e.target).closest('.pic')
      photoInput.click()
    )

  $('.country_radio').change( (event) ->
    name = $(event.target).attr('country_name')
    $('#country_name').text(name)
  )

  $('.world_flag').tooltip({placement: 'bottom'})
)
