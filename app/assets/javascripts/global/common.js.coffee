$("[rel=tooltip]").tooltip()

jQuery.fn.resetForm = ->
  $(this).each ( ->
   this.reset()
  )

$(document).ready -> 
  body = $("body")
  page_name = $.trim(body.prop("id"))
  $.isolatePage('loadPage', page_name)