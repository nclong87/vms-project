﻿<div id="top">	<div id="dialog" title="Welcome to VMS"><center>Loading...</center></div>	<div id="dialog1" title="Welcome to VMS"></div>	<div id="head">		<h1 class="logo">			<a href="<%= request.getContextPath() %>"></a>		</h1>		<div class="head_memberinfo">			<span class='memberinfo_span'>				 Welcome <strong><s:property value="#session.SESS_USERLOGIN.username"/></strong>			</span>						<span class='memberinfo_span'>				<a href="#" onclick="loadContent('/settings/index.action')">Your account</a>			</span>			<span>				<a href="${doLogoutURL}">Logout</a>			</span>		</div><!--end head_memberinfo-->	</div><!--end head-->	<s:property value="#session.SESS_MENU" escape="false"/></div>