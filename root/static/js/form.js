var submitForm = function() {
  form.getForm().submit({
    success: function(rst, req) {
      // submission was successful and valid
      // you might want to close the form or something
    },
    failure: function() {
      // form validation returned errors
      // invalid fields are masked automatically 
    }
  });
};

tinyMCE.init({
    // General options
    mode : "textareas",
    theme: "modern",
    plugins: [
      "advlist autolink lists link image charmap print preview hr anchor pagebreak",
      "searchreplace wordcount visualblocks visualchars code fullscreen",
      "insertdatetime media nonbreaking save table contextmenu directionality",
      "emoticons template paste textcolor"
    ],
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
    toolbar2: "print preview media | forecolor backcolor emoticons",
    templates: [
      {title: 'Test template 1', content: 'Test 1'},
      {title: 'Test template 2', content: 'Test 2'}
    ],
});

