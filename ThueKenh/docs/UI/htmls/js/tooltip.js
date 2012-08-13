
var offsetfromcursorX = 12;
var offsetfromcursorY = 10;
var offsetdivfrompointerX = 10;
var offsetdivfrompointerY = 14;



var ie = document.all;
var ns6 = document.getElementById && ! document.all;
var enabletip = false;

if (ie || ns6)
	var tipobj = document.all ? document.all["dhtmltooltip"] : document.getElementById ? document.getElementById("dhtmltooltip") : "";

var pointerobj = document.all ? document.all["dhtmlpointer"] : document.getElementById ? document.getElementById("dhtmlpointer") : "";
var pointerobj2 = document.all ? document.all["dhtmlpointer"] : document.getElementById ? document.getElementById("dhtmlpointer2") : "";

function ietruebody() {
	return (document.compatMode && document.compatMode != "BackCompat") ? document.documentElement : document.body;
}
var xTip;
var yTip;
function showtip(thetext, thewidth, thecolor) {
	if (ns6 || ie) {
		if (typeof thewidth != "undefined")
			tipobj.style.width = thewidth + "px";
		if (typeof thecolor != "undefined" && thecolor != "")
			tipobj.style.backgroundColor = thecolor;
		tipobj.innerHTML = thetext;		
		enabletip = true;
		positiontip();
		return false;
	}
}

function positiontip(e) {
	if (enabletip) {		
		var nondefaultpos = false;
		//var curX = (ns6) ? e.pageX : event.clientX + ietruebody().scrollLeft;
		//var curY = (ns6) ? e.pageY : event.clientY + ietruebody().scrollTop;
		var curX = xTip;
		var curY = yTip;
		
		var winwidth = ie && ! window.opera ? ietruebody().clientWidth : window.innerWidth - 20;
		var winheight = ie && ! window.opera ? ietruebody().clientHeight : window.innerHeight - 20;

		var rightedge = ie && ! window.opera ? winwidth - event.clientX - offsetfromcursorX : winwidth - xTip - offsetfromcursorX;
		var bottomedge = ie && ! window.opera ? winheight - event.clientY - offsetfromcursorY : winheight - yTip - offsetfromcursorY;

		var leftedge = (offsetfromcursorX < 0) ? offsetfromcursorX * (- 1) : - 1000;
		if (rightedge < tipobj.offsetWidth) {
			tipobj.style.left = curX - tipobj.offsetWidth + "px";
			nondefaultpos = true;
		}
		else if (curX < leftedge)
			tipobj.style.left = "5px";
		else {
			tipobj.style.left = curX + offsetfromcursorX - offsetdivfrompointerX + "px";
			pointerobj.style.left = curX + offsetfromcursorX + "px";
			pointerobj2.style.left = curX + offsetfromcursorX + "px";
		}

		if (bottomedge < tipobj.offsetHeight) {
			tipobj.style.top = curY - tipobj.offsetHeight - offsetfromcursorY + "px";
			nondefaultpos = true;
			pointerobj2.style.top = curY + offsetfromcursorY - 21 + "px";
		}
		else {
			tipobj.style.top = curY + offsetfromcursorY + offsetdivfrompointerY + "px";
			pointerobj.style.top = curY + offsetfromcursorY + "px";
		}

		tipobj.style.visibility = "visible";
		pointerobj.style.visibility = "hidden";
		pointerobj2.style.visibility = "hidden";
		if (!nondefaultpos) 
			pointerobj.style.visibility = "visible";
		else
			pointerobj2.style.visibility = "visible";
		
	}
}

function hidetip() {
	if (ns6 || ie) {
		enabletip = false;
		tipobj.style.visibility = "hidden";
		pointerobj.style.visibility = "hidden";
		pointerobj2.style.visibility = "hidden";
		tipobj.style.left = "-1000px";
		tipobj.style.backgroundColor = '';
		tipobj.style.width = '';
	}
}

//document.onmousemove = positiontip;