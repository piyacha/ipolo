function checkNav(e,t){for(var o=!1,a=0;a<stuff_picker.length;a++)"TYPE"==stuff_picker[a].stuff_type_name&&(o=!0);"TYPE"==e&&(o=!0),$(".cursor-arrow[value='"+current_type_id+"']").css("display","none"),o?(current_type_id=t,openNav(e,t)):$("#type_first").modal("show"),$(".cursor-arrow[value='"+current_type_id+"']").css("display","")}function stuffColorSelect(e,t){t!=-99&&$.ajax({url:"/api/v1/creates/stuff_color",type:"get",dataType:"json",data:{type_id:e,stuff_id:t},success:function(t){if(document.getElementById("color-picker").innerHTML="",document.getElementById("color-picker-2").innerHTML="",t.data.length>0){$("#color-picker-render-1").css("display","inline-block");for(var o=0;o<t.data.length;o++)$("#color-picker").append("<div class='create-circle-color' onclick='setStuffTypeColor("+t.data[o].id+",0,"+e+","+!0+")' value="+t.data[o].id+"></div>"),$(".create-circle-color[value='"+t.data[o].id+"']").css("background-color",t.data[o].color_code)}if(t.layer_two.length>0){$("#color-picker-render-2").css("display","inline-block");for(var o=0;o<t.layer_two.length;o++)$("#color-picker-2").append("<div class='create-circle-color ' onclick='setStuffTypeColor("+t.layer_two[o].id+",1,"+e+","+!0+")' value="+t.layer_two[o].id+"></div>"),$(".create-circle-color[value='"+t.layer_two[o].id+"']").css("background-color",t.layer_two[o].color_code)}},error:function(e){console.log(e)}})}function openNav(e,t){stuffColorChangeBtn(0,t),stuffColorChangeBtn(1,t),$("#subBarMenu").empty(),$.ajax({url:"/api/v1/creates/subBarClick",type:"get",dataType:"json",data:{type_id:t},success:function(o){if("TYPE"!=e||"ARM"!=e||"BOTTOM"!=e||"LOGO"!=e)for(var a=-99,r=0;r<stuff_picker.length;r++)if(stuff_picker[r].type_id==t){a=stuff_picker[r].stuff_id,stuffColorSelect(t,a);break}if(o.data.length>0){"TYPE"!=o.data[0].type&&"NECK"!=o.data[0].type&&"BODY"!=o.data[0].type&&"PLACKET"!=o.data[0].type&&$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='resetSubBar("+t+")'><div class='stuff-side-padding'><div class='stuff-pick-empty stuff-circle-hover'></div></div></div>");for(var r=0;r<o.data.length;r++){for(var i=-99,c=0;c<stuff_picker.length;c++)if("TYPE"==stuff_picker[c].stuff_type_name){i=stuff_picker[c].stuff_id;break}""!=o.data[r].belong_to_type?o.data[r].belong_to_type==i&&$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+o.data[r].id+",true)'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+o.data[r].img+"' alt='"+o.data[r].name+"'></div></div>"):$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+o.data[r].id+",true)'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+o.data[r].img+"' alt='"+o.data[r].name+"'></div></div>")}$("#subBarMenu").append("<div class='row' style='margin-bottom: 93px'></div>")}document.getElementById("subSlideBar").style.width="110px"},error:function(e){console.log("API subBarClick ERROR !!"),console.log(e)}})}function resetSubBar(e){for(var t=0;t<stuff_picker.length;t++)stuff_picker[t].type_id==e&&stuff_picker.splice(t,1);$(".stuff-pick-right[value='"+e+"']").css("border-style","solid").css("border-color","white"),$(".stuff-type-left-img[value='"+e+"']").css("background-image","url()"),renderStuff()}function stuffColorChangeBtn(e,t){for(var o=!1,a=0;a<stuff_picker.length;a++)stuff_picker[a].type_id==t&&(0==e&&(stuff_picker[a].color_code_0?$(".btn-color-1").css("background-color",stuff_picker[a].color_code_0):(console.log("stuffColorChangeBtn set btn-color-1 empty"),$(".btn-color-1").css("background-color",""))),1==e&&(stuff_picker[a].color_code_1?$(".btn-color-2").css("background-color",stuff_picker[a].color_code_1):(console.log("stuffColorChangeBtn set btn-color-2 empty"),$(".btn-color-2").css("background-color",""))),o=!0);o||(console.log("TYPE NOT EXISTED"),$(".color-picker-render").css("display","none"),$(".btn-color-1").css("background-color",""),$(".btn-color-2").css("background-color",""))}function setStuffTypeColor(e,t,o){$.ajax({url:"/api/v1/creates/find_color",type:"get",dataType:"json",data:{color_id:e},success:function(e){if(e){if($(".stuff-pick-right[value='"+o+"']").css("border","5px").css("border-style","solid").css("border-color",e.data),$(".stuff-type-right-img[value='"+o+"']").css("top","3px").css("left","3px"),0==t){for(var a=0;a<stuff_picker.length;a++)stuff_picker[a].type_id==o&&(stuff_picker[a].color_code_0=e.data,stuff_picker[a].color_code_0_name=e.name,stuff_picker[a].color_code_0_price=e.color_price);stuffColorChangeBtn(t,o)}if(1==t){for(var a=0;a<stuff_picker.length;a++)stuff_picker[a].type_id==o&&(stuff_picker[a].color_code_1=e.data,stuff_picker[a].color_code_1_name=e.name,stuff_picker[a].color_code_1_price=e.color_price);stuffColorChangeBtn(t,o)}}},error:function(){console.log("API find_stuff ERROR !!")}})}function stuff_click(e,t){$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:e},success:function(o){if(o){"TYPE"==o.data.stuff_type_name&&(1==t&&create_init(e),$.ajax({url:"/api/v1/creates/find_stuff_texture_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if(e.texture.length>0){e.texture.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),$("#texture-picker").empty();for(var t=0;t<e.texture.length;t++)$("#texture-picker").append("<div class='col-xs-2' style='margin-right: 5px;padding: 0px' align='center'><div class='create-circle-texture '  onclick='setTexture("+e.texture[t].id+")' value="+e.texture[t].id+"></div></div>"),$(".create-circle-texture[value='"+e.texture[t].id+"']").css("background-image",'url("'+e.texture[t].img+'")'),0==t&&setTexture(e.texture[t].id)}else $("#texture-picker").empty();if(e.size.length>0){stuff_price=[];for(var t=0;t<e.size.length;t++)tmp={id:e.size[t].id,name:e.size[t].name,sex:e.size[t].sex,price:e.size[t].base_price,priority:e.size[t].priority,add_option_price:e.size[t].add_option_price,pattern_price:e.size[t].pattern_price},stuff_price.push(tmp);$("#stuff_calculate_price").css("display","")}e.promotion&&(document.getElementById("promotion_img").src=e.promotion,$("#stuff_type_promotion").css("display",""))}},error:function(){console.log("API find_stuff_texture ERROR !!")}}));var a=0;""!=o.data.stuff_additional_price&&(a=parseFloat(o.data.stuff_additional_price));for(var r=!0,i=0;i<stuff_picker.length;i++)stuff_picker[i].type_id==o.data.stuff_type_id&&(stuff_picker[i].stuff_id=e,stuff_picker[i].price=o.data.stuff_price,stuff_picker[i].additional_price=a,r=!1);r&&stuff_picker.push({type_id:o.data.stuff_type_id,stuff_id:e,stuff_type_name:o.data.stuff_type_name,stuff_type_priority:o.data.stuff_type_priority,price:o.data.stuff_price,additional_price:a,color_ratio_0:o.data.color_ratio_0,color_ratio_1:o.data.color_ratio_1});var c=!0;"LOGO"==o.data.stuff_type_name&&(logoUpload(o),c=!1),c&&$(".stuff-type-left-img[value='"+o.data.stuff_type_id+"']").css("background-image","url("+o.data.stuff_img+")").css("background-size","contain").css("background-repeat","no-repeat"),"LOGO"!=o.data.stuff_type_name&&(1==t&&"TYPE"!=o.data.stuff_type_name&&stuffColorSelect(current_type_id,e),$.ajax({url:"/api/v1/creates/random_color_by_stuff",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){e&&"TYPE"!=e.typeName&&"LOGO"!=e.typeName&&(e.randColor_0?setStuffTypeColor(e.randColor_0.id,0,e.type_id,t):console.log(e.typeName+" Color layer 0 not found !"),e.randColor_1?(setStuffTypeColor(e.randColor_1.id,1,e.type_id,t),1==t&&renderStuff()):(console.log(e.typeName+" Color layer 1 not found !"),1==t&&renderStuff()))},error:function(e){console.log(e)}}))}},error:function(){console.log("API find_stuff ERROR !!")}})}function logoUpload(e){current_logo=e,$("#logo_upload_modal").modal("show")}function drawLogo(e,t,o,a,r,i,c){var l=new Image;l.onload=function(){var e=document.getElementById("tmp_canvas"),s=e.getContext("2d");s.clearRect(0,0,e.width,e.height),"logo_right_arm"==i?(s.save(),s.rotate(15*Math.PI/180),s.drawImage(l,t,o,a,r),s.restore()):"-logo_right_arm"==i?(s.save(),s.rotate(-15*Math.PI/180),s.drawImage(l,t,o,a,r),s.restore()):"logo_left_arm"==i?(s.save(),s.rotate(-15*Math.PI/180),s.drawImage(l,t,o,a,r),s.restore()):"-logo_left_arm"==i?(s.save(),s.rotate(15*Math.PI/180),s.drawImage(l,t,o,a,r),s.restore()):s.drawImage(l,t,o,a,r);var _=s.getImageData(0,0,e.width,e.height),n=document.getElementById("order_canvas"),f=n.getContext("2d");convertCanvasToImage(n,function(e){f.drawImage(e,0,0);for(var t=f.getImageData(0,0,n.width,n.height),o=0;o<_.data.length;o+=4)_.data[o+3]=t.data[o+3]*_.data[o+3];var a=document.getElementById("tmp_canvas"),r=a.getContext("2d");r.clearRect(0,0,a.width,a.height),r.putImageData(_,0,0),convertCanvasToImage(a,function(e){ctx.drawImage(e,0,0),c()})})},l.src=window.location.origin+e}function renderLogo(e){for(var t=!1,o=0;o<stuff_picker.length;o++)if("LOGO"==stuff_picker[o].stuff_type_name){stuff_picker[o].logo_front_l&&logo_q.push({data:[stuff_picker[o].logo_front_l.img_path,460,220,100,100,"logo_front_l"]},function(){console.log("finished processing : logo_front_l ")}),stuff_picker[o].logo_front_r&&logo_q.push({data:[stuff_picker[o].logo_front_r.img_path,240,220,100,100,"logo_front_r"]},function(){console.log("finished processing : logo_front_r ")}),stuff_picker[o].logo_left_arm&&(logo_q.push({data:[stuff_picker[o].logo_left_arm.img_path,570,340,100,100,"logo_left_arm"]},function(){console.log("finished processing : logo_left_arm ")}),logo_q.push({data:[stuff_picker[o].logo_left_arm.img_path,890,-70,100,100,"-logo_left_arm"]},function(){console.log("finished processing : logo_left_arm BACK")})),stuff_picker[o].logo_right_arm&&(logo_q.push({data:[stuff_picker[o].logo_right_arm.img_path,120,140,100,100,"logo_right_arm"]},function(){console.log("finished processing : logo_right_arm ")}),logo_q.push({data:[stuff_picker[o].logo_right_arm.img_path,1335,545,100,100,"-logo_right_arm"]},function(){console.log("finished processing : logo_right_arm BACK")})),stuff_picker[o].logo_back_shouder&&logo_q.push({data:[stuff_picker[o].logo_back_shouder.img_path,1151,90,100,75,"logo_back_shouder"]},function(){console.log("finished processing : logo_back_shouder ")}),stuff_picker[o].logo_back_center&&logo_q.push({data:[stuff_picker[o].logo_back_center.img_path,1101,200,200,133,"logo_back_center"]},function(){console.log("finished processing : logo_back_center ")}),t=!0;break}t?e():(console.log("LOGO NOT FOUND !"),e())}function addTexture(e,t,o){$.ajax({url:"/api/v1/creates/find_texture",type:"get",dataType:"json",data:{texture_id:t},success:function(t){t&&(stuff_picker[e].texture_id=t.data.id,stuff_picker[e].texture_name=t.data.name,stuff_picker[e].texture_price=t.data.price,stuff_picker[e].texture_img=t.img,stuff_picker[e].status_flexible=t.data.status_flexible,stuff_picker[e].status_thick=t.data.status_thick,stuff_picker[e].status_velvety=t.data.status_velvety),o(e)},error:function(){console.log("API find_texture ERROR !!"),o(e)}})}function setTexture(e){for(var t=!1,o=0;o<stuff_picker.length;o++)if("TYPE"==stuff_picker[o].stuff_type_name){addTexture(o,e,function(e){renderPreviewTexture(stuff_picker[e])}),t=!0;break}t||$("#type_first").modal("show")}function renderPreviewTexture(e){$("#stuff_texture_preview").css("display",""),$("#stuff_texture_preview_name").empty(),$("#stuff_texture_preview_name").append(e.texture_name),$("#stuff_texture_preview_img").css("background-image","url("+e.texture_img+")").css("background-repeat","no-repeat").css("background-size","cover"),5==e.status_flexible&&$("#flexible_star5").prop("checked",!0),4==e.status_flexible&&$("#flexible_star4").prop("checked",!0),3==e.status_flexible&&$("#flexible_star3").prop("checked",!0),2==e.status_flexible&&$("#flexible_star2").prop("checked",!0),1==e.status_flexible&&$("#flexible_star1").prop("checked",!0),5==e.status_thick&&$("#thick_star5").prop("checked",!0),4==e.status_thick&&$("#thick_star4").prop("checked",!0),3==e.status_thick&&$("#thick_star3").prop("checked",!0),2==e.status_thick&&$("#thick_star2").prop("checked",!0),1==e.status_thick&&$("#thick_star1").prop("checked",!0),5==e.status_velvety&&$("#velvety_star5").prop("checked",!0),4==e.status_velvety&&$("#velvety_star4").prop("checked",!0),3==e.status_velvety&&$("#velvety_star3").prop("checked",!0),2==e.status_velvety&&$("#velvety_star2").prop("checked",!0),1==e.status_velvety&&$("#velvety_star1").prop("checked",!0)}function calculateLogoPrice(e){for(var t=0,o=0;o<stuff_picker.length;o++)if("LOGO"==stuff_picker[o].stuff_type_name){for(var a=0,r=0,i=0,c=0,l=0,s=0,_=0;_<logo_static_value.logo_static_value.length;_++)"A"==logo_static_value.logo_static_value[_].name&&(a=logo_static_value.logo_static_value[_].value),"B"==logo_static_value.logo_static_value[_].name&&(r=logo_static_value.logo_static_value[_].value),"C"==logo_static_value.logo_static_value[_].name&&(i=logo_static_value.logo_static_value[_].value),"D"==logo_static_value.logo_static_value[_].name&&(c=logo_static_value.logo_static_value[_].value),"E"==logo_static_value.logo_static_value[_].name&&(l=logo_static_value.logo_static_value[_].value),"F"==logo_static_value.logo_static_value[_].name&&(s=logo_static_value.logo_static_value[_].value);if(stuff_picker[o].logo_back_center){var n=stuff_picker[o].logo_back_center.width,f=stuff_picker[o].logo_back_center.height,u=stuff_picker[o].logo_back_center.color_number;"lace"==stuff_picker[o].logo_back_center.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_back_center.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}if(stuff_picker[o].logo_back_shouder){var n=stuff_picker[o].logo_back_shouder.width,f=stuff_picker[o].logo_back_shouder.height,u=stuff_picker[o].logo_back_shouder.color_number;"lace"==stuff_picker[o].logo_back_shouder.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_back_shouder.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}if(stuff_picker[o].logo_front_l){var n=stuff_picker[o].logo_front_l.width,f=stuff_picker[o].logo_front_l.height,u=stuff_picker[o].logo_front_l.color_number;"lace"==stuff_picker[o].logo_front_l.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_front_l.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}if(stuff_picker[o].logo_front_r){var n=stuff_picker[o].logo_front_r.width,f=stuff_picker[o].logo_front_r.height,u=stuff_picker[o].logo_front_r.color_number;"lace"==stuff_picker[o].logo_front_r.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_front_r.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}if(stuff_picker[o].logo_left_arm){var n=stuff_picker[o].logo_left_arm.width,f=stuff_picker[o].logo_left_arm.height,u=stuff_picker[o].logo_left_arm.color_number;"lace"==stuff_picker[o].logo_left_arm.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_left_arm.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}if(stuff_picker[o].logo_right_arm){var n=stuff_picker[o].logo_right_arm.width,f=stuff_picker[o].logo_right_arm.height,u=stuff_picker[o].logo_right_arm.color_number;"lace"==stuff_picker[o].logo_right_arm.logo_type?t=t+logo_block_lace(n,f,u,a,e)+logo_per_lace(n,f,u,r,i):"screen"==stuff_picker[o].logo_right_arm.logo_type&&(t=t+logo_block_screen(n,f,u,c,e)+logo_per_screen(n,f,u,l,s))}break}return t}function calculatePrice(e){console.log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++"),console.log("++++++++++++++++ CALCULATE PRICE  +++++++++++++++++++++"),console.log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++"),console.log(stuff_picker),price_report={};for(var t=[],o=0;o<e.length;o++){for(var a={},r=0,i=0,c=0,l=0;l<stuff_picker.length;l++)if("TYPE"==stuff_picker[l].stuff_type_name){i=stuff_picker[l].price,c=stuff_picker[l].texture_price;break}for(var l=0;l<stuff_picker.length;l++)if("TYPE"!=stuff_picker[l].stuff_type_name&&"LOGO"!=stuff_picker[l].stuff_type_name){var s=0;stuff_picker[l].color_code_0_price&&(s+=stuff_picker[l].color_code_0_price*stuff_picker[l].color_ratio_0),stuff_picker[l].color_code_1_price&&(s+=stuff_picker[l].color_code_1_price*stuff_picker[l].color_ratio_1);var _={};_.color_code_0_price=stuff_picker[l].color_code_0_price,_.color_code_1_price=stuff_picker[l].color_code_1_price,_.color_ratio_0=stuff_picker[l].color_ratio_0,_.color_ratio_1=stuff_picker[l].color_ratio_1,_.fabric_price=c,_.color_factor=s,_.consumption=stuff_picker[l].price,_.size_factor=e[o].price,_.static_price_per_stuff=stuff_picker[l].additional_price,a[stuff_picker[l].stuff_type_name]=_;var n=(c+s)*stuff_picker[l].price*e[o].price+stuff_picker[l].additional_price;r+=n}var f=r+i,u=0;document.getElementById("create_add_height").checked&&(console.log("add_option_price = "+e[o].add_option_price),u=e[o].add_option_price*f/100),f=Math.round(f+u),a.add_option_price=u,a.wage=i,a.base_price=r,price_report[e[o].name+"_"+e[o].sex]=a,t.push({name:e[o].name,price:f,sex:e[o].sex,priority:e[o].priority})}return console.log("calculatePrice -> price_report "),console.log(price_report),t}function logo_block_lace(e,t,o,a,r){return e*t*(o*a)/r}function logo_per_lace(e,t,o,a,r){return e*t*o*a*(1+o/r)}function logo_block_screen(e,t,o,a,r){return e*t*(o*a)/r}function logo_per_screen(e,t,o,a,r){return e*t*o*a*(1+o/r)}function renderPrice(){$("#calculate_list_male").empty(),$("#calculate_list_female").empty();var e=calculatePrice(stuff_price);e.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var t=0;t<e.length;t++)"male"==e[t].sex?$("#calculate_list_male").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>"):"female"==e[t].sex&&$("#calculate_list_female").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>")}function amountPrice(){var e=[],t=calculatePrice(stuff_price),o=0;stuff_price.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),t.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var a=0;a<t.length;a++)for(var r=0;r<stuff_price.length;r++){var i=document.getElementsByName(stuff_price[r].name+"_"+stuff_price[r].sex)[0].value;if(stuff_price[r].name+stuff_price[r].sex==t[a].name+t[a].sex&&void 0!=i){e.push({size:stuff_price[r].name+"_"+stuff_price[r].sex,amount:document.getElementsByName(stuff_price[r].name+"_"+stuff_price[r].sex)[0].value,price_per_unit:t[a].price}),o+=i*t[a].price;break}}return e}function renderLoading(e,t){e?(console.log("renderLoading ",e),$("#order_canvas").css("display","none"),$("#loading_gif").fadeIn(10),setTimeout(function(){t()},400)):(console.log("renderLoading ",e),$("#loading_gif").fadeOut(10),$("#order_canvas").fadeIn(300))}function hex2rgb(e){return r=e.match(/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i),r?r.slice(1,4).map(function(e){return parseInt(e,16)}):(r=e.match(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i),r?r.slice(1,4).map(function(e){return 17*parseInt(e,16)}):null)}function convertCanvasToImage(e,t){var o=new Image;o.src=e.toDataURL("image/png"),o.onload=function(){t(o)}}function renderWaterMask(){var e=new Image;e.onload=function(){var t=document.getElementById("order_canvas"),o=t.getContext("2d");o.drawImage(e,0,0)},e.src=$("#order_canvas").data("water-mask")}function prepare_art_work(){$("#img_base_64").val(canvas.toDataURL("image/png"))}function renderStuff(){ctx.clearRect(0,0,canvas.width,canvas.height),renderLoading(!0,function(){stuff_picker.sort(function(e,t){return parseFloat(e.stuff_type_priority)-parseFloat(t.stuff_type_priority)});for(var e=0;e<stuff_picker.length;e++)q.push({data:[stuff_picker[e].stuff_id,stuff_picker[e].stuff_type_name,stuff_picker[e].color_code_0,stuff_picker[e].color_code_1]},function(e,t,o,a,r,i){var c=!0;if(void 0!=o&&null!=r){var l=hex2rgb(o),s=document.getElementById("tmp_canvas"),_=s.getContext("2d");_.clearRect(0,0,s.width,s.height),_.drawImage(r,0,0);for(var n=_.getImageData(0,0,r.width,r.height),f=0;f<n.data.length;f+=4)n.data[f]=l[0]*(n.data[f]/255),n.data[f+1]=l[1]*(n.data[f+1]/255),n.data[f+2]=l[2]*(n.data[f+2]/255);_.clearRect(0,0,s.width,s.height),_.putImageData(n,0,0),convertCanvasToImage(s,function(e){ctx.drawImage(e,0,0),prepare_art_work()}),c=!1,console.log("finished processing color:",t," ","img 1")}if(void 0!=a&&null!=i){var u=hex2rgb(a),p=document.getElementById("tmp_canvas"),d=p.getContext("2d");d.clearRect(0,0,p.width,p.height),d.drawImage(i,0,0);for(var g=d.getImageData(0,0,i.width,i.height),f=0;f<g.data.length;f+=4)g.data[f]=u[0]*(g.data[f]/255),g.data[f+1]=u[1]*(g.data[f+1]/255),g.data[f+2]=u[2]*(g.data[f+2]/255);d.clearRect(0,0,p.width,p.height),d.putImageData(g,0,0),convertCanvasToImage(p,function(e){ctx.drawImage(e,0,0),prepare_art_work()}),c=!1,console.log("finished processing color:",t," ","img 2")}c&&null!=r&&(ctx.drawImage(r,0,0),prepare_art_work()),console.log("finished processing :",t)})})}function setImgToSummary(){convertCanvasToImage(canvas,function(e){$(".summaryModal_img").empty(),$(".summaryModal_img").append("<img src='"+e.src+"' style='width: 100%'>"),console.log("===== setImgToSummary =====")})}function create_init(e){loadProfitData(),loadLogoStaticValue(),$.ajax({url:"/api/v1/creates/prepare_default_stuff",type:"get",dataType:"json",data:{type_id:e},success:function(e){if(e){var t=e.type_side.id,o=e.type_side.name;if(t&&o&&checkNav(o,t),e.body){var a=e.body.id;stuff_click(a,!1)}if(e.neck){var r=e.neck.id;stuff_click(r,!1)}if(e.type){var t=e.type.id;stuff_click(t,!1)}if(e.placket){var i=e.placket.id;stuff_click(i,!0)}}else console.log("API prepare_default_stuff cant find stuff")},error:function(){console.log("API prepare_default_stuff ERROR !!")}})}function loadProfitData(){$.ajax({url:"/api/v1/creates/stuff_profit",type:"get",dataType:"json",success:function(e){e&&(stuff_profit=e)},error:function(e){console.log(e)}})}function loadLogoStaticValue(){$.ajax({url:"/api/v1/creates/logo_static_value",type:"get",dataType:"json",success:function(e){e&&(logo_static_value=e)},error:function(e){console.log(e)}})}var current_type_id=0,stuff_picker=[],stuff_price=[],stuff_profit,logo_static_value,price_report={},price_amount_report={},current_logo=null,logo_q=async.queue(function(e,t){var o=e.data[0],a=e.data[1],r=e.data[2],i=e.data[3],c=e.data[4],l=e.data[5];drawLogo(o,a,r,i,c,l,t)},1);logo_q.drain=function(){console.log("All Logo has been render")};var q=async.queue(function(e,t){var o=e.data[0],a=e.data[1],r=e.data[2],i=e.data[3];"LOGO"==a?renderLogo(function(){t(o,a,r,i,null,null)}):$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:o},success:function(e){if(e){var c=e.data.stuff_product_img;if(c){var l=new Image;l.onload=function(){if(""!=e.data.stuff_product_img_two){var c=e.data.stuff_product_img_two,s=new Image;s.onload=function(){t(o,a,r,i,l,s)},s.src=c}else t(o,a,r,i,l,null)},l.src=c}}},error:function(e){console.log(e)}})},1);q.drain=function(){console.log("all STUFF have been processed"),renderLoading(!1,function(){}),renderWaterMask(),renderPrice()};var canvas=document.getElementById("order_canvas"),ctx=canvas.getContext("2d");$(document).ready(function(){create_init(-99),document.getElementById("logo_upload").onchange=function(){var e=this.value.split("\\");document.getElementById("upload_file_name").innerHTML=e[e.length-1]},$("#create_customer_input_form").change(function(){for(var e=calculatePrice(stuff_price),t=0,o=0;o<e.length;o++)for(var a=0;a<stuff_price.length;a++){var r=document.getElementsByName(stuff_price[a].name+"_"+stuff_price[a].sex)[0].value;if(stuff_price[a].name+stuff_price[a].sex==e[o].name+e[o].sex&&""!=r){var i=0,c=stuff_profit.stuff_profit;c.sort(function(e,t){return parseFloat(e.amount)-parseFloat(t.amount)});for(var l=0;l<c.length;l++)if(r<=c[l].amount){i=c[l].profit;break}var s=calculateLogoPrice(r),_=e[o].price+stuff_price[a].pattern_price/r+s;t+=r*_*i;var n=stuff_price[a].name+"_"+stuff_price[a].sex;price_report[n]&&(price_report[n].pattern_price=stuff_price[a].pattern_price,price_report[n].amount=r,price_report[n].profit=i,price_report[n].all_logo_price=s,price_report[n]["pattern_price / input_amount"]=stuff_price[a].pattern_price/r,price_report[n].current_price=_,price_report[n].total_amount_price=r*_*i,price_amount_report[n]=price_report[n]);break}}console.log("price_amount_report"),console.log(price_amount_report),console.log("TOTAL = ",t),document.getElementById("total_price").innerHTML=Math.round(t)+".- BATH"}),$("#make_order").click(function(){if(setImgToSummary(),document.getElementById("total_price").innerHTML="0.- BATH",stuff_picker.length>0){for(var e=-100,t=0;t<stuff_picker.length;t++)if("TYPE"==stuff_picker[t].stuff_type_name){e=stuff_picker[t].stuff_id;break}e!=-100?$.ajax({url:"/api/v1/creates/find_stuff_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if($("#stuff_size_input").empty(),e.data_stuffSize_male.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e0a\u0e32\u0e22</h4></div>");for(var t=0;t<e.data_stuffSize_male.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_male[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_male[t].name+"_"+e.data_stuffSize_male[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_male[t].stuff_id+"' style='width: 50px'> </div> ")}if(e.data_stuffSize_female.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e2b\u0e0d\u0e34\u0e07</h4></div>");for(var t=0;t<e.data_stuffSize_female.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_female[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_female[t].name+"_"+e.data_stuffSize_female[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_female[t].stuff_id+"' style='width: 50px'> </div> ")}$("#summaryModal").modal("show")}},error:function(){console.log("API find_stuff_size ERROR !!")}}):$("#incomplete_modal").modal("show")}else $("#incomplete_modal").modal("show")}),$("#make_order_amount").click(function(){console.log("make_order_amount")}),$("#make_order_address").on("click",function(){console.log("make_order_address");var e=$("#first_name").val(),t=$("#email").val(),o=$("#tel").val(),a=$("#address").val(),r=$("#company_name").val(),i=$("#company_branch").val(),c=$("#tax_identification_number").val(),l=stuff_picker,s=stuff_price,_=amountPrice(),n="";document.getElementById("create_add_height").checked&&(n="\u0e40\u0e1e\u0e34\u0e48\u0e21\u0e04\u0e27\u0e32\u0e21\u0e22\u0e32\u0e27\u0e40\u0e2a\u0e37\u0e49\u0e2d");var f={first_name:e,email:t,tel:o,address:a,company_name:r,company_branch:i,tax_identification_number:c,estimate_cost:JSON.stringify(_),stuff_picker:JSON.stringify(l),base_price:JSON.stringify(s),option_price_details:n,price_amount_report:JSON.stringify(price_amount_report)};console.log("========= order_data ========="),console.log(f),$.ajax({url:"/api/v1/creates/make_order",type:"post",dataType:"json",data:f,success:function(e){if(e){console.log("make_order_data"),console.log(e);for(var t=document.getElementById("order_canvas"),o=t.toDataURL(),a=atob(o.split(",")[1]),r=[],i=0;i<a.length;i++)r.push(a.charCodeAt(i));var c=new Blob([new Uint8Array(r)],{type:"image/png"}),l=new FormData;l.append("img",c),l.append("order_id",e.order_id),$.ajax({url:"/api/v1/creates/save_order_img",method:"POST",data:l,processData:!1,contentType:!1,success:function(e){$("#addressModal").modal("hide"),1==e.status?$("#thxModal").modal("show"):$("#problemModal").modal("show")},error:function(e){console.log(e),console.log("API save_order_img ERROR !!")}})}},error:function(e){console.log(e),console.log("API make_order ERROR !!")}})});var e=null,t=null;$("#create-logo-upload-form").change(function(){$("#expect_logo_width").text(Math.round(.39*$("#logo_width").val()*200)+" pixel"),t&&(Math.round(.39*$("#logo_width").val()*200)<=t?$("#logo_width").css("box-shadow","0 0 5px rgba(94, 255, 30, 1)"):$("#logo_width").css("box-shadow","0 0 5px rgba(255, 0, 0, 1)")),$("#expect_logo_height").text(Math.round(.39*$("#logo_height").val()*200)+" pixel"),e&&(Math.round(.39*$("#logo_height").val()*200)<=e?$("#logo_height").css("box-shadow","0px 0px 5px rgba(94, 255, 30, 1)"):$("#logo_height").css("box-shadow","0px 0px 5px rgba(255, 0, 0, 1)")),(file=$("#logo_upload")[0].files[0])||(document.getElementById("max_width_of_upload_file").innerHTML="",document.getElementById("max_height_of_upload_file").innerHTML="",$("#logo_width").val(0),$("#logo_height").val(0),$("#expect_logo_width").text(""),$("#expect_logo_height").text(""),$("#logo_height").css("box-shadow","0px 0px 5px rgba(255, 255, 255, 1)"),$("#logo_width").css("box-shadow","0px 0px 5px rgba(255, 255, 255, 1)"))}),$("#logo_upload").change(function(){var o,a,r=window.URL||window.webkitURL;(o=$("#logo_upload")[0].files[0])&&(a=new Image,a.onload=function(){console.log("logo_upload W : H = "+this.width+" : "+this.height),e=this.height,t=this.width,document.getElementById("max_width_of_upload_file").innerHTML="\u0e01\u0e27\u0e49\u0e32\u0e07 : "+t+"px",document.getElementById("max_height_of_upload_file").innerHTML="\u0e2a\u0e39\u0e07 : "+e+"px"},a.onerror=function(){alert("not a valid file: "+o.type)},a.src=r.createObjectURL(o))}),$("#logo_upload_btn").click(function(){if(""==$("#logo_upload").val()||"0"==$("#logo_width").val()||"0"==$("#logo_height").val()||void 0==$("input[name='color_number']:checked").val())$("#upload_alert").modal("show");else{console.log("width expect with 200dpi = ",Math.round(.39*$("#logo_width").val()*200)),console.log("height expect with 200dpi = ",Math.round(.39*$("#logo_height").val()*200));var e,t,o=Math.round(.39*$("#logo_width").val()*200),a=Math.round(.39*$("#logo_height").val()*200),r=window.URL||window.webkitURL;(e=$("#logo_upload")[0].files[0])&&(t=new Image,t.onload=function(){if(console.log("uploaded W : H = "+this.width+" : "+this.height),o>this.width||a>this.height)alert("\u0e23\u0e39\u0e1b\u0e20\u0e32\u0e1e \u0e01\u0e31\u0e1a \u0e02\u0e19\u0e32\u0e14\u0e44\u0e21\u0e48\u0e1c\u0e48\u0e32\u0e19\u0e02\u0e49\u0e2d\u0e01\u0e33\u0e2b\u0e19\u0e14 \u0e01\u0e27\u0e49\u0e32\u0e07 \u0e2a\u0e39\u0e07 "+this.width+" "+this.height);else if(o<=this.width||a<=this.height){var e=new FormData;e.append("img",$("#logo_upload")[0].files[0]),e.append("color_number",$("input[name='color_number']:checked").val()),e.append("logo_type",$("input[name='screen_lace']:checked").val()),e.append("logo_width",$("#logo_width").val()),e.append("logo_height",$("#logo_height").val()),$.ajax({url:"/api/v1/creates/save_logo_img",method:"POST",data:e,processData:!1,contentType:!1,success:function(e){if($("#logo_upload").val(""),e){for(var t=0;t<stuff_picker.length;t++)if("LOGO"==stuff_picker[t].stuff_type_name){stuff_picker[t][current_logo.data.stuff.name]={img_path:e.img_original,img_id:e.data.id,width:$("#logo_width").val(),height:$("#logo_height").val(),logo_type:e.data.logo_type,color_number:e.data.color_number},current_logo.data.stuff_type_id&&e.img_thumb&&$(".stuff-type-left-img[value='"+current_logo.data.stuff_type_id+"']").css("background-image","url("+e.img_thumb+")").css("background-size","contain").css("background-repeat","no-repeat").css("filter","invert(0)");break}renderStuff(),document.getElementById("upload_file_name").innerHTML="",document.getElementById("max_width_of_upload_file").innerHTML="",document.getElementById("max_height_of_upload_file").innerHTML="",$("#logo_upload_modal").modal("hide")}},error:function(e){console.log(e),console.log("API save_logo_img ERROR !!")}})}},t.onerror=function(){alert("Not a valid file: "+e.type)},t.src=r.createObjectURL(e))}}),$("#stuff_type_promotion_btn").click(function(){$("#promotion_modal").modal("show")}),$(".create-checkbox-position").on("change",function(){console.log($("input[name=create_pocket]:checked").val())}),$(".price_preview_header").on("click",function(){$(".stuff_calculate_price").slideToggle("slow")}),$(".texture_preview_header").on("click",function(){$(".stuff_texture_preview").slideToggle("slow");
}),$(".create-plus-icon").on("click",function(){$("#sidebar-wrapper").css("display","block"),$("#subSlideBar").css("display","block"),$(".create-plus-icon").css("display","none"),$(".create-cancel-icon").css("display","block")}),$(".create-cancel-icon").on("click",function(){$("#sidebar-wrapper").css("display","none"),$("#subSlideBar").css("display","none"),$(".create-plus-icon").css("display","block"),$(".create-cancel-icon").css("display","none")})});