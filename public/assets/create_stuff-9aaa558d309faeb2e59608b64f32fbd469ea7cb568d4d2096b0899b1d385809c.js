function checkNav(e,t){for(var a=!1,o=0;o<stuff_picker.length;o++)"TYPE"==stuff_picker[o].stuff_type_name&&(a=!0);"TYPE"==e&&(a=!0),$(".cursor-arrow[value='"+current_type_id+"']").css("display","none"),a?(current_type_id=t,openNav(e,t)):$("#type_first").modal("show"),$(".cursor-arrow[value='"+current_type_id+"']").css("display","")}function stuffColorSelect(e,t){console.log("stuffColorSelect type_id",e),console.log("stuffColorSelect stuff_id",t),t!=-99&&$.ajax({url:"/api/v1/creates/stuff_color",type:"get",dataType:"json",data:{type_id:e,stuff_id:t},success:function(t){if(document.getElementById("color-picker").innerHTML="",document.getElementById("color-picker-2").innerHTML="",t.data.length>0){$("#color-picker-render-1").css("display","inline-block");for(var a=0;a<t.data.length;a++)$("#color-picker").append("<div class='create-circle-color' onclick='setStuffTypeColor("+t.data[a].id+",0,"+e+")' value="+t.data[a].id+"></div>"),$(".create-circle-color[value='"+t.data[a].id+"']").css("background-color",t.data[a].color_code)}if(t.layer_two.length>0){$("#color-picker-render-2").css("display","inline-block");for(var a=0;a<t.layer_two.length;a++)$("#color-picker-2").append("<div class='create-circle-color ' onclick='setStuffTypeColor("+t.layer_two[a].id+",1,"+e+")' value="+t.layer_two[a].id+"></div>"),$(".create-circle-color[value='"+t.layer_two[a].id+"']").css("background-color",t.layer_two[a].color_code)}},error:function(e){console.log(e)}})}function openNav(e,t){stuffColorChangeBtn(0,t),stuffColorChangeBtn(1,t),$("#subBarMenu").empty(),$.ajax({url:"/api/v1/creates/subBarClick",type:"get",dataType:"json",data:{type_id:t},success:function(a){if("TYPE"!=e||"ARM"!=e||"BOTTOM"!=e||"LOGO"!=e)for(var o=-99,r=0;r<stuff_picker.length;r++)if(stuff_picker[r].type_id==t){o=stuff_picker[r].stuff_id,stuffColorSelect(t,o);break}if(a.data.length>0){"TYPE"!=a.data[0].type&&"NECK"!=a.data[0].type&&"BODY"!=a.data[0].type&&"PLACKET"!=a.data[0].type&&$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='resetSubBar("+t+")'><div class='stuff-side-padding'><div class='stuff-pick-empty stuff-circle-hover'></div></div></div>");for(var r=0;r<a.data.length;r++){for(var i=-99,c=0;c<stuff_picker.length;c++)if("TYPE"==stuff_picker[c].stuff_type_name){i=stuff_picker[c].stuff_id;break}""!=a.data[r].belong_to_type?a.data[r].belong_to_type==i&&$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+a.data[r].id+",true)'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+a.data[r].img+"' alt='"+a.data[r].name+"'></div></div>"):$("#subBarMenu").append("<div class='row' style='margin-bottom: 20px' onclick='stuff_click("+a.data[r].id+",true)'><div class='stuff-side-padding' ><img class='stuff-side-img stuff-side-circle stuff-circle-hover' src='"+a.data[r].img+"' alt='"+a.data[r].name+"'></div></div>")}$("#subBarMenu").append("<div class='row' style='margin-bottom: 93px'></div>")}document.getElementById("subSlideBar").style.width="110px"},error:function(e){console.log("API subBarClick ERROR !!"),console.log(e)}})}function resetSubBar(e){for(var t=0;t<stuff_picker.length;t++)stuff_picker[t].type_id==e&&stuff_picker.splice(t,1);$(".stuff-pick-right[value='"+e+"']").css("border-style","solid").css("border-color","white"),$(".stuff-type-left-img[value='"+e+"']").css("background-image","url()"),renderStuff()}function stuffColorChangeBtn(e,t){for(var a=!1,o=0;o<stuff_picker.length;o++)stuff_picker[o].type_id==t&&(0==e&&(stuff_picker[o].color_code_0?$(".btn-color-1").css("background-color",stuff_picker[o].color_code_0):(console.log("stuffColorChangeBtn set btn-color-1 empty"),$(".btn-color-1").css("background-color",""))),1==e&&(stuff_picker[o].color_code_1?$(".btn-color-2").css("background-color",stuff_picker[o].color_code_1):(console.log("stuffColorChangeBtn set btn-color-2 empty"),$(".btn-color-2").css("background-color",""))),a=!0);a||(console.log("TYPE NOT EXISTED"),$(".color-picker-render").css("display","none"),$(".btn-color-1").css("background-color",""),$(".btn-color-2").css("background-color",""))}function setStuffTypeColor(e,t,a){console.log("setStuffTypeColor "),console.log(" type_id = ",a),$.ajax({url:"/api/v1/creates/find_color",type:"get",dataType:"json",data:{color_id:e},success:function(e){if(e){if($(".stuff-pick-right[value='"+a+"']").css("border","5px").css("border-style","solid").css("border-color",e.data),$(".stuff-type-right-img[value='"+a+"']").css("top","3px").css("left","3px"),0==t){for(var o=0;o<stuff_picker.length;o++)stuff_picker[o].type_id==a&&(stuff_picker[o].color_code_0=e.data,stuff_picker[o].color_code_0_name=e.name,stuff_picker[o].color_code_0_price=e.color_price);stuffColorChangeBtn(t,a)}if(1==t){for(var o=0;o<stuff_picker.length;o++)stuff_picker[o].type_id==a&&(stuff_picker[o].color_code_1=e.data,stuff_picker[o].color_code_1_name=e.name,stuff_picker[o].color_code_1_price=e.color_price);stuffColorChangeBtn(t,a)}renderStuff()}},error:function(){console.log("API find_stuff ERROR !!")}})}function stuff_click(e,t){$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:e},success:function(a){if(a){"TYPE"==a.data.stuff_type_name&&(1==t&&create_init(e),$.ajax({url:"/api/v1/creates/find_stuff_texture_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if(e.texture.length>0){e.texture.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),$("#texture-picker").empty();for(var t=0;t<e.texture.length;t++)$("#texture-picker").append("<div class='col-xs-2' style='margin-right: 5px;padding: 0px' align='center'><div class='create-circle-texture '  onclick='setTexture("+e.texture[t].id+")' value="+e.texture[t].id+"></div></div>"),$(".create-circle-texture[value='"+e.texture[t].id+"']").css("background-image",'url("'+e.texture[t].img+'")'),0==t&&setTexture(e.texture[t].id)}else $("#texture-picker").empty();if(e.size.length>0){stuff_price=[];for(var t=0;t<e.size.length;t++)tmp={id:e.size[t].id,name:e.size[t].name,sex:e.size[t].sex,price:e.size[t].base_price,priority:e.size[t].priority,add_option_price:e.size[t].add_option_price},stuff_price.push(tmp);$("#stuff_calculate_price").css("display","")}e.promotion&&(document.getElementById("promotion_img").src=e.promotion,$("#stuff_type_promotion").css("display","")),renderPrice()}},error:function(){console.log("API find_stuff_texture ERROR !!")}}));var o=0;""!=a.data.stuff_additional_price&&(o=parseFloat(a.data.stuff_additional_price));for(var r=!0,i=0;i<stuff_picker.length;i++)stuff_picker[i].type_id==a.data.stuff_type_id&&(stuff_picker[i].stuff_id=e,stuff_picker[i].price=a.data.stuff_price,stuff_picker[i].additional_price=o,r=!1);r&&stuff_picker.push({type_id:a.data.stuff_type_id,stuff_id:e,stuff_type_name:a.data.stuff_type_name,stuff_type_priority:a.data.stuff_type_priority,price:a.data.stuff_price,additional_price:o});var c=!0;"LOGO"==a.data.stuff_type_name&&(logoUpload(a),c=!1),c&&$(".stuff-type-left-img[value='"+a.data.stuff_type_id+"']").css("background-image","url("+a.data.stuff_img+")").css("background-size","contain").css("background-repeat","no-repeat"),"LOGO"!=a.data.stuff_type_name&&1==t&&(renderStuff(),"TYPE"!=a.data.stuff_type_name&&stuffColorSelect(current_type_id,e)),$.ajax({url:"/api/v1/creates/random_color_by_stuff",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){e&&(console.log(e),"TYPE"!=e.typeName&&"LOGO"!=e.typeName&&(e.randColor_0?setStuffTypeColor(e.randColor_0.id,0,e.type_id):console.log(e.typeName+" Color layer 0 not found !"),e.randColor_1?setStuffTypeColor(e.randColor_1.id,1,e.type_id):console.log(e.typeName+" Color layer 1 not found !")))},error:function(e){console.log(e)}})}},error:function(){console.log("API find_stuff ERROR !!")}})}function logoUpload(e){current_logo=e,$("#logo_upload_modal").modal("show")}function drawLogo(e,t,a){var o=new Image;o.onload=function(){var e=document.getElementById("tmp_canvas"),r=e.getContext("2d");r.clearRect(0,0,e.width,e.height),r.drawImage(o,t,a,100,100);var i=r.getImageData(0,0,e.width,e.height),c=document.getElementById("order_canvas"),s=c.getContext("2d");convertCanvasToImage(c,function(e){s.drawImage(e,0,0);for(var t=s.getImageData(0,0,c.width,c.height),a=0;a<i.data.length;a+=4)i.data[a+3]=t.data[a+3]*i.data[a+3];var o=document.getElementById("tmp_canvas"),r=o.getContext("2d");r.clearRect(0,0,o.width,o.height),r.putImageData(i,0,0),convertCanvasToImage(o,function(e){ctx.drawImage(e,0,0),setImgToSummary()})})},o.src=window.location.origin+e}function renderLogo(e){for(var t=!1,a=0;a<stuff_picker.length;a++)if("LOGO"==stuff_picker[a].stuff_type_name){stuff_picker[a].logo_front_l&&drawLogo(stuff_picker[a].logo_front_l.img_path,460,220),stuff_picker[a].logo_front_r&&drawLogo(stuff_picker[a].logo_front_r.img_path,240,220),stuff_picker[a].logo_left_arm&&drawLogo(stuff_picker[a].logo_left_arm.img_path,650,160),stuff_picker[a].logo_right_arm&&drawLogo(stuff_picker[a].logo_right_arm.img_path,70,160),t=!0;break}e(t?"All Logo has been render":"can't find any logo to render")}function addTexture(e,t,a){$.ajax({url:"/api/v1/creates/find_texture",type:"get",dataType:"json",data:{texture_id:t},success:function(t){t&&(stuff_picker[e].texture_id=t.data.id,stuff_picker[e].texture_name=t.data.name,stuff_picker[e].texture_price=t.data.price,stuff_picker[e].texture_img=t.img,stuff_picker[e].status_flexible=t.data.status_flexible,stuff_picker[e].status_thick=t.data.status_thick,stuff_picker[e].status_velvety=t.data.status_velvety),a(e)},error:function(){console.log("API find_texture ERROR !!"),a(e)}})}function setTexture(e){for(var t=!1,a=0;a<stuff_picker.length;a++)if("TYPE"==stuff_picker[a].stuff_type_name){addTexture(a,e,function(e){renderPreviewTexture(stuff_picker[e]),renderPrice()}),t=!0;break}t||$("#type_first").modal("show")}function renderPreviewTexture(e){$("#stuff_texture_preview").css("display",""),$("#stuff_texture_preview_name").empty(),$("#stuff_texture_preview_name").append(e.texture_name),$("#stuff_texture_preview_img").css("background-image","url("+e.texture_img+")").css("background-repeat","no-repeat").css("background-size","cover"),5==e.status_flexible&&$("#flexible_star5").prop("checked",!0),4==e.status_flexible&&$("#flexible_star4").prop("checked",!0),3==e.status_flexible&&$("#flexible_star3").prop("checked",!0),2==e.status_flexible&&$("#flexible_star2").prop("checked",!0),1==e.status_flexible&&$("#flexible_star1").prop("checked",!0),5==e.status_thick&&$("#thick_star5").prop("checked",!0),4==e.status_thick&&$("#thick_star4").prop("checked",!0),3==e.status_thick&&$("#thick_star3").prop("checked",!0),2==e.status_thick&&$("#thick_star2").prop("checked",!0),1==e.status_thick&&$("#thick_star1").prop("checked",!0),5==e.status_velvety&&$("#velvety_star5").prop("checked",!0),4==e.status_velvety&&$("#velvety_star4").prop("checked",!0),3==e.status_velvety&&$("#velvety_star3").prop("checked",!0),2==e.status_velvety&&$("#velvety_star2").prop("checked",!0),1==e.status_velvety&&$("#velvety_star1").prop("checked",!0)}function calculatePrice(e){for(var t=[],a=0;a<e.length;a++){for(var o=0,r=0,i=0,c=0;c<stuff_picker.length;c++)if("TYPE"==stuff_picker[c].stuff_type_name){for(var s=1,n=0;n<stuff_picker.length;n++)stuff_picker[n].color_code_0_price&&(s+=stuff_picker[n].color_code_0_price),stuff_picker[n].color_code_1_price&&(s+=stuff_picker[n].color_code_1_price);console.log("Totals color_factor = ",s),o=(stuff_picker[c].texture_price+s)*e[a].price;break}for(var c=0;c<stuff_picker.length;c++)"TYPE"!=stuff_picker[c].stuff_type_name?r=r+stuff_picker[c].price*o/100+stuff_picker[c].additional_price:"TYPE"==stuff_picker[c].stuff_type_name&&(i=stuff_picker[c].price);var f=Math.round(o+r+i),l=0;document.getElementById("create_add_height").checked&&(console.log("add_option_price = "+e[a].add_option_price),l=e[a].add_option_price*f/100),f+=l,t.push({name:e[a].name,price:f,sex:e[a].sex,priority:e[a].priority})}return t}function renderPrice(){$("#calculate_list_male").empty(),$("#calculate_list_female").empty();var e=calculatePrice(stuff_price);e.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var t=0;t<e.length;t++)"male"==e[t].sex?$("#calculate_list_male").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>"):"female"==e[t].sex&&$("#calculate_list_female").append("<div class='row'><div class='col-xs-6'style='padding-left: 30px'>"+e[t].name+"</div><div class='col-xs-6' style='padding-right: 30px' align='right'>"+e[t].price+"</div></div>")}function amountPrice(){var e=[],t=calculatePrice(stuff_price),a=0;stuff_price.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)}),t.sort(function(e,t){return parseFloat(e.priority)-parseFloat(t.priority)});for(var o=0;o<t.length;o++)for(var r=0;r<stuff_price.length;r++){var i=document.getElementsByName(stuff_price[r].name+"_"+stuff_price[r].sex)[0].value;if(stuff_price[r].name+stuff_price[r].sex==t[o].name+t[o].sex&&void 0!=i){e.push({size:stuff_price[r].name+"_"+stuff_price[r].sex,amount:document.getElementsByName(stuff_price[r].name+"_"+stuff_price[r].sex)[0].value,price_per_unit:t[o].price}),a+=i*t[o].price;break}}return e}function renderLoading(e,t){e?(console.log("renderLoading ",e),$("#order_canvas").css("display","none"),$("#loading_gif").fadeIn(10),setTimeout(function(){t()},800)):(console.log("renderLoading ",e),$("#loading_gif").fadeOut(100),$("#order_canvas").fadeIn(800))}function hex2rgb(e){return r=e.match(/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i),r?r.slice(1,4).map(function(e){return parseInt(e,16)}):(r=e.match(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i),r?r.slice(1,4).map(function(e){return 17*parseInt(e,16)}):null)}function convertCanvasToImage(e,t){var a=new Image;a.src=e.toDataURL("image/png"),a.onload=function(){t(a)}}function renderStuff(){ctx.clearRect(0,0,canvas.width,canvas.height),renderLoading(!0,function(){renderPrice(),stuff_picker.sort(function(e,t){return parseFloat(e.stuff_type_priority)-parseFloat(t.stuff_type_priority)});for(var e=0;e<stuff_picker.length;e++)q.push({data:[stuff_picker[e].stuff_id,stuff_picker[e].stuff_type_name,stuff_picker[e].color_code_0,stuff_picker[e].color_code_1]},function(e,t,a,o,r,i){var c=!0;if(void 0!=a&&null!=r){var s=hex2rgb(a),n=document.getElementById("tmp_canvas"),f=n.getContext("2d");f.clearRect(0,0,n.width,n.height),f.drawImage(r,0,0);for(var l=f.getImageData(0,0,r.width,r.height),d=0;d<l.data.length;d+=4)l.data[d]=s[0]*(l.data[d]/255),l.data[d+1]=s[1]*(l.data[d+1]/255),l.data[d+2]=s[2]*(l.data[d+2]/255);f.clearRect(0,0,n.width,n.height),f.putImageData(l,0,0),convertCanvasToImage(n,function(e){ctx.drawImage(e,0,0)}),c=!1,console.log("finished processing color:",t," ","img 1")}if(void 0!=o&&null!=i){var u=hex2rgb(o),_=document.getElementById("tmp_canvas"),p=_.getContext("2d");p.clearRect(0,0,_.width,_.height),p.drawImage(i,0,0);for(var g=p.getImageData(0,0,i.width,i.height),d=0;d<g.data.length;d+=4)g.data[d]=u[0]*(g.data[d]/255),g.data[d+1]=u[1]*(g.data[d+1]/255),g.data[d+2]=u[2]*(g.data[d+2]/255);p.clearRect(0,0,_.width,_.height),p.putImageData(g,0,0),convertCanvasToImage(_,function(e){ctx.drawImage(e,0,0)}),c=!1,console.log("finished processing color:",t," ","img 2")}c&&null!=r&&ctx.drawImage(r,0,0),setImgToSummary(),console.log("finished processing :",t)})})}function setImgToSummary(){convertCanvasToImage(canvas,function(e){$(".summaryModal_img").empty(),$(".summaryModal_img").append("<img src='"+e.src+"' style='width: 100%'>")})}function create_init(e){$.ajax({url:"/api/v1/creates/prepare_default_stuff",type:"get",dataType:"json",data:{type_id:e},success:function(e){if(e){var t=e.type_side.id,a=e.type_side.name;if(t&&a&&checkNav(a,t),e.body){var o=e.body.id;stuff_click(o,!1)}if(e.neck){var r=e.neck.id;stuff_click(r,!1)}if(e.type){var t=e.type.id;stuff_click(t,!1)}if(e.placket){var i=e.placket.id;stuff_click(i,!1)}}else console.log("API prepare_default_stuff cant find stuff")},error:function(){console.log("API prepare_default_stuff ERROR !!")}})}var current_type_id=0,stuff_picker=[],stuff_price=[],current_logo=null,q=async.queue(function(e,t){var a=e.data[0],o=e.data[1],r=e.data[2],i=e.data[3];$.ajax({url:"/api/v1/creates/find_stuff",type:"get",dataType:"json",data:{stuff_id:a},success:function(e){if(e){var c=e.data.stuff_product_img,s=new Image;c?s.onload=function(){if(""!=e.data.stuff_product_img_two){var c=e.data.stuff_product_img_two,n=new Image;n.onload=function(){t(a,o,r,i,s,n)},n.src=c}else t(a,o,r,i,s,null)}:"LOGO"==o&&renderLogo(function(e){console.log(e),t(a,o,r,i,null,null)}),s.src=c}},error:function(){console.log("API find_stuff ERROR !!")}})},1);q.drain=function(){console.log("all STUFF have been processed"),renderLoading(!1,function(){})};var canvas=document.getElementById("order_canvas"),ctx=canvas.getContext("2d");$(document).ready(function(){create_init(-99),renderStuff(),document.getElementById("logo_upload").onchange=function(){var e=this.value.split("\\");document.getElementById("upload_file_name").innerHTML=e[e.length-1]},$("#stuff_size_input").change(function(){for(var e=calculatePrice(stuff_price),t=0,a=0;a<e.length;a++)for(var o=0;o<stuff_price.length;o++){var r=document.getElementsByName(stuff_price[o].name+"_"+stuff_price[o].sex)[0].value;if(stuff_price[o].name+stuff_price[o].sex==e[a].name+e[a].sex&&void 0!=r){console.log(stuff_price[o].name+"_"+stuff_price[o].sex),t+=r*e[a].price;break}}console.log("TOTAL = ",t),document.getElementById("total_price").innerHTML=t+".- BATH"}),$("#make_order").click(function(){if(document.getElementById("total_price").innerHTML="0.- BATH",stuff_picker.length>0){for(var e=-100,t=0;t<stuff_picker.length;t++)if("TYPE"==stuff_picker[t].stuff_type_name){e=stuff_picker[t].stuff_id;break}e!=-100?$.ajax({url:"/api/v1/creates/find_stuff_size",type:"get",dataType:"json",data:{stuff_id:e},success:function(e){if(e){if($("#stuff_size_input").empty(),e.data_stuffSize_male.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e0a\u0e32\u0e22</h4></div>");for(var t=0;t<e.data_stuffSize_male.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_male[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_male[t].name+"_"+e.data_stuffSize_male[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_male[t].stuff_id+"' style='width: 50px'> </div> ")}if(e.data_stuffSize_female.length>0){$("#stuff_size_input").append("<div class='col-xs-12 col-sm-12 col-md-12 stuff-size-inline'><h4>\u0e2b\u0e0d\u0e34\u0e07</h4></div>");for(var t=0;t<e.data_stuffSize_female.length;t++)$("#stuff_size_input").append("<div class='col-xs-6 col-sm-6 col-md-4 stuff-size-inline'> <div class='stuff-inline' style='width: 30px'>"+e.data_stuffSize_female[t].name+" : </div> <input class='stuff-inline' type='number' min='0' name='"+e.data_stuffSize_female[t].name+"_"+e.data_stuffSize_female[t].sex+"' id='input-stuff-size-"+e.data_stuffSize_female[t].stuff_id+"' style='width: 50px'> </div> ")}$("#summaryModal").modal("show")}},error:function(){console.log("API find_stuff_size ERROR !!")}}):$("#incomplete_modal").modal("show")}else $("#incomplete_modal").modal("show")}),$("#make_order_amount").click(function(){console.log("make_order_amount")}),$("#make_order_address").on("click",function(){console.log("make_order_address");var e=$("#first_name").val(),t=$("#email").val(),a=$("#tel").val(),o=$("#address").val(),r=$("#company_name").val(),i=$("#company_branch").val(),c=$("#tax_identification_number").val(),s=stuff_picker,n=stuff_price,f=amountPrice(),l="";document.getElementById("create_add_height").checked&&(l="\u0e40\u0e1e\u0e34\u0e48\u0e21\u0e04\u0e27\u0e32\u0e21\u0e22\u0e32\u0e27\u0e40\u0e2a\u0e37\u0e49\u0e2d");var d={first_name:e,email:t,tel:a,address:o,company_name:r,company_branch:i,tax_identification_number:c,estimate_cost:JSON.stringify(f),stuff_picker:JSON.stringify(s),base_price:JSON.stringify(n),option_price_details:l};console.log("========= order_data ========="),console.log(d),$.ajax({url:"/api/v1/creates/make_order",type:"post",dataType:"json",data:d,success:function(e){if(e){console.log("make_order_data"),console.log(e);for(var t=document.getElementById("order_canvas"),a=t.toDataURL(),o=atob(a.split(",")[1]),r=[],i=0;i<o.length;i++)r.push(o.charCodeAt(i));var c=new Blob([new Uint8Array(r)],{type:"image/png"}),s=new FormData;s.append("img",c),s.append("order_id",e.order_id),$.ajax({url:"/api/v1/creates/save_order_img",method:"POST",data:s,processData:!1,contentType:!1,success:function(e){$("#addressModal").modal("hide"),1==e.status?$("#thxModal").modal("show"):$("#problemModal").modal("show")},error:function(e){console.log(e),console.log("API save_order_img ERROR !!")}})}},error:function(e){console.log(e),console.log("API make_order ERROR !!")}})}),$("#logo_width").change(function(){$("#expect_logo_width").val(Math.round(.39*$("#logo_width").val()*200))}),$("#logo_height").change(function(){$("#expect_logo_height").val(Math.round(.39*$("#logo_height").val()*200))}),$("#logo_upload").change(function(){var e,t,a=window.URL||window.webkitURL;(e=$("#logo_upload")[0].files[0])&&(t=new Image,t.onload=function(){console.log("logo_upload W : H = "+this.width+" : "+this.height),document.getElementById("max_width_of_upload_file").innerHTML="\u0e01\u0e27\u0e49\u0e32\u0e07 : "+this.width+"px",document.getElementById("max_height_of_upload_file").innerHTML="\u0e2a\u0e39\u0e07 : "+this.height+"px"},t.onerror=function(){alert("not a valid file: "+e.type)},t.src=a.createObjectURL(e))}),$("#logo_upload_btn").click(function(){if(""==$("#logo_upload").val()||"0"==$("#logo_width").val()&&"0"==$("#logo_height").val()||void 0==$("input[name='color_number']:checked").val())$("#upload_alert").modal("show");else{console.log("width expect with 200dpi = ",Math.round(.39*$("#logo_width").val()*200)),console.log("height expect with 200dpi = ",Math.round(.39*$("#logo_height").val()*200));var e,t,a=Math.round(.39*$("#logo_width").val()*200),o=Math.round(.39*$("#logo_height").val()*200),r=window.URL||window.webkitURL;(e=$("#logo_upload")[0].files[0])&&(t=new Image,t.onload=function(){if(console.log("uploaded W : H = "+this.width+" : "+this.height),a>this.width||o>this.height)alert("\u0e23\u0e39\u0e1b\u0e20\u0e32\u0e1e \u0e01\u0e31\u0e1a \u0e02\u0e19\u0e32\u0e14\u0e44\u0e21\u0e48\u0e1c\u0e48\u0e32\u0e19\u0e02\u0e49\u0e2d\u0e01\u0e33\u0e2b\u0e19\u0e14 \u0e01\u0e27\u0e49\u0e32\u0e07 \u0e2a\u0e39\u0e07 "+this.width+" "+this.height);else if(a<=this.width||o<=this.height){var e=new FormData;e.append("img",$("#logo_upload")[0].files[0]),e.append("color_number",$("input[name='color_number']:checked").val()),$.ajax({url:"/api/v1/creates/save_logo_img",method:"POST",data:e,processData:!1,contentType:!1,success:function(e){if($("#logo_upload").val(""),e){for(var t=0;t<stuff_picker.length;t++)if("LOGO"==stuff_picker[t].stuff_type_name){stuff_picker[t][current_logo.data.stuff.name]={img_path:e.img_original,img_id:e.data.id,width:$("#logo_width").val(),height:$("#logo_height").val()},current_logo.data.stuff_type_id&&e.img_thumb&&$(".stuff-type-left-img[value='"+current_logo.data.stuff_type_id+"']").css("background-image","url("+e.img_thumb+")").css("background-size","contain").css("background-repeat","no-repeat").css("filter","invert(0)");break}renderStuff(),document.getElementById("upload_file_name").innerHTML="",document.getElementById("max_width_of_upload_file").innerHTML="",document.getElementById("max_height_of_upload_file").innerHTML="",$("#logo_upload_modal").modal("hide")}},error:function(e){console.log(e),console.log("API save_logo_img ERROR !!")}})}},t.onerror=function(){alert("Not a valid file: "+e.type)},t.src=r.createObjectURL(e))}}),$("#stuff_type_promotion_btn").click(function(){$("#promotion_modal").modal("show")}),$("#create_add_height").change(function(){renderPrice();for(var e=calculatePrice(stuff_price),t=0,a=0;a<e.length;a++)for(var o=0;o<stuff_price.length;o++){var r=document.getElementsByName(stuff_price[o].name+"_"+stuff_price[o].sex)[0].value;if(stuff_price[o].name+stuff_price[o].sex==e[a].name+e[a].sex&&void 0!=r){console.log(stuff_price[o].name+"_"+stuff_price[o].sex),t+=r*e[a].price;break}}console.log("TOTAL = ",t),document.getElementById("total_price").innerHTML=t+".- BATH"}),$(".create-checkbox-position").on("change",function(){console.log($("input[name=create_pocket]:checked").val())})});