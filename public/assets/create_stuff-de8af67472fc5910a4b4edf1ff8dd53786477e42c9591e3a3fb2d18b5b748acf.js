function checkNav(e,t){for(var a=!1,r=0;r<stuff_picker.length;r++)"TYPE"==stuff_picker[r].stuff_type_name&&(a=!0);"TYPE"==e&&(a=!0),$(".cursor-arrow[value='"+current_type_id+"']").css("display","none"),a?(current_type_id=t,openNav(e,t)):$("#type_first").modal("show"),$(".cursor-arrow[value='"+current_type_id+"']").css("display","")}function openNav(e,t){$("#subBarMenu").empty(),$.ajax({url:"/api/v1/creates/subBarClick",type:"get",dataType:"json",data:{type_id:t},success:function(e){if($.ajax({url:"/api/v1/creates/stuff_color",type:"get",dataType:"json",data:{type_id:t},success:function(e){if(document.getElementById("color-picker").innerHTML="",document.getElementById("color-picker-2").innerHTML="",e.data.length>0){$("#color-picker-render-1").css("display","inline-block");for(var t=0;t<e.data.length;t++)$("#color-picker").append("<div class='col-xs-1' style='padding: 0px' align='center'><div class='create-circle-color '  onclick='setStuffTypeColor("+e.data[t].id+",0)' value="+e.data[t].id+"></div></div>"),$(".create-circle-color[value='"+e.data[t].id+"']").css("background-color",e.data[t].color_code)}if(e.layer_two.length>0){$("#color-picker-render-2").css("display","inline-block");for(var t=0;t<e.layer_two.length;t++)$("#color-picker-2").append("<div class='col-xs-1' style='padding: 0px' align='center'><div class='create-circle-color '  onclick='setStuffTypeColor("+e.layer_two[t].id+",1)' value="+e.layer_two[t].id+"></div></div>"),$(".create-circle-color[value='"+e.layer_two[t].id+"']").css("background-color",e.layer_two[t].color_code)}},error:function(){console.log("API stuff_color ERROR !!")}}),e.data.length>0){"TYPE"!=e.data[0].type&&"NECK"!=e.data[0].type&&"BODY"!=e.data[0].type&&$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='resetSubBar("+t+")'><div class='stuff-side-padding'><div class='stuff-pick-empty stuff-circle-hover'></div></div></div>");for(var a=0;a<e.data.length;a++)$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+e.data[a].id+")'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+e.data[a].img+"' alt='"+e.data[a].name+"'></div></div>");$("#subBarMenu").append("<div class='row' style='margin-bottom: 93px'></div>")}document.getElementById("subSlideBar").style.width="110px"},error:function(){console.log("API subBarClick ERROR !!")}})}function resetSubBar(e){for(var t=0;t<stuff_picker.length;t++)stuff_picker[t].type_id==e&&stuff_picker.splice(t,1);$(".stuff-pick-right[value='"+e+"']").css("border-style","solid").css("border-color","white"),$(".stuff-type-left-img[value='"+e+"']").css("background-image","url()"),renderStuff()}function setStuffTypeColor(e,t){$.ajax({url:"/api/v1/creates/find_color",type:"get",dataType:"json",data:{color_id:e},success:function(e){if(e){if($(".stuff-pick-right[value='"+current_type_id+"']").css("border","5px").css("border-style","solid").css("border-color",e.data),$(".stuff-type-right-img[value='"+current_type_id+"']").css("top","13px").css("left","11.5px"),0==t)for(var a=0;a<stuff_picker.length;a++)stuff_picker[a].type_id==current_type_id&&(stuff_picker[a].color_code_0=e.data,stuff_picker[a].color_code_0_name=e.name);if(1==t)for(var a=0;a<stuff_picker.length;a++)stuff_picker[a].type_id==current_type_id&&(stuff_picker[a].color_code_1=e.data,stuff_picker[a].color_code_1_name=e.name);renderStuff()}},error:function(){console.log("API find_stuff ERROR !!")}})}function stuff_click(e){$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:e},success:function(t){if(t){"TYPE"==t.data.stuff_type_name&&$.ajax({url:"/api/v1/creates/find_stuff_texture_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if(e.texture.length>0){e.texture.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),$("#texture-picker").empty();for(var t=0;t<e.texture.length;t++)$("#texture-picker").append("<div class='col-xs-2' style='margin-right: 5px;padding: 0px' align='center'><div class='create-circle-texture '  onclick='setTexture("+e.texture[t].id+")' value="+e.texture[t].id+"></div></div>"),$(".create-circle-texture[value='"+e.texture[t].id+"']").css("background-image",'url("'+e.texture[t].img+'")'),0==t&&setTexture(e.texture[t].id)}else $("#texture-picker").empty();if(e.size.length>0){stuff_price=[];for(var t=0;t<e.size.length;t++)tmp={id:e.size[t].id,name:e.size[t].name,sex:e.size[t].sex,price:e.size[t].base_price,priority:e.size[t].priority},stuff_price.push(tmp);$("#stuff_calculate_price").css("display","")}e.promotion&&(document.getElementById("promotion_img").src=e.promotion,$("#stuff_type_promotion").css("display","")),renderPrice()}},error:function(){console.log("API find_stuff_texture ERROR !!")}});for(var a=!0,r=0;r<stuff_picker.length;r++)stuff_picker[r].type_id==t.data.stuff_type_id&&(stuff_picker[r].stuff_id=e,stuff_picker[r].price=t.data.stuff_price,a=!1);a&&stuff_picker.push({type_id:t.data.stuff_type_id,stuff_id:e,stuff_type_name:t.data.stuff_type_name,stuff_type_priority:t.data.stuff_type_priority,price:t.data.stuff_price});var i=!0;"LOGO"==t.data.stuff_type_name&&(logoUpload(t),i=!1),i&&$(".stuff-type-left-img[value='"+t.data.stuff_type_id+"']").css("background-image","url("+t.data.stuff_img+")").css("background-size","contain").css("background-repeat","no-repeat"),"LOGO"!=t.data.stuff_type_name&&renderStuff()}},error:function(){console.log("API find_stuff ERROR !!")}})}function logoUpload(e){current_logo=e,$("#logo_upload_modal").modal("show")}function drawLogo(e,t,a){var r=new Image;r.onload=function(){var e=document.getElementById("tmp_canvas"),i=e.getContext("2d");i.clearRect(0,0,e.width,e.height),i.drawImage(r,t,a,100,100);var o=i.getImageData(0,0,e.width,e.height),s=document.getElementById("order_canvas"),n=s.getContext("2d"),c=convertCanvasToImage(s);n.drawImage(c,0,0);for(var f=n.getImageData(0,0,s.width,s.height),l=0;l<o.data.length;l+=4)o.data[l+3]=f.data[l+3]*o.data[l+3];var d=document.getElementById("tmp_canvas"),u=d.getContext("2d");u.clearRect(0,0,d.width,d.height),u.putImageData(o,0,0);var _=convertCanvasToImage(d);ctx.drawImage(_,0,0),setImgToSummary()},r.src=window.location.origin+e}function renderLogo(e){for(var t=!1,a=0;a<stuff_picker.length;a++)if("LOGO"==stuff_picker[a].stuff_type_name){stuff_picker[a].logo_front_l&&drawLogo(stuff_picker[a].logo_front_l.img_path,460,220),stuff_picker[a].logo_front_r&&drawLogo(stuff_picker[a].logo_front_r.img_path,270,220),stuff_picker[a].logo_left_arm&&drawLogo(stuff_picker[a].logo_left_arm.img_path,650,160),stuff_picker[a].logo_right_arm&&drawLogo(stuff_picker[a].logo_right_arm.img_path,70,160),t=!0;break}e(t?"All Logo has been render":"can't find any logo to render")}function addTexture(e,t,a){$.ajax({url:"/api/v1/creates/find_texture",type:"get",dataType:"json",data:{texture_id:t},success:function(t){t&&(stuff_picker[e].texture_id=t.data.id,stuff_picker[e].texture_name=t.data.name,stuff_picker[e].texture_price=t.data.price,stuff_picker[e].texture_img=t.img,stuff_picker[e].status_flexible=t.data.status_flexible,stuff_picker[e].status_thick=t.data.status_thick,stuff_picker[e].status_velvety=t.data.status_velvety,renderStuff()),a(e)},error:function(){console.log("API find_texture ERROR !!"),a(e)}})}function setTexture(e){for(var t=!1,a=0;a<stuff_picker.length;a++)if("TYPE"==stuff_picker[a].stuff_type_name){addTexture(a,e,function(e){renderPreviewTexture(stuff_picker[e])}),t=!0;break}t||$("#type_first").modal("show")}function renderPreviewTexture(e){$("#stuff_texture_preview").css("display",""),$("#stuff_texture_preview_name").empty(),$("#stuff_texture_preview_name").append(e.texture_name),$("#stuff_texture_preview_img").css("background-image","url("+e.texture_img+")").css("background-repeat","no-repeat").css("background-size","cover"),5==e.status_flexible&&$("#flexible_star5").prop("checked",!0),4==e.status_flexible&&$("#flexible_star4").prop("checked",!0),3==e.status_flexible&&$("#flexible_star3").prop("checked",!0),2==e.status_flexible&&$("#flexible_star2").prop("checked",!0),1==e.status_flexible&&$("#flexible_star1").prop("checked",!0),5==e.status_thick&&$("#thick_star5").prop("checked",!0),4==e.status_thick&&$("#thick_star4").prop("checked",!0),3==e.status_thick&&$("#thick_star3").prop("checked",!0),2==e.status_thick&&$("#thick_star2").prop("checked",!0),1==e.status_thick&&$("#thick_star1").prop("checked",!0),5==e.status_velvety&&$("#velvety_star5").prop("checked",!0),4==e.status_velvety&&$("#velvety_star4").prop("checked",!0),3==e.status_velvety&&$("#velvety_star3").prop("checked",!0),2==e.status_velvety&&$("#velvety_star2").prop("checked",!0),1==e.status_velvety&&$("#velvety_star1").prop("checked",!0)}function calculatePrice(e){for(var t=[],a=0;a<e.length;a++){for(var r=0,i=0,o=0;o<stuff_picker.length;o++)if("TYPE"==stuff_picker[o].stuff_type_name){r=e[a].price*stuff_picker[o].texture_price;break}for(var o=0;o<stuff_picker.length;o++)"TYPE"!=stuff_picker[o].stuff_type_name&&(i+=stuff_picker[o].price*r/100);var s=Math.round(r+i);t.push({name:e[a].name,price:s,sex:e[a].sex,priority:e[a].priority})}return t}function renderPrice(){$("#calculate_list_male").empty(),$("#calculate_list_female").empty();var e=calculatePrice(stuff_price);e.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var t=0;t<e.length;t++)"male"==e[t].sex?$("#calculate_list_male").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>"):"female"==e[t].sex&&$("#calculate_list_female").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>")}function amountPrice(){var e=[],t=calculatePrice(stuff_price),a=0;stuff_price.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),t.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var r=0;r<t.length;r++)for(var i=0;i<stuff_price.length;i++){var o=document.getElementsByName(stuff_price[i].name+"_"+stuff_price[i].sex)[0].value;if(stuff_price[i].name+stuff_price[i].sex==t[r].name+t[r].sex&&void 0!=o){e.push({size:stuff_price[i].name+"_"+stuff_price[i].sex,amount:document.getElementsByName(stuff_price[i].name+"_"+stuff_price[i].sex)[0].value,price_per_unit:t[r].price}),a+=o*t[r].price;break}}return e}function renderLoading(e,t){e?(console.log("renderLoading ",e),$("#order_canvas").css("display","none"),$("#loading_gif").fadeIn(10),setTimeout(function(){t()},800)):(console.log("renderLoading ",e),$("#loading_gif").fadeOut(100),$("#order_canvas").fadeIn(800))}function hex2rgb(e){return r=e.match(/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i),r?r.slice(1,4).map(function(e){return parseInt(e,16)}):(r=e.match(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i),r?r.slice(1,4).map(function(e){return 17*parseInt(e,16)}):null)}function convertCanvasToImage(e){var t=new Image;return t.src=e.toDataURL("image/png"),t}function renderStuff(){ctx.clearRect(0,0,canvas.width,canvas.height),renderLoading(!0,function(){renderPrice(),stuff_picker.sort(function(e,t){return parseFloat(e.stuff_type_priority)-parseFloat(t.stuff_type_priority)});for(var e=0;e<stuff_picker.length;e++)q.push({data:[stuff_picker[e].stuff_id,stuff_picker[e].stuff_type_name,stuff_picker[e].color_code_0,stuff_picker[e].color_code_1]},function(e,t,a,r,i,o){var s=!0;if(void 0!=a&&null!=i){var n=hex2rgb(a),c=document.getElementById("tmp_canvas"),f=c.getContext("2d");f.clearRect(0,0,c.width,c.height),f.drawImage(i,0,0);for(var l=f.getImageData(0,0,i.width,i.height),d=0;d<l.data.length;d+=4)l.data[d]=n[0]*(l.data[d]/255),l.data[d+1]=n[1]*(l.data[d+1]/255),l.data[d+2]=n[2]*(l.data[d+2]/255);f.putImageData(l,0,0);var u=convertCanvasToImage(c);ctx.drawImage(u,0,0),s=!1,console.log("finished processing color:",t," ","img 1")}if(void 0!=r&&null!=o){var n=hex2rgb(r),c=document.getElementById("tmp_canvas"),f=c.getContext("2d");f.clearRect(0,0,c.width,c.height),f.drawImage(o,0,0);for(var l=f.getImageData(0,0,o.width,o.height),d=0;d<l.data.length;d+=4)l.data[d]=n[0]*(l.data[d]/255),l.data[d+1]=n[1]*(l.data[d+1]/255),l.data[d+2]=n[2]*(l.data[d+2]/255);f.putImageData(l,0,0);var u=convertCanvasToImage(c);ctx.drawImage(u,0,0),s=!1,console.log("finished processing color:",t," ","img 2")}s&&null!=i&&ctx.drawImage(i,0,0),setImgToSummary(),console.log("finished processing :",t)})})}function setImgToSummary(){var e=convertCanvasToImage(canvas);$(".summaryModal_img").empty(),$(".summaryModal_img").append("<img src='"+e.src+"' style='width: 100%'>")}var current_type_id=0,stuff_picker=[],stuff_price=[],current_logo=null,q=async.queue(function(e,t){var a=e.data[0],r=e.data[1],i=e.data[2],o=e.data[3];$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:a},success:function(e){if(e){var s=e.data.stuff_product_img,n=new Image;s?n.onload=function(){if(""!=e.data.stuff_product_img_two){var s=e.data.stuff_product_img_two,c=new Image;c.onload=function(){t(a,r,i,o,n,c)},c.src=s}else t(a,r,i,o,n,null)}:"LOGO"==r&&renderLogo(function(e){console.log(e),t(a,r,i,o,null,null)}),n.src=s}},error:function(){console.log("API find_stuff ERROR !!")}})},1);q.drain=function(){console.log("all STUFF have been processed"),renderLoading(!1,function(){})};var canvas=document.getElementById("order_canvas"),ctx=canvas.getContext("2d");$(document).ready(function(){$.ajax({url:"/api/v1/creates/prepare_default_stuff",type:"get",success:function(e){if(e){var t=e.type_side.id,a=e.type_side.name;t&&a&&checkNav(a,t);var r=e.body.id;r&&stuff_click(r);var i=e.neck.id;i&&stuff_click(i);var t=e.type.id;t&&stuff_click(t)}else console.log("API prepare_default_stuff cant find stuff")},error:function(){console.log("API prepare_default_stuff ERROR !!")}}),document.getElementById("logo_upload").onchange=function(){var e=this.value.split("\\");document.getElementById("upload_file_name").innerHTML=e[e.length-1]},$("#stuff_size_input").change(function(){for(var e=calculatePrice(stuff_price),t=0,a=0;a<e.length;a++)for(var r=0;r<stuff_price.length;r++){var i=document.getElementsByName(stuff_price[r].name+"_"+stuff_price[r].sex)[0].value;if(stuff_price[r].name+stuff_price[r].sex==e[a].name+e[a].sex&&void 0!=i){console.log(stuff_price[r].name+"_"+stuff_price[r].sex),t+=i*e[a].price;break}}console.log("TOTAL = ",t),document.getElementById("total_price").innerHTML=t+".- BATH"}),$("#make_order").click(function(){if(document.getElementById("total_price").innerHTML="0.- BATH",stuff_picker.length>0){for(var e=-100,t=0;t<stuff_picker.length;t++)if("TYPE"==stuff_picker[t].stuff_type_name){e=stuff_picker[t].stuff_id;break}e!=-100?$.ajax({url:"/api/v1/creates/find_stuff_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if($("#stuff_size_input").empty(),e.data_stuffSize_male.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e0a\u0e32\u0e22</h4></div>");for(var t=0;t<e.data_stuffSize_male.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_male[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_male[t].name+"_"+e.data_stuffSize_male[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_male[t].stuff_id+"' style='width: 50px'> </div> ")}if(e.data_stuffSize_female.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e2b\u0e0d\u0e34\u0e07</h4></div>");for(var t=0;t<e.data_stuffSize_female.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_female[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_female[t].name+"_"+e.data_stuffSize_female[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_female[t].stuff_id+"' style='width: 50px'> </div> ")}$("#summaryModal").modal("show")}},error:function(){console.log("API find_stuff_size ERROR !!")}}):$("#incomplete_modal").modal("show")}else $("#incomplete_modal").modal("show")}),$("#make_order_amount").click(function(){console.log("make_order_amount")}),$("#make_order_address").on("click",function(){console.log("make_order_address");var e=$("#first_name").val(),t=$("#email").val(),a=$("#tel").val(),r=$("#address").val(),i=$("#company_name").val(),o=$("#company_branch").val(),s=$("#tax_identification_number").val(),n=stuff_picker,c=stuff_price,f=amountPrice(),l={first_name:e,email:t,tel:a,address:r,company_name:i,company_branch:o,tax_identification_number:s,estimate_cost:JSON.stringify(f),stuff_picker:JSON.stringify(n),base_price:JSON.stringify(c)};console.log("========= order_data ========="),console.log(l),$.ajax({url:"/api/v1/creates/make_order",type:"post",dataType:"json",data:l,success:function(e){if(e){console.log("make_order_data"),console.log(e);for(var t=document.getElementById("order_canvas"),a=t.toDataURL(),r=atob(a.split(",")[1]),i=[],o=0;o<r.length;o++)i.push(r.charCodeAt(o));var s=new Blob([new Uint8Array(i)],{type:"image/png"}),n=new FormData;n.append("img",s),n.append("order_id",e.order_id),$.ajax({url:"/api/v1/creates/save_order_img",method:"POST",data:n,processData:!1,contentType:!1,success:function(e){$("#addressModal").modal("hide"),1==e.status?$("#thxModal").modal("show"):$("#problemModal").modal("show")},error:function(e){console.log(e),console.log("API save_order_img ERROR !!")}})}},error:function(e){console.log(e),console.log("API make_order ERROR !!")}})}),$("#logo_width").change(function(){$("#expect_logo_width").val(Math.round(.39*$("#logo_width").val()*200))}),$("#logo_height").change(function(){$("#expect_logo_height").val(Math.round(.39*$("#logo_height").val()*200))}),$("#logo_upload").change(function(){var e,t,a=window.URL||window.webkitURL;(e=$("#logo_upload")[0].files[0])&&(t=new Image,t.onload=function(){console.log("logo_upload W : H = "+this.width+" : "+this.height),document.getElementById("max_width_of_upload_file").innerHTML="\u0e01\u0e27\u0e49\u0e32\u0e07 : "+this.width+"px",document.getElementById("max_height_of_upload_file").innerHTML="\u0e2a\u0e39\u0e07 : "+this.height+"px"},t.onerror=function(){alert("not a valid file: "+e.type)},t.src=a.createObjectURL(e))}),$("#logo_upload_btn").click(function(){if(""==$("#logo_upload").val()||"0"==$("#logo_width").val()&&"0"==$("#logo_height").val()||void 0==$("input[name='color_number']:checked").val())$("#upload_alert").modal("show");else{console.log("width expect with 200dpi = ",Math.round(.39*$("#logo_width").val()*200)),console.log("height expect with 200dpi = ",Math.round(.39*$("#logo_height").val()*200));var e,t,a=Math.round(.39*$("#logo_width").val()*200),r=Math.round(.39*$("#logo_height").val()*200),i=window.URL||window.webkitURL;(e=$("#logo_upload")[0].files[0])&&(t=new Image,t.onload=function(){if(console.log("uploaded W : H = "+this.width+" : "+this.height),a>this.width||r>this.height)alert("\u0e23\u0e39\u0e1b\u0e20\u0e32\u0e1e \u0e01\u0e31\u0e1a \u0e02\u0e19\u0e32\u0e14\u0e44\u0e21\u0e48\u0e1c\u0e48\u0e32\u0e19\u0e02\u0e49\u0e2d\u0e01\u0e33\u0e2b\u0e19\u0e14 \u0e01\u0e27\u0e49\u0e32\u0e07 \u0e2a\u0e39\u0e07 "+this.width+" "+this.height);else if(a<=this.width||r<=this.height){var e=new FormData;e.append("img",$("#logo_upload")[0].files[0]),e.append("color_number",$("input[name='color_number']:checked").val()),$.ajax({url:"/api/v1/creates/save_logo_img",method:"POST",data:e,processData:!1,contentType:!1,success:function(e){if($("#logo_upload").val(""),e){for(var t=0;t<stuff_picker.length;t++)if("LOGO"==stuff_picker[t].stuff_type_name){stuff_picker[t][current_logo.data.stuff.name]={img_path:e.img_original,img_id:e.data.id,width:$("#logo_width").val(),height:$("#logo_height").val()},current_logo.data.stuff_type_id&&e.img_thumb&&$(".stuff-type-left-img[value='"+current_logo.data.stuff_type_id+"']").css("background-image","url("+e.img_thumb+")").css("background-size","contain").css("background-repeat","no-repeat").css("filter","invert(0)");break}renderStuff(),document.getElementById("upload_file_name").innerHTML="",document.getElementById("max_width_of_upload_file").innerHTML="",document.getElementById("max_height_of_upload_file").innerHTML="",$("#logo_upload_modal").modal("hide")}},error:function(e){console.log(e),console.log("API save_logo_img ERROR !!")}})}},t.onerror=function(){alert("Not a valid file: "+e.type)},t.src=i.createObjectURL(e))}}),$("#stuff_type_promotion_btn").click(function(){$("#promotion_modal").modal("show")})});