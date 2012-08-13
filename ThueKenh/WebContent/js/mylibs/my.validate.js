var response;
$.validator.addMethod(
	"regex",
	function(value, element, regexp) {
		var re = new RegExp(regexp);
		return this.optional(element) || re.test(value);
	},
	"Please check your input."
);
$.validator.addMethod("uniqueUserName", function(value, element) {
	$.ajax({
		type: "GET",
		url: baseUrl + '/ajax/uniqueUsername.action?username='+value,
		async: false, 
		success: function(msg)
		{
			//If username exists, set response to true
			if(msg == 'ERROR') {
				alert("ERROR");
				response = true;
			} else {
				response = ( msg == 'OK' ) ? true : false;
			}
		}
	})
	return response;
}, "Username is Already Taken");
