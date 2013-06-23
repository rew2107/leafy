$.isolatePage('setPage', "registrations", ->

  sharedFunctions.multiPic('#edit_user', 'PUT')
  sharedFunctions.countryPicker()

  $('.world_flag').tooltip({placement: 'bottom'})

)
