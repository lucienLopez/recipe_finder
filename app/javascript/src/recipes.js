window.addRecipeSearchListeners = function(){
  $("#recipes_search").on("ajax:success", function(event){
    const data = event.detail[0],
          $tbody = $("#recipes_tbody");

    $tbody.empty();
    for(var i =0; i < data.length; i++){
      $tbody.append('<tr><td>' + data[i].name + '</td><td>' + data[i].total_time + '</td></tr>');
    }
  });
}
