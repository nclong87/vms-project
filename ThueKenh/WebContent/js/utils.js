function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}
// set the radio button with the given value as being checked
// do nothing if there are no radio buttons
// if the given value does not exist, all the radio buttons
// are reset to unchecked
function setCheckedValue(radioObj, newValue) {
	if(!radioObj)
		return;
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
		if(radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}

function remove_accents( str ) {
	var r=str.toLowerCase();
	r = r.replace(new RegExp("[àáạảãâầấậẩẫăằắặẳẵ]", 'g'),"a");
	r = r.replace(new RegExp("[èéẹẻẽêềếệểễ]", 'g'),"e");
	r = r.replace(new RegExp("[ìíịỉĩîï]", 'g'),"i");
	r = r.replace(new RegExp("[öòóọỏõôồốộổỗơờớợởỡ]", 'g'),"o");
	r = r.replace(new RegExp("[ùúụủũưừứựửữûü]", 'g'),"u");
	r = r.replace(new RegExp("[ýÿỹỳỵ]", 'g'),"y");
	r = r.replace(new RegExp("[đ]", 'g'),"d");
	r = r.replace(new RegExp("[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]", 'g'),"A");
	r = r.replace(new RegExp("[ÈÉẸẺẼÊỀẾỆỂỄ]", 'g'),"E");
	r = r.replace(new RegExp("[ÌÍỊỈĨÎÏ]", 'g'),"I");
	r = r.replace(new RegExp("[ÖÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]", 'g'),"O");
	r = r.replace(new RegExp("[ÙÚỤỦŨƯỪỨỰỬỮÛÜ]", 'g'),"U");
	r = r.replace(new RegExp("[ÝŸỸỲỴ]", 'g'),"Y");
	r = r.replace(new RegExp("[Đ]", 'g'),"D");
	r = r.replace(new RegExp("æ", 'g'),"ae");
	r = r.replace(new RegExp("ç", 'g'),"c");
	r = r.replace(new RegExp("ñ", 'g'),"n");                            
	r = r.replace(new RegExp("œ", 'g'),"oe");
	return r;
}

function FormatMoney(str) {
	rs="";
	dem=0;
	for(i=str.length-1;i>=0;i--) {
		dem++;
		if(dem==3 && i>0)
		{
			rs="."+str.charAt(i)+rs;
			dem=0;
		}
		else
			rs=str.charAt(i)+rs;
	}
	return rs;
}
function getNumber(str) {
	rs = '';
	for(i=0;i<str.length;i++) {
		var c = str.charAt(i);
		if(c>='0' && c<='9')
			rs+=c;
	}
	return rs;
}
function MultiSelect(btadd,btremove,btaddall,btremoveall,select_left,select_right) {
	btadd = '#'+btadd;
	btremove = '#'+btremove;
	btaddall = '#'+btaddall;
	btremoveall = '#'+btremoveall;
	select_left = '#'+select_left;
	select_right = '#'+select_right;
	
	$(btadd).click(function() {			
		if($(select_left+' option:selected').length == 0) {
			alert('Bạn chưa chọn dòng ở cột bên trái!');
			return false;
		}	
		$(select_right+' option').each(function(){
			this.selected = false;
		});
		return !$(select_left+' option:selected').remove().appendTo(select_right);  
	});  
	$(btremove).click(function() {  
		if($(select_right+' option:selected').length == 0) {
			alert('Bạn chưa chọn dòng ở cột bên phải!');
			return false;
		}	
		return !$(select_right+' option:selected').remove().appendTo(select_left);  
	});  
	$(btaddall).click(function() {  
		return !$(select_left+' option').remove().appendTo(select_right);  
	});  
	$(btremoveall).click(function() {  
		return !$(select_right+' option').remove().appendTo(select_left);  
	}); 
	$(select_left).dblclick(function() {
		$(select_right+' option').each(function(){
			this.selected = false;
		});
		return !$(select_left+' option:selected').remove().appendTo(select_right);  
	});  
	$(select_right).dblclick(function() {			
		return !$(select_right+' option:selected').remove().appendTo(select_left);  
	}); 
}
function replaceText(str,reps) {
	/*var reps = {
		link_view_users_same_rate: "1",  //VN will be replace by "Ali" in str string
		num_same_rate: "2",
		rate_action: "3"
	};*/
	if (null==str){ return '';}
	return str.replace(/\[\[(.*?)\]\]/g, function(s, key) {
		return reps[key]==null?'':reps[key];
	});
	
}
var Timer = {
	interval : 1000,
	t : 0,
	value : 500,
	timer1 : null,
	flagTimer1 : false,
	func : null,
	initTimer : function(val,f) {
		this.value = val;
		this.t = 0;
		this.func = f;
		if (this.flagTimer1==false) {
			this.timer1 = setTimeout("Timer.timer()", this.interval);
			this.flagTimer1 = true;
		}
	},
	timer : function() {
		this.t += this.interval;
		if ((this.value - this.t) == 0) {
			clearTimeout(this.timer1);
			this.flagTimer1 = false;
			this.t = 0;				
			setTimeout(this.func, 0);
		}
		else {
			setTimeout("Timer.timer()",this.interval);
		}
	}
};
String.prototype.replaceAt=function(index, len, str) {
  return this.substr(0, index) + str + this.substr(index+len);
}
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
function stringify (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
        // simple data type
        if (t == "string") obj = '"'+obj+'"';
        return String(obj);
    }
    else {
        // recurse array or object
        var n, v, json = [], arr = (obj && obj.constructor == Array);
        for (n in obj) {
            v = obj[n]; t = typeof(v);
            if (t == "string") v = '"'+v+'"';
            else if (t == "object" && v !== null) v = stringify(v);
            json.push((arr ? "" : '"' + n + '":') + String(v));
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
}
function showDialog() {
	$("#dialog1").html(replaceText(templates.loading,{baseUrl:baseUrl}));
	$("#dialog1").dialog({ 
		modal: true,
        resizable: false,
		open : function(){
		},
		close : function() {
		}
	});
}
function showDialogUrl(url,title_,width_,dialog) {
	if(dialog == null) dialog = $("#dialog");
	if(width_ == null)
		width_= 300;
	if(title_ == null)
		title_ = 'Welcome to Top7';
	dialog.html('');
	dialog.html(replaceText(templates.loading,{baseUrl:baseUrl}));
	dialog.load(url);
	dialog.dialog({ 
		modal: true,
        resizable: false,
		title : title_,
		width: width_,
		open : function(){
			//$("body").css("overflow", "hidden");
			
		},
		close : function() {
			//$("body").css("overflow", "auto");
		}
	});
}
jQuery.fn.dataTableExt.oApi.fnSetFilteringPressEnter = function (oSettings) {
    var _that = this;
    this.each(function (i) {
        $.fn.dataTableExt.iApiIndex = i;
        var $this = this;
        var anControl = $('input', _that.fnSettings().aanFeatures.f);
        anControl.unbind('keyup').bind('keypress', function (e) {
            if (e.which == 13) {
                $.fn.dataTableExt.iApiIndex = i;
                _that.fnFilter(anControl.val());
            }
        });
        return this;
    });
    return this;
}
function processErrorMessage(message) {
	if(message == 'END_SESSION') {
		location.href = LOGIN_PATH;
	} else if (message == 'ERROR') {
		alert("Có lỗi xảy ra, vui lòng thử lại!");
	} else {
		alert(message);
	}
}