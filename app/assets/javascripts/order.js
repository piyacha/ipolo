
console.log("order !!");
var payment_order_id = null;
$(document).ready(function(){
  $(".order-btn").click(function(){
    payment_order_id = $(this).data( "order-id" );
    // $("#paid_at").val($(this).data( "time" ));
    document.getElementById("paid_at").defaultValue =  moment().format().split("+")[0];

    $("#paid_amount").val(parseFloat($(this).data( "price" )).toFixed(2))
    $("#paymentModal").modal("show");
  });

  if (document.getElementById("slip")){
    document.getElementById("slip").onchange = function () {
      var file_name = (this.value).split("\\");
      document.getElementById("slip_file_name").innerHTML = file_name[file_name.length-1];
    };
  }


  $("#payment_transfer").click(function(){
    var fd = new FormData();
    if (payment_order_id == undefined || payment_order_id == null ){
      console.log("HERE")
      fd.append('order_id', $("#order_id").val());
    }else{
      fd.append('order_id', payment_order_id);
    }
    fd.append('slip', $("#slip")[0].files[0]);
    fd.append('payment_name', $("#payment_name").val());
    fd.append('bank_account_id', $("#bank_account_id").val());
    fd.append('paid_amount', $("#paid_amount").val());
    fd.append('paid_at', $("#paid_at").val());
    fd.append('phone', $("#phone").val());
    fd.append('user_id', $("#current_user_id").val());
    $.ajax({
        url: "/api/v1/creates/payment_transfer",
        method: "POST",
        data: fd,
        processData: false,  // tell jQuery not to process the data
        contentType: false,  // tell jQuery not to set contentType
        success: function(data, textStatus, xhr) {
    $("#slip").val("");
    $("#paymentModal").modal("hide");
            if(data){
                $("#thxModal").modal("show");
            }
        },
        error: function(err) {
            $("#problemModal").modal("show");
        }
    });
  });

})

