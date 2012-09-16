var upload_utils = {
	button_id : "#btUploadFile",
	init : function(params){
		if(params != null) {
			if(params.button_id!= null)
				this.button_id = params.button_id;
		}
		$("body").append('<form id="frmUpload" method="post" enctype="multipart/form-data"><input type="file" class="hidden_upload" name="uploadFile" id="uploadFile"/></form>');
		$("#btUploadFile").live("click",function(){
			$("#frmUpload #uploadFile").trigger("click");
		});
		$('#frmUpload').ajaxForm({ 
			url:  baseUrl + "/fileupload/doUpload.action",
			type: "post",
			dataType : "json",
			success:    function(response) { 
				if(response.type == "ERROR") {
					alert(response.data);
					return;
				}
				if(response.type == "OK") {
					upload_utils.createFileLabel(response.data);
					return;
				}
				alert("Kết nối bị lỗi, vui lòng thử lại!");
			},
			error : function(data) {
				alert("Kết nối bị lỗi, vui lòng thử lại!");
			}
		});
		$("#frmUpload #uploadFile").change(function(){
			$('#frmUpload').submit();
		});
		$("#label").delegate(".selected a.remove","click",function(){
			$("#filename").val("");
			$("#filepath").val("");
			$("#filesize").val("");
			$(this).parents(".selected").remove();
			$(upload_utils.button_id).show();
		});
	},
	createFileLabel : function(data) {
		$("#label").html(replaceText(templates.file_upload,{
			filename : data.filename,
			filename_cuted : data.filename.vmsSubstr(25)
		}));
		$("#filename").val(data.filename);
		$("#filepath").val(data.filepath);
		$("#filesize").val(data.filesize);
		$(this.button_id).hide();
	}
}
