$.isolatePage('setPage', "registrations", ->

  elem = $('#edit_user')
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
