var current_type_id = 0;
var stuff_picker = []; //use to collect stuff that user pick and sent to make order.
var stuff_price = []; //use to collect stuff price.
var stuff_profit;
var logo_static_value;
var price_report = {};
var price_amount_report = {};
/*===================================================================================*/
/*===================================================================================*/
/*==================================  MENU BAR   ====================================*/
/*===================================================================================*/
/*===================================================================================*/
function checkNav(type_name,type_id){
    //Check user must click type first
    var typeChecker = false;
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['stuff_type_name']=="TYPE"){
            typeChecker = true;
        }
    }
    if(type_name=="TYPE"){
        typeChecker = true;
    }

    //console.log("before current_type_id = ",current_type_id);

    // $(".cursor-arrow[value='"+current_type_id+"']").css('display','none');
    $(".cursor-arrow[value='"+current_type_id+"']").parent().removeClass('active');

    //After User choose type open-nav
    if(typeChecker){
        current_type_id= type_id;
        openNav(type_name,type_id);
    }else{
        $("#type_first").modal("show");
    }

    //console.log("after current_type_id = ",current_type_id);

    // $(".cursor-arrow[value='"+current_type_id+"']").css('display','');
    $(".cursor-arrow[value='"+current_type_id+"']").parent().addClass('active');

}

function stuffColorSelect(type_id,stuff_id){
    // console.log("stuffColorSelect type_id",type_id);
    // console.log("stuffColorSelect stuff_id",stuff_id);
    if(stuff_id!=-99){
        $.ajax({
            url: "/api/v1/creates/stuff_color",
            type: "get",
            dataType: "json",
            data: {"type_id":type_id,"stuff_id":stuff_id},
            success: function(data, textStatus, xhr) {
                document.getElementById("color-picker").innerHTML = "";
                document.getElementById("color-picker-2").innerHTML = "";
                document.getElementById("color-picker-3").innerHTML = "";
                if(data['data'].length > 0 && data['color1']){
                    $("#color-picker-render-label").show();
                    $("#color-picker-render-1").show();
                    for(var i=0;i<data['data'].length;i++){
                        // $("#color-picker").append("<div class='col-xs-1' style='padding: 0px' align='center'><div class='create-circle-color '  onclick='setStuffTypeColor("+data['data'][i]['id']+","+0+")' value="+data['data'][i]['id']+"></div></div>");
                        $("#color-picker").append("<div class='create-circle-color' onclick='setStuffTypeColor("+data['data'][i]['id']+","+0+","+type_id+","+true+")' value="+data['data'][i]['id']+"></div>");
                        $(".create-circle-color[value='" + data['data'][i]['id'] +"']").css('background-color', data['data'][i]['color_code']);
                    }
                }else{
                    $("#color-picker-render-label").hide();
                    $("#color-picker-render-1").hide();
                }
                if(data['layer_two'].length > 0 && data['color2']){
                    $("#color-picker-render-2").show();
                    for(var i=0;i<data['layer_two'].length;i++){
                        $("#color-picker-2").append("<div class='create-circle-color ' onclick='setStuffTypeColor("+data['layer_two'][i]['id']+","+1+","+type_id+","+true+")' value="+data['layer_two'][i]['id']+"></div>");
                        $(".create-circle-color[value='" + data['layer_two'][i]['id'] +"']").css('background-color', data['layer_two'][i]['color_code']);
                    }
                }else{
                    $("#color-picker-render-2").hide()
                }
                if(data['layer_three'].length > 0 && data['color3']){
                    $("#color-picker-render-3").show();
                    for(var i=0;i<data['layer_three'].length;i++){
                        $("#color-picker-3").append("<div class='create-circle-color ' onclick='setStuffTypeColor("+data['layer_three'][i]['id']+","+2+","+type_id+","+true+")' value="+data['layer_three'][i]['id']+"></div>");
                        $(".create-circle-color[value='" + data['layer_three'][i]['id'] +"']").css('background-color', data['layer_three'][i]['color_code']);
                    }
                }else{
                    $("#color-picker-render-3").hide()
                }
            },
            error: function(err) {
                console.log(err);
            }
        });
    }
}

function openNav(type_name,type_id) {
    // console.log("openNav type_name = ",type_name);
    // console.log("openNav type_id = ",type_id);

    stuffColorChangeBtn(0,type_id);
    stuffColorChangeBtn(1,type_id);
    stuffColorChangeBtn(2,type_id);

    $("#subBarMenu").empty(); //Clear subBar
    $.ajax({
        url: "/api/v1/creates/subBarClick",
        type: "get",
        dataType: "json",
        data: {"type_id":type_id},
        success: function(data, textStatus, xhr) {
//        console.log("Sub Bar child // length = ",data['data'].length);
            if (type_name != "TYPE" ||type_name != "ARM" || type_name != "BOTTOM" || type_name != "LOGO"){
                var current_stuff_id = -99;
                for(var i=0;i<stuff_picker.length;i++){
                    if(stuff_picker[i]['type_id'] == type_id){
                        current_stuff_id = stuff_picker[i]['stuff_id'];
                        stuffColorSelect(type_id,current_stuff_id);
                        break;
                    }
                }
            }
            if (data['data'].length > 0){
                data['data'].sort(function(a, b) {
                    return  parseFloat(b.priority) - parseFloat(a.priority);
                });
                if(data['delete_stuff_button']){
                    $("#subBarMenu").append("<div class='row staff-item' onclick='resetSubBar("+type_id+","+true+")'><div class='stuff-side-padding'><div class='create-tooltips' data-tmp-balloon='ลบ'  data-tmp-balloon-pos='top'><div class='stuff-pick-empty stuff-circle-hover'><i class='glyphicon glyphicon-ban-circle'></i></div></div></div></div>");
                }

                for(var i = 0;i<data['data'].length;i++){
                    var stuff_type_id = -99;
                    var pocket_checker = false;
                    var pocket_name = "";
                    var check_active = [];
                    for(var j=0;j<stuff_picker.length;j++){
                        if(stuff_picker[j]['stuff_type_name']=='TYPE'){
                            stuff_type_id = stuff_picker[j]['stuff_id'];
                        }
                        if(stuff_picker[j]['stuff_type_name']=='POCKET'){
                            pocket_checker = true;
                            if(stuff_picker[j]['stuff_name']=='POCKET_1_LEFT' || stuff_picker[j]['stuff_name']=='POCKET_2_LEFT'){
                                pocket_name = "left";
                            }else if(stuff_picker[j]['stuff_name']=='POCKET_1_RIGHT' || stuff_picker[j]['stuff_name']=='POCKET_2_RIGHT'){
                                pocket_name = "right";
                            }
                        }
                        check_active.push(stuff_picker[j]['stuff_id'])
                    }

                    var check_active_class;
                    if (check_active.indexOf(data['data'][i]['id']) == -1){
                        check_active_class = 'row staff-item'
                    }else{
                        check_active_class = 'row staff-item active'
                    }

                    if(data['data'][i]['belong_to_type']!=""){
                        if(data['data'][i]['belong_to_type'] == stuff_type_id){
                            //In case render only match belong_to_type
                            $("#subBarMenu").append("<div id='stuff_"+data['data'][i]['id']+"' class='"+check_active_class+"' onclick='stuff_click("+data['data'][i]['id']+",true"+")'><div class='stuff-side-padding' ><div class='create-tooltips' data-tmp-balloon='"+data['data'][i]['desc']+"' data-tmp-balloon-pos='up'><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+data['data'][i]['img']+"' alt='"+data['data'][i]['name']+"'>"+data['data'][i]['desc']+"</div></div></div>");
                        }
                    }else{
                        //In case belong_to_type is "" we render not matter what
                        if(pocket_checker){
                            if (pocket_name == "left"){
                                console.log("LOGO LEFT");
                                if(data['data'][i]['name']!="logo_front_l" && data['data'][i]['name']!="logo_top_pocket_r" && data['data'][i]['name']!="logo_center_pocket_r"){
                                    $("#subBarMenu").append("<div id='stuff_"+data['data'][i]['id']+"' class='"+check_active_class+"' onclick='stuff_click("+data['data'][i]['id']+",true"+")'><div class='stuff-side-padding' ><div class='create-tooltips' data-tmp-balloon='"+data['data'][i]['desc']+"' data-tmp-balloon-pos='up'><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+data['data'][i]['img']+"' alt='"+data['data'][i]['name']+"'>"+data['data'][i]['desc']+"</div></div></div>");
                                }
                            }else if (pocket_name == "right"){
                                console.log("LOGO RIGHT");
                                if(data['data'][i]['name']!="logo_front_r" && data['data'][i]['name']!="logo_top_pocket" && data['data'][i]['name']!="logo_center_pocket"){
                                    $("#subBarMenu").append("<div id='stuff_"+data['data'][i]['id']+"' class='"+check_active_class+"' onclick='stuff_click("+data['data'][i]['id']+",true"+")'><div class='stuff-side-padding' ><div class='create-tooltips' data-tmp-balloon='"+data['data'][i]['desc']+"' data-tmp-balloon-pos='up'><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+data['data'][i]['img']+"' alt='"+data['data'][i]['name']+"'>"+data['data'][i]['desc']+"</div></div></div>");
                                }
                            }
                        }else{
                            //In case User not pick any pocket
                            if(data['data'][i]['name']!="logo_top_pocket_r" &&data['data'][i]['name']!="logo_top_pocket" && data['data'][i]['name']!="logo_center_pocket" && data['data'][i]['name']!="logo_center_pocket_r" && data['data'][i]['name']!="logo_center_pocket_r" ){
                                $("#subBarMenu").append("<div id='stuff_"+data['data'][i]['id']+"' class='"+check_active_class+"' onclick='stuff_click("+data['data'][i]['id']+",true"+")'><div class='stuff-side-padding' ><div class='create-tooltips' data-tmp-balloon='"+data['data'][i]['desc']+"' data-tmp-balloon-pos='up'><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+data['data'][i]['img']+"' alt='"+data['data'][i]['name']+"'>"+data['data'][i]['desc']+"</div></div></div>");
                            }
                        }

                    }
                    // $("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+data['data'][i]['id']+",true"+")'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+data['data'][i]['img']+"' alt='"+data['data'][i]['name']+"'></div></div>");
                }


                //for margin bottom
                $("#subBarMenu").append("<div class='row' style='margin-bottom: 93px'></div>");
            }
            document.getElementById("subSlideBar").style.width = "110px"; //Open subBar

        },
        error: function(err) {
            console.log("API subBarClick ERROR !!");
            console.log(err);
        }
    });
}

//  function closeNav() {
//    document.getElementById("subSlideBar").style.width = "0";
//    $("#create-color-bar").css('display', 'none');
//  }

function resetSubBar(type_id,active){
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['type_id']==type_id){

            if (stuff_picker[i]['stuff_type_name'] == 'POCKET'){
                for(var j=0;j<stuff_picker.length;j++){
                    if (stuff_picker[j]['stuff_type_name'] == 'LOGO'){
                        stuff_picker.splice(j, 1);
                    }
                }
            }
            stuff_picker.splice(i, 1);
        }
    }
    $(".stuff-pick-right[value='" + type_id +"']").css('border-style', 'solid').css('border-color', 'white');
    $(".stuff-type-left-img[value='" + type_id +"']").css('background-image', 'url()');
    if (active){
        renderStuff();
    }

}

function stuffColorChangeBtn(layer,type_id){

    var type_id_existed = false;
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['type_id']==type_id){
            if(layer == 0){
                if(stuff_picker[i]['color_code_0']){
                    $(".btn-color-1").css('background-color',stuff_picker[i]['color_code_0']);
                }else{
                    console.log("stuffColorChangeBtn set btn-color-1 empty");
                    $(".btn-color-1").css('background-color','');
                }

            }
            if(layer == 1){
                if(stuff_picker[i]['color_code_1']){
                    $(".btn-color-2").css('background-color',stuff_picker[i]['color_code_1']);
                }else{
                    console.log("stuffColorChangeBtn set btn-color-2 empty");
                    $(".btn-color-2").css('background-color','');
                }
            }
            if(layer == 2){
                if(stuff_picker[i]['color_code_2']){
                    $(".btn-color-3").css('background-color',stuff_picker[i]['color_code_2']);
                }else{
                    console.log("stuffColorChangeBtn set btn-color-3 empty");
                    $(".btn-color-3").css('background-color','');
                }
            }
            type_id_existed = true;
        }
    }

    if(!type_id_existed){
        console.log("TYPE NOT EXISTED");
        $(".color-picker-render").css('display','none');
        $(".btn-color-1").css('background-color','');
        $(".btn-color-2").css('background-color','');
        $(".btn-color-3").css('background-color','');
    }

}

function setStuffTypeColor(color_id,layer,type_id,active){
    setStuffTypeColorFlow(color_id,layer,type_id,active,function(){
        renderStuff();
    })
}

function setStuffTypeColorFlow(color_id,layer,type_id,active,callback){
    // console.log("setStuffTypeColor ");
    // console.log(" type_id = ",type_id);
    //use color_id because cant sent as color_code ex.(#FFFFF) syntax error.
    $.ajax({
        url: "/api/v1/creates/find_color",
        type: "get",
        dataType: "json",
        data: {"color_id":color_id},
        success: function(data, textStatus, xhr) {
            if(data){

                $(".stuff-pick-right[value='" + type_id +"']").css('border', '5px').css('border-style', 'solid').css('border-color', data['data']);
                $(".stuff-type-right-img[value='" + type_id +"']").css('top', '3px').css('left', '3px');

                if(layer == 0 ){

                    for(var i=0;i<stuff_picker.length;i++){
                        if(stuff_picker[i]['type_id']==type_id){
                            stuff_picker[i]['color_code_0'] =  data['data'];
                            stuff_picker[i]['color_code_0_name'] =  data['name'];
                            stuff_picker[i]['color_code_0_price'] =  data['color_price'];
                        }
                    }
                    stuffColorChangeBtn(layer,type_id);
                }
                if(layer == 1 ){
                    for(var i=0;i<stuff_picker.length;i++){
                        if(stuff_picker[i]['type_id']==type_id){
                            stuff_picker[i]['color_code_1'] =  data['data'];
                            stuff_picker[i]['color_code_1_name'] =  data['name'];
                            stuff_picker[i]['color_code_1_price'] =  data['color_price'];
                        }
                    }
                    stuffColorChangeBtn(layer,type_id);
                }
                if(layer == 2 ){
                    for(var i=0;i<stuff_picker.length;i++){
                        if(stuff_picker[i]['type_id']==type_id){
                            stuff_picker[i]['color_code_2'] =  data['data'];
                            stuff_picker[i]['color_code_2_name'] =  data['name'];
                            stuff_picker[i]['color_code_2_price'] =  data['color_price'];
                        }
                    }
                    stuffColorChangeBtn(layer,type_id);
                }
                // if(active){
                //     renderStuff();
                // }
                callback();
            }
        },
        error: function() {
            console.log("API find_stuff ERROR !!");
        }
    });
}

function set_active_stuff(stuff_id){
    for(var j=0;j<stuff_picker.length;j++){
        $("#stuff_"+stuff_picker[j]['stuff_id']).removeClass("active");
    }
    $("#stuff_"+stuff_id).addClass("active");
}

function set_stuff_picker(data,stuff_id){

    set_active_stuff(stuff_id);

    var stuff_additional_price = 0;
    if(data['data']['stuff_additional_price']!=""){
        stuff_additional_price = parseFloat(data['data']['stuff_additional_price'])
    }
    //Find stuff that user pick if exist replace stuff_id
    var checker = true;
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['type_id']==data['data']['stuff_type_id']){
            // console.log(data);
            // console.log("CHANGE !!",stuff_picker[i]['stuff_id']," to ",stuff_id);
            stuff_picker[i]['stuff_id'] = stuff_id;
            stuff_picker[i]['price'] = data['data']['stuff_price'];
            stuff_picker[i]['stuff_name'] = data['data']['stuff']['name']
            stuff_picker[i]['additional_price'] = stuff_additional_price;
            // console.log("stuff click - > stuff_picker");
            // console.log(stuff_picker);
            checker = false;
        }
    }

    //If not create new obj
    if(checker){
        stuff_picker.push({"type_id":data['data']['stuff_type_id'],
            "stuff_id":stuff_id,
            "stuff_type_name":data['data']['stuff_type_name'],
            "stuff_name":data['data']['stuff']['name'],
            "desc":data['data']['stuff']['desc'],
            "stuff_type_priority":data['data']['stuff_type_priority'],
            "price":data['data']['stuff_price'],
            "additional_price":stuff_additional_price,
            "color_ratio_0":data['data']['color_ratio_0'],
            "color_ratio_1":data['data']['color_ratio_1'],
            "color_ratio_2":data['data']['color_ratio_2']
        });
    }


}

function stuff_click_type(stuff_id,active){

    set_active_stuff(stuff_id);

    if(active == true){

        create_init(stuff_id);
    }

    $.ajax({
        url: "/api/v1/creates/find_stuff_texture_size",
        type: "get",
        dataType: "json",
        data: {"stuff_id":stuff_id},
        success: function(data, textStatus, xhr) {
            if(data){
                if(data['texture'].length > 0){
                    data['texture'].sort(function(a, b) {
                        return parseFloat(a.priority) - parseFloat(b.priority);
                    });
                    $("#texture-picker").empty();
                    for(var i=0;i<data['texture'].length;i++){

                        $("#texture-picker").append("<a class='pull-left texture'><div data-balloon='"+data['texture'][i]['name']+"' data-balloon-pos='down' ><div class='create-circle-texture '  onclick='setTexture("+data['texture'][i]['id']+")' value="+data['texture'][i]['id']+"></div></div></a>");
                        $(".create-circle-texture[value='" + data['texture'][i]['id'] +"']").css('background-image', 'url("'+data['texture'][i]['img']+'")');
                        //default texture
                        if(i==0){
                            setTexture(data['texture'][i]['id']);
                        }
                    }
                }else{
                    $("#texture-picker").empty();
                }

                if(data['size'].length > 0){
                    stuff_price = [];
                    for(var i=0;i<data['size'].length;i++){
                        tmp = {
                            "id":data['size'][i]['id'],
                            "name":data['size'][i]['name'],
                            "sex":data['size'][i]['sex'],
                            "price":data['size'][i]['base_price'],
                            "priority":data['size'][i]['priority'],
                            "add_option_price":data['size'][i]['add_option_price'],
                            "pattern_price":data['size'][i]['pattern_price']
                        };
                        stuff_price.push(tmp);
                    }
                    $("#stuff_calculate_price").css('display','');
                }

                if (data['promotion']){
                    document.getElementById("promotion_img").src = data['promotion'];
                    $("#stuff_type_promotion").css('display','');

                }

                // renderPrice();

            }
        },
        error: function() {
            console.log("API find_stuff_texture ERROR !!");
        }
    });
}


var color_render = async.queue(function(task, callback) {
    // console.log('hello ' + task.name);
    setStuffTypeColorFlow(task.color_layer_id,task.layer,task.type_id,task.active,callback);
}, 1);

color_render.drain = function() {
    console.log('all color_render have been processed');
    renderStuff();
};

function stuff_click(stuff_id,active){

    $.ajax({
        url: "/api/v1/creates/find_stuff",
        type: "get",
        dataType: "json",
        data: {"stuff_id":stuff_id},
        success: function(data, textStatus, xhr) {
            if(data){

                if(data['data']['stuff_type_name']=="TYPE"){
                    stuff_click_type(stuff_id,active);
                }//type

                var typeImg = true;

                if(data['data']['stuff_type_name'] != "LOGO"){
                    set_stuff_picker(data,stuff_id);
                    if(active == true){
                        // render stuff only on random_color_by_stuff
                        // renderStuff();
                        if(data['data']['stuff_type_name']!="TYPE"){
                            // console.log("last step of stuff click");
                            // console.log(stuff_picker);
                            // console.log("current_type_id = ", current_type_id);
                            // console.log("stuff_id = ",stuff_id);
                            stuffColorSelect(current_type_id,stuff_id);
                        }
                    }

                    if(data['data']['stuff_type_name'] == "POCKET"){
                        for(var i=0;i<stuff_picker.length;i++){
                            if(stuff_picker[i]['stuff_type_name'] == "LOGO"){
                                delete stuff_picker[i]['logo_front_l'];
                                break;
                            }
                        }
                    }

                    if(data['data']['stuff_type_name'] != "TYPE" && data['data']['stuff_type_name'] != "LOGO"){

                        if(data['color_layer_0']){
                            color_render.push({color_layer_id:data['color_layer_0']['id'],layer:0,type_id:data['type_id'],active:active}, function(err) {
                                console.log('finished processing COLOR 0 of ',data['data']['stuff_type_name']);
                            });
                        }else{
                            console.log(data['data']['stuff_type_name'] +" Color layer 0 not found !");
                        }
                        if(data['color_layer_1']){
                            color_render.push({color_layer_id:data['color_layer_1']['id'],layer:1,type_id:data['type_id'],active:active}, function(err) {
                                console.log('finished processing COLOR 1 of ',data['data']['stuff_type_name']);
                            });
                        }else{
                            console.log(data['data']['stuff_type_name'] +" Color layer 1 not found !");
                        }
                        if(data['color_layer_2']){
                            color_render.push({color_layer_id:data['color_layer_2']['id'],layer:2,type_id:data['type_id'],active:active}, function(err) {
                                console.log('finished processing  COLOR 2 of ',data['data']['stuff_type_name']);
                            });
                        }else{
                            console.log(data['data']['stuff_type_name'] +" Color layer 2 not found !");
                        }
                    }

                }else{
                    if(data['data']['stuff_type_name']=="LOGO"){
                        logoUpload(data,stuff_id);
                        typeImg = false;
                    }
                }

                // Set BG to same as stuff user pick
                if(typeImg){
                    $(".stuff-type-left-img[value='" + data['data']['stuff_type_id'] +"']").css('background-image', 'url(' + data['data']['stuff_img'] + ')').css('background-size','contain').css('background-repeat','no-repeat');
                }


            }//if(data)
        },
        error: function() {
            console.log("API find_stuff ERROR !!");
        }
    });

}

/*===================================================================================*/
/*===================================================================================*/
/*===================================  LOGO  ========================================*/
/*===================================================================================*/
/*===================================================================================*/
var logo_max_size = {
    "logo_front_l":{
        width:10,
        height:10
    },"logo_front_r":{
        width:10,
        height:10
    },"logo_left_arm":{
        width:10,
        height:10
    },"logo_right_arm":{
        width:10,
        height:10
    },"logo_back_shouder":{
        width:8,
        height:8
    },"logo_back_center":{
        width:15,
        height:15
    },"logo_top_pocket":{
        width:8,
        height:8
    },"logo_center_pocket":{
        width:10,
        height:10
    },"logo_center_pocket_r":{
        width:10,
        height:10
    },"logo_top_pocket_r":{
        width:8,
        height:8
    },"logo_front_center":{
        width:15,
        height:15
    }
}
function set_logo_max_wh(){
    var logo_max_h = logo_max_size[current_logo['data']['stuff_name']]['height'];
    var logo_max_w = logo_max_size[current_logo['data']['stuff_name']]['width'];
    $("#logo_height").attr({
        "max" : logo_max_h,
        "min" : 0
    });
    $("#logo_width").attr({
        "max" : logo_max_w,
        "min" : 0
    });
}

var current_logo = null;
var current_logo_stuff_id = null;
function logoUpload(data,stuff_id){
    current_logo = data;
    current_logo_stuff_id = stuff_id;
    set_logo_max_wh();

    $("#logo_upload_modal_title").text(current_logo['data']['stuff']['desc']);
    $("#logo_position_review").attr("src",current_logo['data']['stuff_product_img']);

    $("#create_policy").modal("show");
    // $("#logo_upload_modal").modal("show");
}

function drawLogo(imgPath,x,y,renderX,renderY,name,callback){
    //Better use parameter as canvas to not use static hard code !!
    var logoImg = new Image;
    logoImg.onload = function() {
        // var new_width = ((logoImg.width * 10.25)/800) * 0.39 * 200;
        // var new_heigth = ((logoImg.height * 10.25)/800) * 0.39 * 200;
        //before LOGO cut position x y

        var canvas_tmp = document.getElementById("tmp_canvas");
        var tmpContext = canvas_tmp.getContext('2d');
        tmpContext.clearRect(0, 0, canvas_tmp.width, canvas_tmp.height);
        // console.log(name , " x = ", x ," y = ",y);
        // tmpContext.drawImage(logoImg,x,y,renderX,renderY);

        if(name == "logo_right_arm"){
            tmpContext.save();
            tmpContext.rotate(15*Math.PI/180);
            tmpContext.drawImage(logoImg,x,y,renderX,renderY);
            tmpContext.restore();
        }else if(name == "-logo_right_arm"){
            tmpContext.save();
            tmpContext.rotate(-15*Math.PI/180);
            tmpContext.drawImage(logoImg,x,y,renderX,renderY);
            tmpContext.restore();
        }
        else if(name == "logo_left_arm"){
            tmpContext.save();
            tmpContext.rotate(-15*Math.PI/180);
            tmpContext.drawImage(logoImg,x,y,renderX,renderY);
            tmpContext.restore();
        }else if(name == "-logo_left_arm"){
            tmpContext.save();
            tmpContext.rotate(15*Math.PI/180);
            tmpContext.drawImage(logoImg,x,y,renderX,renderY);
            tmpContext.restore();
        }else {
            tmpContext.drawImage(logoImg,x,y,renderX,renderY);
        }


        var imgData = tmpContext.getImageData(0, 0, canvas_tmp.width, canvas_tmp.height);
        //base img
        var canvas_alpha = document.getElementById("order_canvas");
        var context_alpha = canvas_alpha.getContext('2d');
        convertCanvasToImage(canvas_alpha,function(base_img){
            context_alpha.drawImage(base_img,0,0);
            var main_imgData = context_alpha.getImageData(0, 0, canvas_alpha.width, canvas_alpha.height);
            for (var j = 0; j < imgData.data.length; j += 4) {
                imgData.data[j+3] = main_imgData.data[j+3] > imgData.data[j+3] ? imgData.data[j+3] : main_imgData.data[j+3];
            }

            var after_canvas = document.getElementById("tmp_canvas");
            var after_tmpContext = after_canvas.getContext('2d');
            after_tmpContext.clearRect(0, 0, after_canvas.width, after_canvas.height);
            after_tmpContext.putImageData(imgData,0,0);

            convertCanvasToImage(after_canvas,function(img_cc){
                ctx.drawImage(img_cc, 0, 0);
                // setImgToSummary();
                callback();
            });
        });
    }
    logoImg.src = window.location['origin']+imgPath;
}

function make_real_ratio(length){
    return (length * 380)/28;
}

// create a queue object with concurrency 2
var logo_q = async.queue(function(task, callback) {
    var imgPath = task['data'][0];
    var x = task['data'][1];
    var y = task['data'][2];
    var renderX = task['data'][3];
    var renderY = task['data'][4];
    var name = task['data'][5];
    var width =  parseFloat(task['data'][6]);
    var height =  parseFloat(task['data'][7]);

    console.log("name :",name);
    console.log("width :",width);
    console.log("height :",height);
    console.log("x :",x);
    console.log("y :",y);

    renderX = make_real_ratio(width);
    renderY = make_real_ratio(height);
    x = x - (renderX/2);

    console.log("renderX ",renderX);
    console.log("renderY ",renderY);
    drawLogo(imgPath,x,y,renderX,renderY,name,callback);

}, 1);

// assign a callback
logo_q.drain = function() {
    console.log('All Logo has been render');
};

function renderLogo(callback){
    var checker = false;
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['stuff_type_name']=="LOGO"){
            if(stuff_picker[i]['logo_front_l']){
                // drawLogo(stuff_picker[i]['logo_front_l']['img_path'],460,220,100,100);
                logo_q.push({data:[stuff_picker[i]['logo_front_l']['img_path'],510,220,100,100,"logo_front_l",stuff_picker[i]['logo_front_l']['width'],stuff_picker[i]['logo_front_l']['height']]}, function () {
                    console.log("finished processing : logo_front_l ");
                });
            }
            if(stuff_picker[i]['logo_front_r']){
                // drawLogo(stuff_picker[i]['logo_front_r']['img_path'],240,220,100,100);
                logo_q.push({data:[stuff_picker[i]['logo_front_r']['img_path'],290,220,100,100,"logo_front_r",stuff_picker[i]['logo_front_r']['width'],stuff_picker[i]['logo_front_r']['height']]}, function () {
                    console.log("finished processing : logo_front_r ");
                });
            }
            if(stuff_picker[i]['logo_left_arm']){
                // drawLogo(stuff_picker[i]['logo_left_arm']['img_path'],650,160,100,100);
                logo_q.push({data:[stuff_picker[i]['logo_left_arm']['img_path'],610,340,100,100,"logo_left_arm",stuff_picker[i]['logo_left_arm']['width'],stuff_picker[i]['logo_left_arm']['height']]}, function () {
                    console.log("finished processing : logo_left_arm ");
                });
                logo_q.push({data:[stuff_picker[i]['logo_left_arm']['img_path'],940,-70,100,100,"-logo_left_arm",stuff_picker[i]['logo_left_arm']['width'],stuff_picker[i]['logo_left_arm']['height']]}, function () {
                    console.log("finished processing : logo_left_arm BACK");
                });
            }
            if(stuff_picker[i]['logo_right_arm']){
                // drawLogo(stuff_picker[i]['logo_right_arm']['img_path'],70,160,100,100);
                logo_q.push({data:[stuff_picker[i]['logo_right_arm']['img_path'],170,140,100,100,"logo_right_arm",stuff_picker[i]['logo_right_arm']['width'],stuff_picker[i]['logo_right_arm']['height']]}, function () {
                    console.log("finished processing : logo_right_arm ");
                });
                logo_q.push({data:[stuff_picker[i]['logo_right_arm']['img_path'],1385,545,100,100,"-logo_right_arm",stuff_picker[i]['logo_right_arm']['width'],stuff_picker[i]['logo_right_arm']['height']]}, function () {
                    console.log("finished processing : logo_right_arm BACK");
                });
            }
            if(stuff_picker[i]['logo_back_shouder']){
                // drawLogo(stuff_picker[i]['logo_back_shouder']['img_path'],1151,90,100,75);
                logo_q.push({data:[stuff_picker[i]['logo_back_shouder']['img_path'],1201,90,100,75,"logo_back_shouder",stuff_picker[i]['logo_back_shouder']['width'],stuff_picker[i]['logo_back_shouder']['height']]}, function () {
                    console.log("finished processing : logo_back_shouder ");
                });
            }
            if(stuff_picker[i]['logo_back_center']){
                // drawLogo(stuff_picker[i]['logo_back_center']['img_path'],1101,200,200,133);
                logo_q.push({data:[stuff_picker[i]['logo_back_center']['img_path'],1201,200,200,133,"logo_back_center",stuff_picker[i]['logo_back_center']['width'],stuff_picker[i]['logo_back_center']['height']]}, function () {
                    console.log("finished processing : logo_back_center ");
                });
            }
            if(stuff_picker[i]['logo_front_center']){
                // drawLogo(stuff_picker[i]['logo_back_center']['img_path'],1101,200,200,133);
                logo_q.push({data:[stuff_picker[i]['logo_front_center']['img_path'],395,250,200,133,"logo_front_center",stuff_picker[i]['logo_front_center']['width'],stuff_picker[i]['logo_front_center']['height']]}, function () {
                    console.log("finished processing : logo_front_center ");
                });
            }
            if(stuff_picker[i]['logo_top_pocket']){
                // drawLogo(stuff_picker[i]['logo_back_shouder']['img_path'],1151,90,100,75);
                logo_q.push({data:[stuff_picker[i]['logo_top_pocket']['img_path'],505,165,70,30,"logo_top_pocket",stuff_picker[i]['logo_top_pocket']['width'],stuff_picker[i]['logo_top_pocket']['height']]}, function () {
                    console.log("finished processing : logo_top_pocket ");
                });
            }
            if(stuff_picker[i]['logo_center_pocket']){
                // drawLogo(stuff_picker[i]['logo_back_center']['img_path'],1101,200,200,133);
                logo_q.push({data:[stuff_picker[i]['logo_center_pocket']['img_path'],500,263,60,60,"logo_center_pocket",stuff_picker[i]['logo_center_pocket']['width'],stuff_picker[i]['logo_center_pocket']['height']]}, function () {
                    console.log("finished processing : logo_center_pocket ");
                });
            }

            if(stuff_picker[i]['logo_top_pocket_r']){
                // drawLogo(stuff_picker[i]['logo_back_shouder']['img_path'],1151,90,100,75);
                logo_q.push({data:[stuff_picker[i]['logo_top_pocket_r']['img_path'],305,165,70,30,"logo_top_pocket_r",stuff_picker[i]['logo_top_pocket_r']['width'],stuff_picker[i]['logo_top_pocket_r']['height']]}, function () {
                    console.log("finished processing : logo_top_pocket_r ");
                });
            }
            if(stuff_picker[i]['logo_center_pocket_r']){
                // drawLogo(stuff_picker[i]['logo_back_center']['img_path'],1101,200,200,133);
                logo_q.push({data:[stuff_picker[i]['logo_center_pocket_r']['img_path'],300,263,60,60,"logo_center_pocket_r",stuff_picker[i]['logo_center_pocket_r']['width'],stuff_picker[i]['logo_center_pocket_r']['height']]}, function () {
                    console.log("finished processing : logo_center_pocket_r ");
                });
            }
            checker = true;
            break;
        }
    }
    if(!checker){
        console.log("LOGO NOT FOUND !");
    }
    callback();
}
/*===================================================================================*/
/*===================================================================================*/
/*==================================  TEXTURE  ======================================*/
/*===================================================================================*/
/*===================================================================================*/

function addTexture(i,texture_id,callback){
    $.ajax({
        url: "/api/v1/creates/find_texture",
        type: "get",
        dataType: "json",
        data: {"texture_id":texture_id},
        success: function(data, textStatus, xhr) {
            if(data){

                stuff_picker[i]['texture_id'] = data['data']['id'];
                stuff_picker[i]['texture_name'] = data['data']['name'];
                stuff_picker[i]['texture_price'] = data['data']['price'];
                stuff_picker[i]['texture_desc'] = data['data']['desc'];
                stuff_picker[i]['texture_img'] = data['img'];
                stuff_picker[i]['texture_consumption'] = data['data']['consumption'];

                stuff_picker[i]['status_flexible'] = data['data']['status_flexible'];
                stuff_picker[i]['status_thick'] = data['data']['status_thick'];
                stuff_picker[i]['status_velvety'] = data['data']['status_velvety'];

                // renderStuff();

            }
            callback(i);
        },
        error: function(err) {
            console.log(err);
            callback(i);
        }
    });
}

function setTexture(texture_id){

    var checker = false;
    for(var i=0;i<stuff_picker.length;i++){
        if(stuff_picker[i]['stuff_type_name']=="TYPE"){
            addTexture(i,texture_id,function(index){
                renderPreviewTexture(stuff_picker[index]);
                // renderPrice();
            });
            checker = true;
            break;
        }
    }
    if(!checker){
        $("#type_first").modal("show");
    }

}

function renderPreviewTexture(type){
    
    $("#stuff_texture_preview").css('display', '');
    $("#stuff_texture_preview_name").empty();
    $("#stuff_texture_preview_name").append(type['texture_name']);
    $("#stuff_texture_preview_desc").empty();
    $("#stuff_texture_preview_desc").append(type['texture_desc']);
    $("#stuff_texture_preview_img").css('background-image', 'url('+type['texture_img']+')').css('background-repeat', 'no-repeat').css('background-size', 'cover');
    if(type['status_flexible']==5)$("#flexible_star5").prop("checked", true);
    if(type['status_flexible']==4)$("#flexible_star4").prop("checked", true);
    if(type['status_flexible']==3)$("#flexible_star3").prop("checked", true);
    if(type['status_flexible']==2)$("#flexible_star2").prop("checked", true);
    if(type['status_flexible']==1)$("#flexible_star1").prop("checked", true);

    if(type['status_thick']==5)$("#thick_star5").prop("checked", true);
    if(type['status_thick']==4)$("#thick_star4").prop("checked", true);
    if(type['status_thick']==3)$("#thick_star3").prop("checked", true);
    if(type['status_thick']==2)$("#thick_star2").prop("checked", true);
    if(type['status_thick']==1)$("#thick_star1").prop("checked", true);

    if(type['status_velvety']==5)$("#velvety_star5").prop("checked", true);
    if(type['status_velvety']==4)$("#velvety_star4").prop("checked", true);
    if(type['status_velvety']==3)$("#velvety_star3").prop("checked", true);
    if(type['status_velvety']==2)$("#velvety_star2").prop("checked", true);
    if(type['status_velvety']==1)$("#velvety_star1").prop("checked", true);
}

/*===================================================================================*/
/*===================================================================================*/
/*==================================  render Price   ================================*/
/*===================================================================================*/
/*===================================================================================*/

function calculateLogoPrice(amount){
    // logo price calculate
    var logo_price = 0;
    for(var j=0;j<stuff_picker.length;j++){
        if(stuff_picker[j]['stuff_type_name']=='LOGO'){

            var logo_value_a = 0;
            var logo_value_b = 0;
            var logo_value_c = 0;
            var logo_value_d = 0;
            var logo_value_e = 0;
            var logo_value_f = 0;
            var logo_value_g = 0;
            var logo_value_h = 0;

            // logo_static_value

            for(var k=0;k<logo_static_value['logo_static_value'].length;k++){
                if (logo_static_value['logo_static_value'][k]['name'] == "A"){
                    logo_value_a = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "B"){
                    logo_value_b = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "C"){
                    logo_value_c = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "D"){
                    logo_value_d = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "E"){
                    logo_value_e = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "F"){
                    logo_value_f = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "G"){
                    logo_value_g = logo_static_value['logo_static_value'][k]['value']
                }
                if (logo_static_value['logo_static_value'][k]['name'] == "H"){
                    logo_value_h = logo_static_value['logo_static_value'][k]['value']
                }
            }

            var all_logo_position = [
                'logo_back_center',
                'logo_back_shouder',
                'logo_front_l',
                'logo_front_r',
                'logo_left_arm',
                'logo_right_arm',
                'logo_top_pocket',
                'logo_center_pocket',
                'logo_top_pocket_r',
                'logo_center_pocket_r',
            ]

            for(var i=0;i<all_logo_position.length;i++){
                if(stuff_picker[j][all_logo_position[i]]){
                    var width = stuff_picker[j][all_logo_position[i]]['width'];
                    var height = stuff_picker[j][all_logo_position[i]]['height'];
                    var color = stuff_picker[j][all_logo_position[i]]['color_number'];
                    var price = 0;
                    if(stuff_picker[j][all_logo_position[i]]['logo_type'] == "lace"){
                        price = logo_block_lace(width,height,color,logo_value_a,amount) + logo_per_lace(width,height,color,logo_value_b,logo_value_c)
                        console.log("LOGO TYPE ",stuff_picker[j][all_logo_position[i]]['logo_type']);
                        console.log("PRICE logo_block_lace = ",logo_block_lace(width,height,color,logo_value_a,amount));
                        console.log("PRICE logo_per_lace = ",logo_per_lace(width,height,color,logo_value_b,logo_value_c));
                        console.log("width  = ",width);
                        console.log("height  = ",height);
                        console.log("color  = ",color);
                        console.log("logo_value_b  = ",logo_value_b);
                        console.log("logo_value_c  = ",logo_value_c);

                    }else if (stuff_picker[j][all_logo_position[i]]['logo_type'] == "screen"){
                        price = logo_block_screen(width,height,color,logo_value_d,amount, logo_value_g) + logo_per_screen(width,height,color,logo_value_e,logo_value_f, logo_value_h);
                    }
                    logo_price = logo_price + price;
                }
            }

            break;
        }
    }
    return logo_price
}

function calculatePrice(stuff_price){

    price_report = {};

    var tmp_stuff_price = [];
    for(var i=0;i<stuff_price.length;i++){
        var each_price_report = {}
        var base_price = 0;
        var wage = 0;
        var fabric_price = 0;
        var stuff_texture_consumption = 0;
        // stuff_picker[j]['price'] is price from each stuff that user pick
        // Find wage price
        for(var j=0;j<stuff_picker.length;j++){
            if(stuff_picker[j]['stuff_type_name']=="TYPE"){
                wage = stuff_picker[j]['additional_price'];
                fabric_price = stuff_picker[j]['texture_price']; 
                // stuff_texture_consumption = stuff_picker[j]['texture_consumption'];
                stuff_texture_consumption = 1;
                break;
            }
        }

        // stuff_price[i]['price'] is weight from size
        // Find Base Price
        for(var j=0;j<stuff_picker.length;j++){
            if(stuff_picker[j]['stuff_type_name']!="TYPE" && stuff_picker[j]['stuff_type_name']!='LOGO'){
                var color_factor = 0;
                if(stuff_picker[j]['color_code_0_price']){
                    color_factor = color_factor + (stuff_picker[j]['color_code_0_price'] * stuff_picker[j]['color_ratio_0'])
                    // console.log("color_code_0_price = ",stuff_picker[k]['color_code_0_price'] ,"TYPE : ",stuff_picker[k]['stuff_type_name']);
                }
                if(stuff_picker[j]['color_code_1_price']){
                    color_factor = color_factor + (stuff_picker[j]['color_code_1_price'] * stuff_picker[j]['color_ratio_1'])
                    // console.log("color_code_1_price = ",stuff_picker[k]['color_code_1_price'] ,"TYPE : ",stuff_picker[k]['stuff_type_name']);
                }
                if(stuff_picker[j]['color_code_2_price']){
                    ด = color_factor + (stuff_picker[j]['color_code_2_price'] * stuff_picker[j]['color_ratio_2'])
                    // console.log("color_code_1_price = ",stuff_picker[k]['color_code_1_price'] ,"TYPE : ",stuff_picker[k]['stuff_type_name']);
                }

                // console.log("================ "+stuff_picker[j]['stuff_type_name']+" =================");
                // console.log("fabric_price = ",fabric_price);
                // console.log("color_factor = ",color_factor);
                // console.log("stuff_picker[j]['price'] (consumption) = ",stuff_picker[j]['price']);
                // console.log("stuff_price[i]['price'] (size) = ",stuff_price[i]['price']);
                // console.log("stuff_picker[j]['additional_price'] (ค่าคงทีแต่ละชิ้นส่วน) = ",stuff_picker[j]['additional_price']);

                var each_stuff_price_report = {};
                each_stuff_price_report["color_code_0_price"] = stuff_picker[j]['color_code_0_price']; // Color price from COLOR TABLE
                each_stuff_price_report["color_code_1_price"] = stuff_picker[j]['color_code_1_price'];
                each_stuff_price_report["color_code_2_price"] = stuff_picker[j]['color_code_2_price'];
                each_stuff_price_report["color_ratio_0"] = stuff_picker[j]['color_ratio_0'];
                each_stuff_price_report["color_ratio_1"] = stuff_picker[j]['color_ratio_1'];
                each_stuff_price_report["color_ratio_2"] = stuff_picker[j]['color_ratio_2'];

                each_stuff_price_report["fabric_price"] = fabric_price;
                each_stuff_price_report["color_factor"] = color_factor;
                each_stuff_price_report["stuff_texture_consumption"] = stuff_texture_consumption;
                each_stuff_price_report["consumption"] = stuff_picker[j]['price']; // each STUFF consumption 1.0
                each_stuff_price_report["size_factor"] = stuff_price[i]['price']; // 1.0
                each_stuff_price_report["static_price_per_stuff"] = stuff_picker[j]['additional_price'];
                each_price_report[stuff_picker[j]['stuff_type_name']] = each_stuff_price_report;

                var each_stuff_price = ( (fabric_price + color_factor) * stuff_texture_consumption * stuff_picker[j]['price'] * stuff_price[i]['price'] ) + stuff_picker[j]['additional_price'];
                base_price = base_price + (each_stuff_price);
            }

        }

        var final_price = base_price + wage;

        // If customer want to add length of his/her shirt this is call [ ADD OPTION PRICE ]
        var add_option_price = 0;
        if(document.getElementById("create_add_height").checked){
            console.log("add_option_price = " + stuff_price[i]['add_option_price']);
            add_option_price = (stuff_price[i]['add_option_price'] * final_price)/100;
        }

        final_price = Math.round(final_price + add_option_price);

        // console.log("$$$$$$$$$$$$$$$$$ SIZE "+stuff_price[i]['sex']+" "+stuff_price[i]['name']+" $$$$$$$$$$$$$$$$$$$$$$$");
        // console.log("stuff_price[i]['pattern_price'] (ค่าคงที่ pattern) = ",stuff_price[i]['pattern_price']);
        // console.log("เปอเซน add_option_price = ",stuff_price[i]['add_option_price'] );
        // console.log("ค่า add_option_price = ",add_option_price);
        // console.log("wage ค่าแรง = ",wage);
        // console.log("ผลรวม base_price = ",base_price);
        // console.log("FINAL PRICE = ",final_price);
        // console.log("");

        each_price_report["add_option_price"] = add_option_price;
        each_price_report["wage"] = wage;
        each_price_report["base_price"] = base_price;

        price_report[stuff_price[i]['name']+"_"+stuff_price[i]['sex']] = each_price_report;
        tmp_stuff_price.push({"name":stuff_price[i]['name'],"price":final_price,"sex":stuff_price[i]['sex'],"priority":stuff_price[i]['priority']});
    }
    // console.log("PRICE REPORT !!");
    // console.log(price_report);
    // console.log(stuff_picker);
    return tmp_stuff_price
}

function logo_block_lace(width,height,color,a,amount){
    return ((width * height) * (color * a))/amount
}

function logo_per_lace(width,height,color,b,c){
    return (width * height * b) * (1 + (color/c))
}

function logo_block_screen(width,height,color,d,amount,g){
    return (((color * d))/amount) + g 
}

function logo_per_screen(width,height,color,e,f, h){
    // return (width * height * e) * (1 + (color/f))
    return ((color * (e + f))) + h
}

function renderPrice(){

    $("#calculate_list_male").empty();
    $("#calculate_list_female").empty();
    var tmp_price = calculatePrice(stuff_price);
    tmp_price.sort(function(a, b) {
        return parseFloat(a.priority) - parseFloat(b.priority);
    });
    for(var i=0;i<tmp_price.length;i++){
        if(tmp_price[i]['sex'] == "male"){
            $("#calculate_list_male").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+tmp_price[i]['name']+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+(tmp_price[i]['price'])+"</div></div>");
        }else if(tmp_price[i]['sex'] == "female"){
            $("#calculate_list_female").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+tmp_price[i]['name']+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+(tmp_price[i]['price'])+"</div></div>");
        }
    }
}

function amountPrice(){
    var wrapPrice = [];
    var currentPrice = calculatePrice(stuff_price);
    var total_price = 0;
    stuff_price.sort(function(a, b) {
        return parseFloat(a.priority) - parseFloat(b.priority);
    });
    currentPrice.sort(function(a, b) {
        return parseFloat(a.priority) - parseFloat(b.priority);
    });
    for(var j =0;j<currentPrice.length;j++){
        for(var i=0;i<stuff_price.length;i++){
            var eachPrice = document.getElementsByName(stuff_price[i]['name']+"_"+stuff_price[i]['sex'])[0].value;
            if((stuff_price[i]['name']+stuff_price[i]['sex'] == currentPrice[j]['name']+currentPrice[j]['sex']) && eachPrice!= undefined){

                wrapPrice.push({
                    "size":stuff_price[i]['name']+"_"+stuff_price[i]['sex'],
                    "amount":document.getElementsByName(stuff_price[i]['name']+"_"+stuff_price[i]['sex'])[0].value,
                    "price_per_unit":currentPrice[j]['price']
                });
                // console.log(stuff_price[i]['name']);
                // console.log(document.getElementsByName(stuff_price[i]['name'])[0].value);
                total_price = total_price + ((eachPrice)*currentPrice[j]['price']);
                break;
            }

        }
    }
    return wrapPrice
}

/*===================================================================================*/
/*===================================================================================*/
/*==================================  LOADING   =====================================*/
/*===================================================================================*/
/*===================================================================================*/

function renderLoading(status,callback){
    if(status){
        console.log("renderLoading ",status);
        $("#order_canvas").fadeTo( "fast" , 0.2);
        // $("#order_canvas").css('display','none');
        $("#loading_gif").fadeIn(10, function() {
            // Animation complete.
            // setTimeout(function(){
            //     callback();
            // }, 0);
        });
        callback();
    }else{
        console.log("renderLoading ",status);
        $("#order_canvas").fadeTo( "fast" , 1);
        // $("#order_canvas").css('display','');
        $("#loading_gif").fadeOut(10);
        callback();
        // $("#order_canvas").fadeIn(200, function() {
        //     // Animation complete.
        //     callback();
        // });


    }

}

/*===================================================================================*/
/*===================================================================================*/
/*==================================  CANVAS   ======================================*/
/*===================================================================================*/
/*===================================================================================*/

function hex2rgb(hex) {
    // long version
    r = hex.match(/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i);
    if (r) {
        return r.slice(1,4).map(function(x) { return parseInt(x, 16); });
    }
    // short version
    r = hex.match(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i);
    if (r) {
        return r.slice(1,4).map(function(x) { return 0x11 * parseInt(x, 16); });
    }
    return null;
}

function convertCanvasToImage(canvas,callback) {
    var image = new Image();
    image.src = canvas.toDataURL("image/png");
    image.onload = function() {
        callback(image);
    }
}

// create a queue object with concurrency 2
var q = async.queue(function(task, callback) {
    var id = task['data'][0];
    var name = task['data'][1];
    var colorCode0 = task['data'][2];
    var colorCode1 = task['data'][3];
    var colorCode2 = task['data'][4];
    if(name=="LOGO"){
        renderLogo(function(){
            callback(id, name, colorCode0, colorCode1, null, null);
        });
    }else{
        $.ajax({
            url: "/api/v1/creates/find_stuff",
            type: "get",
            dataType: "json",
            data: {"stuff_id":id},
            success: function(data, textStatus, xhr) {
                if(data){
                    var img_path = data['data']['stuff_product_img'];
                    if(img_path) {
                        var img = new Image();
                        img.onload = function () {
                            if (data['data']['stuff_product_img_two'] != "") {

                                var img_path_2 = data['data']['stuff_product_img_two'];
                                var img2 = new Image();
                                img2.onload = function () {
                                    if (data['data']['stuff_product_img_three'] != "") {
                                        var img_path_3 = data['data']['stuff_product_img_three'];
                                        var img3 = new Image();
                                        img3.onload = function () {
                                            callback(id, name, colorCode0, colorCode1, colorCode2 ,img,img2,img3);
                                        }
                                        img3.src = img_path_3;

                                    } else {
                                        callback(id, name, colorCode0, colorCode1, colorCode2 ,img,img2,null);
                                    }
                                }
                                img2.src = img_path_2;

                            } else {
                                callback(id, name, colorCode0, colorCode1, colorCode2 ,img,null,null);
                            }
                        };
                        img.src = img_path;
                    }
                }
            },
            error: function(err) {
                console.log(err);
            }
        });
    }
}, 1);

// assign a callback
q.drain = function() {
    console.log('all STUFF have been processed');
    // setImgToSummary();
    renderLoading(false,function(){
        // setImgToSummary();
        // renderWaterMask();
        prepare_art_work();
    });
    // renderWaterMask();
    renderPrice();
    // console.log(stuff_picker);
};

function renderWaterMask(){

    var water_mask_img = new Image;
    water_mask_img.onload = function() {
        var canvas_tmp = document.getElementById("order_canvas");
        var tmpContext = canvas_tmp.getContext('2d');
        tmpContext.drawImage(water_mask_img,0,0);
    }
    water_mask_img.src = $("#order_canvas").data("water-mask")

}

function prepare_art_work(){
    $("#img_base_64").val(canvas.toDataURL("image/png"));
}

var canvas = document.getElementById("order_canvas");
var ctx = canvas.getContext("2d");

function renderStuff(){

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    renderLoading(true,function(){


        // renderPrice();

        stuff_picker.sort(function(a, b) {
            return parseFloat(a.stuff_type_priority) - parseFloat(b.stuff_type_priority);
        });

        for(var i=0;i<stuff_picker.length;i++){

            q.push({data:[stuff_picker[i]['stuff_id'],stuff_picker[i]['stuff_type_name'],stuff_picker[i]['color_code_0'],stuff_picker[i]['color_code_1'],stuff_picker[i]['color_code_2']]}, function (id,name,colorCode0,colorCode1,colorCode2,img0,img1,img2) {


                var checker = true;
                if(colorCode0!=undefined && img0!=null){

                    var colorCodeArray = hex2rgb(colorCode0);
                    var canvas_tmp = document.getElementById("tmp_canvas");
                    var tmpContext = canvas_tmp.getContext('2d');
                    tmpContext.clearRect(0, 0, canvas_tmp.width, canvas_tmp.height);
                    tmpContext.drawImage(img0,0,0);
                    var imgData = tmpContext.getImageData(0, 0, img0.width, img0.height);

         // console.log("rgb = ",colorCodeArray[0]," ",colorCodeArray[1]," ",colorCodeArray[2] );
         // console.log("imgData.data.length = ",imgData.data.length);

                    for (var j = 0; j < imgData.data.length; j += 4) {
                        imgData.data[j] = colorCodeArray[0] * (imgData.data[j]/255);
                        imgData.data[j+1] = colorCodeArray[1] * (imgData.data[j+1]/255);
                        imgData.data[j+2] = colorCodeArray[2] * (imgData.data[j+2]/255);
                    }

                    tmpContext.clearRect(0, 0, canvas_tmp.width, canvas_tmp.height);
                    tmpContext.putImageData(imgData,0,0);
                    convertCanvasToImage(canvas_tmp,function(img_cc){
                        ctx.drawImage(img_cc, 0, 0);
                    });
                    checker = false;
                    console.log('finished processing color:',name,' ','img 1');

                }
                if(colorCode1!=undefined && img1!=null){

                    var colorCodeArray_1 = hex2rgb(colorCode1);
                    var canvas_tmp_1 = document.getElementById("tmp_canvas");
                    var tmpContext_1 = canvas_tmp_1.getContext('2d');
                    tmpContext_1.clearRect(0, 0, canvas_tmp_1.width, canvas_tmp_1.height);
                    tmpContext_1.drawImage(img1,0,0);
                    var imgData_1 = tmpContext_1.getImageData(0, 0, img1.width, img1.height);

         // console.log("rgb = ",colorCodeArray_1[0]," ",colorCodeArray_1[1]," ",colorCodeArray_1[2] );
         // console.log("imgData.data.length = ",imgData_1.data.length);

                    for (var j = 0; j < imgData_1.data.length; j += 4) {
                        imgData_1.data[j] = colorCodeArray_1[0] * (imgData_1.data[j]/255);
                        imgData_1.data[j+1] = colorCodeArray_1[1] * (imgData_1.data[j+1]/255);
                        imgData_1.data[j+2] = colorCodeArray_1[2] * (imgData_1.data[j+2]/255);

                    }
                    tmpContext_1.clearRect(0, 0, canvas_tmp_1.width, canvas_tmp_1.height);
                    tmpContext_1.putImageData(imgData_1,0,0);
                    convertCanvasToImage(canvas_tmp_1,function(img_cc_1){
                        ctx.drawImage(img_cc_1, 0, 0);
                    });

                    checker = false;
                    console.log('finished processing color:',name,' ','img 2');
                }
                if(colorCode2!=undefined && img2!=null){

                    var colorCodeArray_2 = hex2rgb(colorCode2);
                    var canvas_tmp_2 = document.getElementById("tmp_canvas");
                    var tmpContext_2 = canvas_tmp_2.getContext('2d');
                    tmpContext_2.clearRect(0, 0, canvas_tmp_2.width, canvas_tmp_2.height);
                    tmpContext_2.drawImage(img2,0,0);
                    var imgData_2 = tmpContext_2.getImageData(0, 0, img2.width, img2.height);

                    // console.log("rgb = ",colorCodeArray_1[0]," ",colorCodeArray_1[1]," ",colorCodeArray_1[2] );
                    // console.log("imgData.data.length = ",imgData_1.data.length);

                    for (var j = 0; j < imgData_1.data.length; j += 4) {
                        imgData_2.data[j] = colorCodeArray_2[0] * (imgData_2.data[j]/255);
                        imgData_2.data[j+1] = colorCodeArray_2[1] * (imgData_2.data[j+1]/255);
                        imgData_2.data[j+2] = colorCodeArray_2[2] * (imgData_2.data[j+2]/255);

                    }
                    tmpContext_2.clearRect(0, 0, canvas_tmp_2.width, canvas_tmp_2.height);
                    tmpContext_2.putImageData(imgData_2,0,0);
                    convertCanvasToImage(canvas_tmp_2,function(img_cc_2){
                        ctx.drawImage(img_cc_2, 0, 0);
                    });
                    checker = false;
                    console.log('finished processing color:',name,' ','img 2');
                }

                if(checker && img2!=null){
                    ctx.drawImage(img2, 0, 0);
                }

                // setImgToSummary();

                console.log('finished processing :',name);

            });

        }

    });

}

function setImgToSummary(){
     convertCanvasToImage(canvas,function(img_order){
         $(".summaryModal_img").empty();
         $(".summaryModal_img").append("<img src='"+img_order.src+"' style='width: 100%'>");
         console.log("===== setImgToSummary =====");
     });

}

/*===================================================================================*/
/*===================================================================================*/
/*=============================  DOCUMENT READY   ===================================*/
/*===================================================================================*/
/*===================================================================================*/

function create_init(input_type_id){
    //load profit data form data base
    loadProfitData();

    //load profit data form data base
    loadLogoStaticValue();

    $.ajax({
        url: "/api/v1/creates/prepare_default_stuff",
        type: "get",
        dataType: "json",
        data: {"type_id":input_type_id},
        success: function(data, textStatus, xhr) {
            if(data){
                var type_id = data['type_side']['id'];
                var type_name = data['type_side']['name'];
                if(type_id && type_name){
                    checkNav(type_name,type_id);
                }
                if(data['type']){
                    var type_id = data['type']['id']
                    // console.log("BEFORE STUFF CLICK");
                    // console.log("input_type_id=  ",input_type_id);
                    // console.log("type_id=  ",type_id);
                    stuff_click(type_id,false);
                }

                if(data['body']){
                    var body_id = data['body']['id']
                    stuff_click(body_id,false);
                }else{
                    resetSubBar(data['body_type_id'],false)
                }

                if(data['neck']) {
                    var neck_id = data['neck']['id']
                    stuff_click(neck_id, false);
                }else{
                    resetSubBar(data['neck_type_id'],false)
                }

                if(data['sleeve']){
                    var sleeve_id = data['sleeve']['id']
                    stuff_click(sleeve_id,false);
                }else{
                    resetSubBar(data['sleeve_type_id'],false)
                }

                if(data['placket']){
                    var placket_id = data['placket']['id']
                    stuff_click(placket_id,false);
                }else{
                    resetSubBar(data['placket_type_id'],false)
                }

                if(data['botton']){
                    var botton_id = data['botton']['id']
                    stuff_click(botton_id,true);
                }else{
                    resetSubBar(data['botton_type_id'],false)
                }

            }else{
                console.log("API prepare_default_stuff cant find stuff");
            }
        },
        error: function(err) {
            console.log(err);
        }
    });
}

function loadProfitData(){

    $.ajax({
        url: "/api/v1/creates/stuff_profit",
        type: "get",
        dataType: "json",
        success: function(data, textStatus, xhr) {
            if(data){
                // console.log("stuff profit");
                // console.log(data);
                stuff_profit = data;
            }
        },
        error: function(err) {
            console.log(err);
        }
    });

}

function loadLogoStaticValue(){
    $.ajax({
        url: "/api/v1/creates/logo_static_value",
        type: "get",
        dataType: "json",
        success: function(data, textStatus, xhr) {
            if(data){
                // console.log(" logo_static_value ");
                // console.log(data);
                logo_static_value = data;
            }
        },
        error: function(err) {
            console.log(err);
        }
    });
}

$(document).ready(function(){

    create_init(-99);
    // renderStuff();

    document.getElementById("logo_upload").onchange = function () {
        var file_name = (this.value).split("\\");
        document.getElementById("upload_file_name").innerHTML = file_name[file_name.length-1];
    };

    $("#create_customer_input_form").change(function(){1

        document.getElementById("total_amount").innerHTML = "";
        document.getElementById("price_per_amount").innerHTML = "";
        document.getElementById("total_price").innerHTML = "";
        var currentPrice = calculatePrice(stuff_price);
        var total_price = 0;
        var total_amount = 0;
        var all_price = {};
        var tmp_total_amount = 0;

        // Loop Matching currentPrice with stuff_price
        for(var j =0;j<currentPrice.length;j++) {
            for (var i = 0; i < stuff_price.length; i++) {
                // Get input mount by [name_sex]
                var input_amount = document.getElementsByName(stuff_price[i]['name'] + "_" + stuff_price[i]['sex'])[0].value;
                // Match stuff_price name with currentPrice name
                if ((stuff_price[i]['name'] + stuff_price[i]['sex'] == currentPrice[j]['name'] + currentPrice[j]['sex']) && input_amount != "" && input_amount != "0") {
                    tmp_total_amount = tmp_total_amount + parseInt(input_amount);
                }
            }
        }

        // Loop Matching currentPrice with stuff_price
        // Calculate logo price
        for(var j =0;j<currentPrice.length;j++){
            for(var i=0;i<stuff_price.length;i++){

                var input_amount = document.getElementsByName(stuff_price[i]['name']+"_"+stuff_price[i]['sex'])[0].value;

                if((stuff_price[i]['name']+stuff_price[i]['sex'] == currentPrice[j]['name']+currentPrice[j]['sex']) && input_amount!= ""&& input_amount!= "0"){
                    // console.log(stuff_price[i]['name']);
                    // console.log(document.getElementsByName(stuff_price[i]['name'])[0].value);
                    total_amount = total_amount + parseInt(input_amount);

                    var logo_price = calculateLogoPrice(tmp_total_amount);

                    var current_price = currentPrice[j]['price'] + (stuff_price[i]['pattern_price']/input_amount) + logo_price;
                    total_price = total_price + ((input_amount) * current_price);


                    var obj_name = stuff_price[i]['name']+"_"+stuff_price[i]['sex'];

                    if(price_report[obj_name]){
                        price_report[obj_name]["pattern_price"] = stuff_price[i]['pattern_price'];
                        price_report[obj_name]["amount"] = input_amount;

                        price_report[obj_name]["all_logo_price"] = logo_price;
                        price_report[obj_name]["pattern_price / input_amount"] = (stuff_price[i]['pattern_price']/input_amount) ;
                        price_report[obj_name]["current_price"] = current_price;

                        price_report[obj_name]["total_amount_price"] = ((input_amount) * current_price);

                        all_price[obj_name] = price_report[obj_name];
                    }
                    // console.log(stuff_price[i]['name']+"_"+stuff_price[i]['sex']+" each price = "+current_price);
                    // console.log("stuff_price[i]['pattern_price'] = ",stuff_price[i]['pattern_price']);
                    // console.log("currentPrice[j]['price'] = ",currentPrice[j]['price']);
                    // console.log("input_amount = ",input_amount);
                    // console.log("Profit value = ",profit_value);
                    break;
                }

            }
        }

        price_amount_report["all_stuff_price"] = all_price;

        // Calculate profit by amount
        var profit_value = 0;
        var sort_stuff_profit = stuff_profit['stuff_profit'];
        sort_stuff_profit.sort(function(a, b) {
            return parseFloat(a.amount) - parseFloat(b.amount);
        });
        for(var k=0;k<sort_stuff_profit.length;k++){
            if (total_amount <= sort_stuff_profit[k]['amount']){
                profit_value = sort_stuff_profit[k]['profit'];
                break;
            }
        }
        // console.log("profit = ",profit_value);
        // console.log("total_amount = ",total_amount);
        // console.log("price_before_profit = ",total_price);

        price_amount_report['profit'] = profit_value;
        price_amount_report['price_before_profit'] = total_price;

        total_price = total_price * profit_value;
        price_amount_report['total_price'] = total_price;

        document.getElementById("total_amount").innerHTML = Math.round(total_amount)+" ตัว";
        document.getElementById("total_price").innerHTML = Math.round(total_price)+".- BAHT";

        if(total_amount != 0 ){
            document.getElementById("price_per_amount").innerHTML = Math.round(total_price/total_amount)+".- BAHT";
        }else{
            document.getElementById("price_per_amount").innerHTML = "0.- BAHT";
        }
    });

    $("#make_order").click(function(){

        setImgToSummary();

        console.log(stuff_price);
        console.log(stuff_picker);

        document.getElementById("total_price").innerHTML = "0.- BAHT";
        if(stuff_picker.length > 0){
            //find 'TYPE' for stuff size.
            var find_stuff_size = -100;
            for(var i=0;i<stuff_picker.length;i++){
                if(stuff_picker[i]['stuff_type_name']=="TYPE"){
                    find_stuff_size = stuff_picker[i]['stuff_id'];
                    break;
                }
            }

            //if cant find 'TYPE' reject.
            if(find_stuff_size != -100){
                $.ajax({
                    url: "/api/v1/creates/find_stuff_size",
                    type: "get",
                    dataType: "json",
                    data: {"stuff_id":find_stuff_size},
                    success: function(data, textStatus, xhr) {
                        if(data){
                            $('#stuff_size_input').empty();
                            if (data['data_stuffSize_male'].length>0){
                                $('#stuff_size_input').append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>ชาย</h4></div>");
                                for(var i=0;i<data['data_stuffSize_male'].length;i++){
                                    $('#stuff_size_input').append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+data['data_stuffSize_male'][i]['name']+" : "+"</div> <input class='stuff-inline' type='number' min='0' name='"+data['data_stuffSize_male'][i]['name']+"_"+data['data_stuffSize_male'][i]['sex']+"' id='input-stuff-size-"+data['data_stuffSize_male'][i]['stuff_id']+"' style='width: 50px'> </div> ");
                                }
                            }
                            if (data['data_stuffSize_female'].length>0){
                                $('#stuff_size_input').append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>หญิง</h4></div>");
                                for(var i=0;i<data['data_stuffSize_female'].length;i++){
                                    $('#stuff_size_input').append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+data['data_stuffSize_female'][i]['name'] +" : "+"</div> <input class='stuff-inline' type='number' min='0' name='"+data['data_stuffSize_female'][i]['name']+"_"+data['data_stuffSize_female'][i]['sex']+"' id='input-stuff-size-"+data['data_stuffSize_female'][i]['stuff_id']+"' style='width: 50px'> </div> ");
                                }
                            }

                            $("#summaryModal").modal("show");
                        }
                    },
                    error: function() {
                        console.log("API find_stuff_size ERROR !!");
                    }
                });
            }else{//if find_stuff_size != -100
                $("#incomplete_modal").modal("show");
            }

        }else{// if stuff_picker.length > 0
            $("#incomplete_modal").modal("show");
        }

    });

    $('#make_order_amount').click(function(){
        console.log("make_order_amount");
    });

    $('#make_order_address').on( "click", function() {
        console.log("make_order_address");

        var first_name = $("#first_name").val();
        var email = $("#email").val();
        var tel = $("#tel").val();
        var fax = $("#fax").val();
        var address = $("#address").val();

        var company_name = $("#company_name").val();
        var company_branch = $("#company_branch").val();
        var tax_identification_number = $("#tax_identification_number").val();

        var tmp_stuff_picker = stuff_picker;
        var base_price = stuff_price;
        var total_price_amount = amountPrice();

        var current_admin_user_email = $("#current_admin_user_email").val();

        var option_price_details = "";
        if(document.getElementById("create_add_height").checked){
            option_price_details = "เพิ่มความยาวเสื้อ"
        }

        if(email == "" || tel==""){
            $("#create-address-alert").modal('show')
        }else{
            $("#addressModal").modal('hide')
            var order_data = {
                "first_name":first_name,
                "email":email,
                "tel":tel,
                "fax":fax,
                "address":address,

                "company_name":company_name,
                "company_branch":company_branch,
                "tax_identification_number":tax_identification_number,

                "estimate_cost":JSON.stringify(total_price_amount),
                "stuff_picker":JSON.stringify(tmp_stuff_picker),
                "base_price":JSON.stringify(base_price),
                "option_price_details":option_price_details,
                "price_amount_report":JSON.stringify(price_amount_report),

                "current_admin_user_email":current_admin_user_email
            }

            console.log("========= order_data =========");
            console.log(order_data);

            $.ajax({
                url: "/api/v1/creates/make_order",
                type: "post",
                dataType: "json",
                data: order_data,
                success: function(make_order_data, textStatus, xhr) {
                    if(make_order_data){
                        console.log("make_order_data");
                        console.log(make_order_data);
                        var tmp_canvas = document.getElementById("order_canvas");
                        var dataURL = tmp_canvas.toDataURL();
                        var blobBin = atob(dataURL.split(',')[1]);
                        var array = [];
                        for(var i = 0; i < blobBin.length; i++) {
                            array.push(blobBin.charCodeAt(i));
                        }
                        var file = new Blob([new Uint8Array(array)], {type: 'image/png'});

                        var formdata = new FormData();
                        formdata.append("img", file);
                        formdata.append("order_id", make_order_data['order_id']);

                        $.ajax({
                            url: "/api/v1/creates/save_order_img",
                            method: "POST",
                            data: formdata,
                            processData: false,  // tell jQuery not to process the data
                            contentType: false,  // tell jQuery not to set contentType
                            success: function(data, textStatus, xhr) {
                                $("#addressModal").modal("hide");
                                if(data['status']==true){
                                    $("#thxModal").modal("show");
                                }else{
                                    $("#problemModal").modal("show");
                                }
                            },
                            error: function(err) {
                                console.log(err);
                                console.log("API save_order_img ERROR !!");
                            }
                        });

                    }
                },
                error: function(err) {
                    console.log(err);
                    console.log("API make_order ERROR !!");
                }
            });

        }



    });

    /*====================== LOGO UPLOAD =========================*/
    var current_logo_height = null;
    var current_logo_width = null;

    $('#logo_upload_modal').on('hidden.bs.modal', function () {
        document.getElementById("max_width_of_upload_file").innerHTML = "";
        document.getElementById("max_height_of_upload_file").innerHTML = "";
        $("#logo_width").val(0)
        $("#logo_height").val(0)
        $("#expect_logo_width").text("");
        $("#expect_logo_height").text("");
        $("#logo_height").css('box-shadow','0px 0px 5px rgba(255, 255, 255, 1)')
        $("#logo_width").css('box-shadow','0px 0px 5px rgba(255, 255, 255, 1)')
    })

    $("#logo_upload").change(function(){

        var _URL = window.URL || window.webkitURL;
        var file,img;

        if ((file = $("#logo_upload")[0].files[0])) {
            img = new Image();
            img.onload = function () {
                console.log("logo_upload W : H = " + this.width + " : " + this.height);
                current_logo_height = this.height;
                current_logo_width = this.width;
                document.getElementById("max_width_of_upload_file").innerHTML = "กว้าง : "+ current_logo_width +" px";
                document.getElementById("max_height_of_upload_file").innerHTML = "สูง : "+ current_logo_height +" px";
                var logo_max_h = logo_max_size[current_logo['data']['stuff_name']]['height'];
                var logo_max_w = logo_max_size[current_logo['data']['stuff_name']]['width'];
                var input_logo_w = Math.floor(current_logo_width/(0.39*200));
                var input_logo_h = Math.floor(current_logo_height/(0.39*200));

                if (input_logo_w <=  logo_max_w){
                    $("#logo_width").val(input_logo_w);
                }else{
                    $("#logo_width").val(logo_max_w);
                }

                if (input_logo_h <=  logo_max_h){
                    $("#logo_height").val(input_logo_h);
                }else{
                    $("#logo_height").val(logo_max_h);
                }

            };
            img.onerror = function () {
                alert("not a valid file: " + file.type);
            };
            img.src = _URL.createObjectURL(file);
        }

    });

    $("#logo_upload_btn").click(function(){

        if($("#logo_upload").val()=="" || ($("#logo_width").val() == "0" || $("#logo_height").val() == "0") || $("input[name='color_number']:checked").val() == undefined || $("input[name='screen_lace']:checked").val() == undefined){
            $("#upload_alert").modal("show");
        }else{

            set_stuff_picker(current_logo,current_logo_stuff_id);

            console.log("width expect with 200dpi = ",(Math.round($("#logo_width").val()*0.39*200)));
            console.log("height expect with 200dpi = ",(Math.round($("#logo_height").val()*0.39*200)));

            var expect_width = (Math.round($("#logo_width").val()*0.39*200));
            var expect_height = (Math.round($("#logo_height").val()*0.39*200));
            var _URL = window.URL || window.webkitURL;
            var file,img;

            if ((file = $("#logo_upload")[0].files[0])) {
                img = new Image();
                img.onload = function() {
                    console.log("uploaded W : H = "+this.width + " : " + this.height);
                    if (expect_width > this.width || expect_height > this.height){
                        alert("รูปภาพ กับ ขนาดไม่ผ่านข้อกำหนด กว้าง สูง "+this.width+" "+this.height);
                    }else if (expect_width <= this.width || expect_height <= this.height){

                        var fd = new FormData();
                        fd.append('img', $("#logo_upload")[0].files[0]);
                        fd.append('color_number', $("input[name='color_number']:checked").val());

                        fd.append('logo_type', $("input[name='screen_lace']:checked").val());
                        fd.append('logo_width', $("#logo_width").val());
                        fd.append('logo_height', $("#logo_height").val());

                        $.ajax({
                            url: "/api/v1/creates/save_logo_img",
                            method: "POST",
                            data: fd,
                            processData: false,  // tell jQuery not to process the data
                            contentType: false,  // tell jQuery not to set contentType
                            success: function(data, textStatus, xhr) {
                                $("#logo_upload").val("");
                                if(data){
                                    // console.log("current_logo and data from API(save_logo_img)");
                                    // console.log(current_logo,data);
                                    for(var i=0;i<stuff_picker.length;i++){
                                        if(stuff_picker[i]['stuff_type_name']=="LOGO"){
                                            stuff_picker[i][current_logo['data']['stuff']['name']] = {"img_path":data['img_original'],"img_id":data['data']['id'],"width":$("#logo_width").val(),"height":$("#logo_height").val(),"logo_type":data['data']['logo_type'],"color_number":data['data']['color_number']};

                                            if(current_logo['data']['stuff_type_id'] && data['img_thumb']){
                                                $(".stuff-type-left-img[value='" + current_logo['data']['stuff_type_id'] +"']").css('background-image', 'url(' + data['img_thumb'] + ')').css('background-size','contain').css('background-repeat','no-repeat').css('filter','invert(0)');
                                            }

                                            break;
                                        }
                                    }
                                    // renderLogo(current_logo,data);
                                    renderStuff();
                                    document.getElementById("upload_file_name").innerHTML = "";
                                    document.getElementById("max_width_of_upload_file").innerHTML = "";
                                    document.getElementById("max_height_of_upload_file").innerHTML = "";
                                    $("#logo_upload_modal").modal("hide");

                                }
                            },
                            error: function(err) {
                                console.log(err);
                                console.log("API save_logo_img ERROR !!");
                            }
                        });

                    }

                };
                img.onerror = function() {
                    alert("Not a valid file: " + file.type);
                };
                img.src = _URL.createObjectURL(file);
            }
        }
    });

    $("#stuff_type_promotion_btn").click(function(){
       $("#promotion_modal").modal('show')
    });

    $("#logo_upload_size").change(function(){
        $("#logo_requirements_header").text("");
        $("#logo_requirements").text("");

        if (current_logo_width){
            if((Math.round($("#logo_width").val()*0.39*200)) <=  current_logo_width){
                // $("#logo_width").css('box-shadow','0 0 5px rgba(94, 255, 30, 1)')
                $("#logo_width").css('box-shadow','0px 0px 5px rgba(255, 255, 255, 1)')
            }else{
                $("#logo_requirements_header").text("ข้อกำหนด");
                $("#logo_requirements").append(" ความกว้าง ควรมากกว่า "+(Math.round($("#logo_width").val()*0.39*200)) + " pixel \n");
                $("#logo_width").css('box-shadow','0 0 5px rgba(255, 0, 0, 1)')
            }
        }

        if (current_logo_height){
            if((Math.round($("#logo_height").val()*0.39*200)) <= current_logo_height){
                // $("#logo_height").css('box-shadow','0px 0px 5px rgba(94, 255, 30, 1)')
                $("#logo_height").css('box-shadow','0px 0px 5px rgba(255, 255, 255, 1)')
            }else{
                $("#logo_requirements_header").text("ข้อกำหนด");
                $("#logo_requirements").append(" ความสูง ควรมากกว่า "+(Math.round($("#logo_width").val()*0.39*200)) + " pixel \n");
                $("#logo_height").css('box-shadow','0px 0px 5px rgba(255, 0, 0, 1)')
            }
        }

        var logo_max_h = logo_max_size[current_logo['data']['stuff_name']]['height'];
        var logo_max_w = logo_max_size[current_logo['data']['stuff_name']]['width'];

        if ($("#logo_width").val() > logo_max_w){
            $("#logo_requirements_header").text("ข้อกำหนด");
            $("#logo_requirements").append(" ความกว้างสูงสุด "+ logo_max_w + " cm \n");
            $("#logo_width").css('box-shadow','0 0 5px rgba(255, 0, 0, 1)')
        }
        if ($("#logo_height").val() > logo_max_h){
            $("#logo_requirements_header").text("ข้อกำหนด");
            $("#logo_requirements").append(" ความสูงสูงสุด "+ logo_max_h + " cm \n");
            $("#logo_height").css('box-shadow','0px 0px 5px rgba(255, 0, 0, 1)')
        }
    });

    $('.create-checkbox-position').on('change', function() {
        console.log($('input[name=create_pocket]:checked').val());
    });

    $('.price_preview_header').on('click',function() {
        $(".stuff_calculate_price").slideToggle("slow");
    });

    $('.texture_preview_header').on('click',function() {
        $(".stuff_texture_preview").slideToggle("slow");
    });

    $('.create-plus-icon').on('click',function() {
        $('#sidebar-wrapper').css('display', 'block');
        $('#subSlideBar').css('display', 'block');
        $('.create-plus-icon').css('display', 'none');
        $('.create-cancel-icon').css('display', 'block');
    });

    $('.create-cancel-icon').on('click',function() {
        $('#sidebar-wrapper').css('display', 'none');
        $('#subSlideBar').css('display', 'none');
        $('.create-plus-icon').css('display', 'block');
        $('.create-cancel-icon').css('display', 'none');
    });

});//document ready
;
