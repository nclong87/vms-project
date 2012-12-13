<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="description" content="Reflect Template" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
        <title>QUẢN LÝ KÊNH TRUYỀN DẪN - VMS MOBIFONE</title>
        <link rel="stylesheet" href="<%= contextPath %>/css/login.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%= contextPath %>/css/style1.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%= contextPath %>/css/jquery-ui.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="<%= contextPath %>/css/jquery.wysiwyg.css" type="text/css" media="screen" />
        <!--Internet Explorer Trancparency fix-->
        <!--[if IE 6]>
        <script src="<%= contextPath %>/js/ie6pngfix.js"></script>
        <script>
          DD_belatedPNG.fix('#head, a, a span, img, .message p, .click_to_close, .ie6fix');
        </script>
        <![endif]--> 
        
        <script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
        <script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
        <script type='text/javascript' src='<%= contextPath %>/js/jquery.wysiwyg.js'></script>
    </head>
    
    <body class="nobackground">
        <div id="login">
        	<h1 class="logo">
            	<a href="#"></a>
            </h1>
            <h2 class="loginheading">Login</h2>
            <div class="icon_login ie6fix"></div>
        	<form id="login_form" action="${loginURL}" method="post">
			<s:if test='message!=null'>
				<div class='negative'><span style='padding-left:30px;'><strong><s:property value="message" /></strong></span></div> 
			</s:if>
            <p>
            	<label for="name">Username</label>
            	<input class="input-medium" type="text" value="" name="username" id="username"/>
        	</p>
        	<p>
            	<label for="password">Password</label>
            	<input class="input-medium" type="password" value="" name="password" id="password"/>
        	</p>
        	<p class="clearboth" style="text-align:center">
				<input type="submit" id="btSubmit" value="Login"/>
        	</p>
            </form>
        </div>
        
        <div class="login_message message error" style="display:none">
          <p>Wrong Username or password.</p>
        </div>
    </body>
</html>
<script>
$(document).ready(function(){	
	var jsonData = '<s:property value="jsonData" escape="false"/>';
	if(jsonData != '') {
		var jsonData = $.parseJSON(jsonData);
		for( key in jsonData) {
			$("#login_form #"+key).val(jsonData[key]);
		}
	}
	$("input[type=button]").button();
	$("#username").focus();
});
</script>