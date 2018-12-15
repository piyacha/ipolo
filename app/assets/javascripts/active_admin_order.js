console.log("Admin Order");
function donwload_img(path) {
    console.log(path);
    document.getElementById('download_iframe').src = window.location['origin']+path;
}

$(document).ready(function(){
    $(".payment_paid").on('click',function(){
        $.ajax({
            url: "/api/v1/creates/make_quotation",
            type: "post",
            dataType: "json",
            data: {"order_id":$(this).val()},
            success: function(data, textStatus, xhr) {
                if(data['status'] && data['quotation_id']){
                    // $("#complete_status").modal("show")
                    window.location = "/admin/quotations/"+data['quotation_id']+"/edit";
                } else {
                    alert("ไม่พบ order ในระบบ");
                }
            },
            error: function(err) {
                console.log(err)
                alert("ทำรายการไม่สำเร็จ โปรดลองอีกครั้ง");
            }
        });
    });

    $(".order_quotation").on('click',function(){
        $.ajax({
            url: "/api/v1/creates/make_quotation",
            type: "post",
            dataType: "json",
            data: {"order_id":$(this).val()},
            success: function(data, textStatus, xhr) {
                if(data['status'] && data['quotation_id']){
                    // $("#complete_status").modal("show")
                    window.location = "/admin/quotations/"+data['quotation_id']+"/edit";
                } else {
                    alert("ไม่พบ order ในระบบ");
                }
            },
            error: function(err) {
                console.log(err)
                alert("ทำรายการไม่สำเร็จ โปรดลองอีกครั้ง");
            }
        });
    });

    $(".order_contact").on('click',function(){
        $.ajax({
            url: "/api/v1/creates/make_contact",
            type: "post",
            dataType: "json",
            data: {"order_id":$(this).val()},
            success: function(data, textStatus, xhr) {
                if(data['status']){
                    if (confirm("ติดต่อเรียบร้อย")) {
                        window.location.reload();
                      } else {
                        window.location.reload();
                      }
                }else{
                    alert("ไม่พบ order ในระบบ");
                }
            },
            error: function(err) {
                console.log(err)
                alert("ทำรายการไม่สำเร็จ โปรดลองอีกครั้ง");
            }
        });
    });

    $(".quotation_send_email").on('click',function(){
        if ($('#quotaion_loading_email').length !=0){
            console.log($('#quotaion_loading_email').length);
            $('#quotaion_loading_email').modal('show');
        }else{
            alert("กำลังทำรายการ โปรดรอซักครู่");
        }

        $.ajax({
            url: "/api/v1/creates/send_email",
            type: "post",
            dataType: "json",
            data: {
                "quotation_id":$(this).val(),
                "base_url":window.location.origin
            },
            success: function(data, textStatus, xhr) {
                if ( $('#quotaion_loading_email').length !=0){
                    $('#quotaion_loading_email').modal('hide');
                }

                if (data){
                    window.location.reload();
                    alert("ทำรายการสำเร็จ !");
                }else{
                    alert("ไม่พบ quotation ดังกล่าว !");
                }
            },
            error: function(err) {
                console.log(err)
                if ( $('#quotaion_loading_email').length !=0){
                    $('#quotaion_loading_email').modal('hide');
                }
                alert("ทำรายการไม่สำเร็จ โปรดลองอีกครั้ง");

            }
        });
    });


});
