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
}
