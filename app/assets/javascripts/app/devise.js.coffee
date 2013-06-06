$.isolatePage('setPage', "registrations", ->

  picClicked = {}

  $('.pic').click( (e) ->
    picClicked = $(e.target).closest('.pic')
    photoInput = picClicked.parent().find('.photo_input')
    photoInput.click()
  )

  $('.country_radio').change( (event) ->
    name = $(event.target).attr('country_name')
    $('#country_name').text(name)
  )

  $('.world_flag').tooltip({placement: 'bottom'})

  $('#edit_user').fileupload({
    singleFileUploads: false,
    type: 'PUT',
    add: (e, data) ->
      photoInput = picClicked.parent().find('.photo_input')
      reader = new FileReader()
      reader.onload = (e) ->
        picClicked.find('img').attr('src', e.target.result)

      reader.readAsDataURL(data.files[0])
      data.submit()
  })
)
