//var units = new Array();



// this function creates a dynamic dropdown list for the 
// units in a certain property

$(document).ready(function(){
    $("div#unit_field").hide();
    $("#property_id").change(function(){
      $('select#lease_unit_id').html('');
      var property_id = $("#property_id").val();
        $.each($("#properties_units").data(property_id), function(index, value) {
          //print <option value="value[0]">value[1]</option>
          $("div#unit_field").show();
          $('select#lease_unit_id').append('<option value="' + value[0] + '">' + value[1] + '</option>');

        });


    });
});