do ($ = jQuery) ->
  $.fn.validate_bootstrap = ( options ) ->
    options = $.extend( options, {
      highlight: (label) ->
        $(label).closest('.control-group').removeClass('success')
        $(label).closest('.control-group').addClass('error')
      ,
      unhighlight: (element, errorClass, validClass) ->
        $(element).closest('.control-group').removeClass("error"); 
      , 
      success: (label) ->
        label
          .text('OK!').addClass('valid')
          .closest('.control-group').addClass('success')
      ,
      errorElement: 'span',
      errorClass: 'help-inline'
    })
    $(this).validate(options)