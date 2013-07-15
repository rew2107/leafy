
jQuery.fn.resetForm = ->
  $(this).each ( ->
   this.reset()
  )

window.sharedFunctions = window.sharedFunctions || {}

sharedFunctions.multiPic = (formId, type ) ->
  picClicked = {}

  $('.pic').unbind('click')
  $('.pic').click( (e) ->
    picClicked = $(e.target).closest('.pic')
    photoInput = picClicked.parent().find('.photo_input')
    photoInput.click()
  )

  $(formId).fileupload({
    singleFileUploads: false,
    type: type || 'POST',
    add: (e, data) ->
      reader = new FileReader()
      reader.onload = (e) ->
        picClicked.find('img').attr('src', e.target.result)

      reader.readAsDataURL(data.files[0])
      data.submit()
  })

sharedFunctions.countryPicker = ->
  $('.country_radio').change( (event) ->
    name = $(event.target).attr('country_name')
    $('#country_name').text(name)
  )

  
$(document).ready -> 
  body = $("body")
  page_name = $.trim(body.prop("id"))
  $.isolatePage('loadPage', page_name)
  $(form).validate_bootstrap({}) for form in $("form")
