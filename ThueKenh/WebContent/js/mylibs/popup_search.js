function PopupSearch() {	this.afterSelected = null;}PopupSearch.prototype.init = function (params) {	$(params.button).live("click",function(){		var popup = window.open(params.url,'','width=900,height=500,scrollbars=1');		popup.focus();	});	if(params.afterSelected != null)		this.afterSelected = params.afterSelected;};/* var popup_search = {	afterSelected : null,	init : function(params) {		$(params.button).live("click",function(){			var popup = window.open(params.url,'','width=900,height=500,scrollbars=1');			popup.focus();		});		if(params.afterSelected != null)			this.afterSelected = params.afterSelected;	}} */