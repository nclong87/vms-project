var permission_popup = {	url_init : '',	afterSelected : '',	dialog : null,	getMenusByRootURL : '',	init : function(params) {		if(permission_popup.url_init != '') {			$.get(permission_popup.url_init,function(response) {				var select2 = $("#select2");				$.each(response.data,function(){					select2.append('<option value="'+this.id+'">'+this.namemenu+'</option>');				});			});		};		permission_popup.getMenusByRootURL = params.getMenusByRootURL;		permission_popup.dialog = $("#permission_popup").parents(".ui-dialog-content");		permission_popup.dialog.dialog("option", "position", "center");		MultiSelect("btadd","btremove","btaddall","btremoveall","select1","select2");		$( "#buttons button:first",permission_popup.dialog).button({			icons: {				primary: "ui-icon-seek-end"			},			text: false		}).next().button({			icons: {				primary: "ui-icon-seek-first"			},			text: false		}).next().button({			icons: {				primary: "ui-icon-seek-next"			},			text: false		}).next().button({			icons: {				primary: "ui-icon-seek-prev"			},			text: false		});		$("#idrootmenu",permission_popup.dialog).change(function(){			if(this.value == '') return;			$.get(permission_popup.getMenusByRootURL,{idrootmenu : this.value},function(data){				if(data.status == 0 ) { //error					processErrorMessage(data.data);					return;				} else if(data.status == 1 ){ //ok					var select1 = $("#select1",permission_popup.dialog);					select1.empty();					$.each(data.data,function(){						if($("#select2 option[value="+this.id+"]").length == 0)							select1.append('<option value="'+this.id+'">'+this.namemenu+'</option>');						else							select1.append('<option disabled=true value="'+this.id+'">'+this.namemenu+'</option>');					});				}			});		});		$("#btChon",permission_popup.dialog).click(function(){			if(permission_popup.afterSelected != '') {				this.disabled = true;				var data = [];				$("#select2 option").each(function()				{					data.push({						id : $(this).val(),						name : $(this).text()					});				});				permission_popup.afterSelected(data);				//permission_popup.dialog.dialog("close");				return false;			}		});	}}