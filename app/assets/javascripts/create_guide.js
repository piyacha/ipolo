$(document).ready(function(){
    
    // console.log("GUIDE");

    var tour = new Tour({
        // 'top', 'bottom', 'left', 'right', 'auto'
        template: "<div class='popover tour'><div class='arrow'></div><h3 class='popover-title'></h3><div class='popover-content'></div> <div class='popover-navigation'> <button class='btn btn-default btn-sm' data-role='prev'>« ย้อนกลับ</button></span><button class='btn btn-default btn-sm' data-role='next'>ต่อไป »</button><button class='btn btn-link btn-sm' data-role='end'> ปิด </button></div></div>",
        steps: [
            {
                element: "#create-guide-1",
                title: "STEP 1",
                placement: "bottom",
                content: "โปรดเลือกเนื้อผ้า"
            },
            {
                element: ".stuff_preview_right",
                title: "STEP 2",
                placement: "left",
                content: "รายละเอียดของเนื้อผ้าที่เลือก"
            },
            {
                element: "#sidebar-wrapper",
                title: "STEP 3",
                placement: "right",
                content: "เลือกส่วนที่ต้องการแก้ไข"
            },
            {
                element: "#subBarMenu",
                title: "STEP 4",
                placement: "right",
                content: "เลือกชนิดของเสื้อ"
            },
            {
                element: "#order_canvas",
                title: "STEP 5",
                placement: "bottom",
                content: "รูปตัวอย่างของเสื้อที่ออกแบบ"
            },
            {
                element: "#make_order",
                title: "FINISH",
                placement: "right",
                content: "ทำรายการใบสั่งซื้อ"
            }

        ]
    });

    tour.init();

    tour.start();

});