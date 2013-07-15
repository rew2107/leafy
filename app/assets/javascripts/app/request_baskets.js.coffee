$.isolatePage('setPage', "request_baskets", ->

  sharedFunctions.countryPicker()
  sharedFunctions.multiPic('#new_request_basket', 'POST')

  $('.bottom_flag').tooltip({placement: 'bottom'})
  $('#request_location').tooltip({placement: 'right'})

  totalPrice = 0

  addPriceThing = (priceField) ->
    priceField.each(->
      elem = $(this)
      elem.data('oldVal', elem.val())
      elem.bind("propertychange keyup input paste", (event) ->
        if (elem.data('oldVal') != elem.val())
          oldPrice = parseInt(elem.data('oldVal'))
          newPrice = parseInt(elem.val())
          newPrice = 0 if isNaN(newPrice)
          oldPrice = 0 if isNaN(oldPrice)
          totalPrice = totalPrice - oldPrice + newPrice
          $('.total_price').text(totalPrice)
          elem.data('oldVal', elem.val())
      )
    )

  addPriceThing($('.request_price'))
  $(document).on('nested:fieldAdded', (event) ->
    field = event.field
    addPriceThing(field.find('.request_price'))
    sharedFunctions.multiPic('#new_request_basket', 'POST')
  )
  $(document).on('nested:fieldRemoved', (event) ->
    field = event.field
    price =  parseInt(field.find('.request_price').val())
    price = 0 if isNaN(price)
    totalPrice -= price
    $('.total_price').text(totalPrice)
    sharedFunctions.multiPic('#new_request_basket', 'POST')
  )
)
