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
    content_css : "/static/css/content.css",
    theme_advanced_font_sizes: "15px,12px,13px,14px,16px,18px,20px",
    font_size_style_values : "10px,12px,13px,14px,16px,18px,20px",
    mode : "textareas",
    width: "100%",
});

