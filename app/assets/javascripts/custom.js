/** Toggle Switch **/

$(document).ready(function() {
    $('#customSwitches').change(function() {
        $('#mycheckboxdiv').toggle();
    });
    $('#customSwitches2').change(function() {
        $('#mycheckboxdiv2').toggle();
    });
    $('#customSwitches3').change(function() {
        $('#mycheckboxdiv3').toggle();
    });
    $('#customSwitches4').change(function() {
        $('#mycheckboxdiv4').toggle();
    });
    $('#customSwitches5').change(function() {
        $('#mycheckboxdiv5').toggle();
    });
});

 

  
  /*$(document).on("change", "#country_id", function(){
  var country = $(this).val();

  $.ajax({
    url: "/user/get_time_zone/",
    method: "GET",
    dataType: "json",
    data: {id: country},
    error: function (xhr, status, error) {
      console.error('AJAX Error: ' + status + error);
    },
    success: function (response) {
      console.log(response);
      var time_zones = response["time_zones"];
      $("#time_zone").empty();

      $("#time_zone").append('<option>Select city</option>');
      for(var i=0; i< time_zones.length; i++){
        $("#time_zone").append('<option value="' + time_zones[i]["id"] + '">' + time_zones[i]["name"] + '</option>');
      }
    }
  });
});*/
