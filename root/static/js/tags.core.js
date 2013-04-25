var availableTags = ['pppp','paaaa','pbbbb','pcccc','pdddd','peee'];
$.ajax({
  async: false,
  url: '/tag/list'
}).done(function(data){
  availableTags = data;
});
console.log(availableTags);
var enableTag = function(article_id){
  $("#tag_article"+article_id).tagit({
    beforeTagAdded: function(event,ui){
      if( !ui.duringInitialization ){
        var success;
        $.ajax({
          async: false,
          url: '/tag/add/',
          type: 'POST',
          data: {
            article_id: article_id,
            tag: ui.tagLabel
          }
        }).done(function(data){
          success = data.success;
        });
        if(success == 0){
          return false;
        }
      }
    },
    beforeTagRemoved : function(event,ui){
        var success;
        $.ajax({
          async: false,
          url: '/tag/del/',
          type: 'POST',
          data: {
            article_id: article_id,
            tag: ui.tagLabel
          }
        }).done(function(data){
          success = data.success;
        });
        if(success == 0){
          return false;
        }
    },
    availableTags: availableTags,
  });
};
