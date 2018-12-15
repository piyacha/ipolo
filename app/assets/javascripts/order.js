
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
})