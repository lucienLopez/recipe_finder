window.addRecipeSearchListeners = function(){
  $("#recipes_search").on("ajax:success", function(event){
    const data = event.detail[0],
          $tbody = $("#recipes_tbody");

    $tbody.empty();
    for(var i =0; i < data.length; i++){
      $tbody.append(
        '<tr><td><a href="' + data[i].show_path +'">' + data[i].name +
        '</a></td><td>' + data[i].total_time +
        '</td><td>' + data[i].percent_match +
        '%</td></tr>'
      );
    }
  });
}
