var/const/Main={"<center><div id="wrapper"><div id="main_container"></center>"}

var/const/console_css={"<style>
@charset "UTF-8";

/* CSS Document */
@charset "utf-8";
<!--

.levels {
	color: #9e9e9e;
	font-weight: bold;
}
-->

/* Main Body Elements */
a:link {
	color: #9e9e9e;
}
a:visited {
	color: #9e9e9e;
}
a:hover {
	color: #9e9e9e;
}
a:active {
	color: #9e9e9e;
}
body,td,th
{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #ffffff;
	/* IE10+ */
background-image: -ms-radial-gradient(center, ellipse farthest-corner, #2C3F5E 0%, #2C3F5E 100%);

/* Mozilla Firefox */
background-image: -moz-radial-gradient(center, ellipse farthest-corner, #2C3F5E 0%, #2C3F5E 100%);

/* Opera */
background-image: -o-radial-gradient(center, ellipse farthest-corner, #2C3F5E 0%, #2C3F5E 100%);

/* Webkit (Safari/Chrome 10) */
background-image: -webkit-gradient(radial, center center, 0, center center, 286, color-stop(0, #2C3F5E), color-stop(100, #2C3F5E));

/* Webkit (Chrome 11+) */
background-image: -webkit-radial-gradient(center, ellipse farthest-corner, #4375c8 0%, #2C3F5E 100%);

/* W3C Markup */
background-image: radial-gradient(ellipse farthest-corner at center, #4375c8 0%, #2C3F5E 100%);
	background-color: #2C3F5E;
}
body
{
	margin: 0;
	font-size: 12px;
	color: #ffffff;
}

p
{
	margin: 0;
	margin-bottom: 12px;
	color: #9e9e9e;
}

#top
{
	width: 200px;
	margin: 0;
	height: 110px;
	text-decoration: none;
	text-align: center;
	padding: 7px 5px 5px 5px;
	background: #2C3F5E;
	color: #9e9e9e;

}

#wrapper
{
	width: 200px;
	background: #2C3F5E;
	padding-top: 4px;
	padding-bottom: 15px;
	color: #9e9e9e;
}


#footer
{
	width: 200px;
	margin: 0;
	clear: both;
	height: 40px;
	color: #9e9e9e;
	text-align: center;
	padding-top: 20px;
	background: #2C3F5E;
	color: #9e9e9e;
}

#footer a
{
	color: #FFF;
}

#main_container
{
	width: 200px;
	margin-right:auto;
	text-align: left;
	margin-left:auto;
	color: #9e9e9e;
}

#head_container
{
	width: 200px;
	clear: both;
	margin-right:auto;
	text-align: center;
	margin-left:auto;
	height: 110px;
	color: #9e9e9e;
}

#head_container ul
{
	margin-top: 42px;
	float: right;
	vertical-align:bottom;
	list-style: none;
	color: #9e9e9e;
}

#head_container li
{
	margin-left: 5px;
	float: left;
	color: #9e9e9e;

}

#head_container li a
{
	background: #2C3F5E;
	height: 17px;


	margin-top: 2px;
	color: #9e9e9e;
	margin-left: 5px;
	display: block;
	text-decoration: none;
	float: left;
	padding: 8px;

}
#head_container li a:hover
{

	color: #9e9e9e;
	margin-top: 0px;

	background: #2C3F5E;
}

#menu_container
{
	float: right;
	width: 200px;
	color: #9e9e9e;
}

#content_container
{
	width: 400px;
	padding-right: 5px;
	padding: 5px
	background: #2C3F5E;
	color: #9e9e9e;
}

#clear
{
	clear: right;
}
.content
{
	width: 300px;
	text-align: center;
	padding: 5px;
	margin: 0px;
	color: #9e9e9e;
	margin-bottom: 5px;
	background: #2C3F5E;

}
.content ul
{
	margin-top: auto;
	float: auto;
	color: #9e9e9e;
}
.content li
{
	display: block;
	margin: 0;
	margin-top: 1px;
	height: auto;
	color: #9e9e9e;
}
.content li a
{

	width: auto;
	list-style: none;
	margin: 0;
}
.content span
{
	color: #9e9e9e;
}

h1
{
	width: auto;
	background: #2C3F5E;
	height: 15px;
	margin: 0px;
	padding: 3px;
	padding-bottom: 4px;
	color: #9e9e9e;
	font-size: 12px;
}

#logo
{
	background: #2C3F5E;
	margin-top: 15px;
	display: block;
	padding-left: 70px;
	padding-top: 10px;
	height: 52px;
	color: #9e9e9e;
	font-family: Arial, Helvetica, Sans-Serif;
	text-decoration: none;
	font-size: 36px;
}
#logo a
{
	text-decoration: none;
}

table#table-list
{
	margin: 0;
	padding: 0;
	border-collapse: collapse;
}

table#table-list caption, table#table-list thead
{
	display: none;
}

table#table-list tr
{
	background-color: inherit;
	color: #9e9e9e;
}

table#table-list tr td
{
	padding: 0;

}

table#table-list tr.listing-alt td
{
	color: inherit;
	background-color: #2C3F5E;
}

table#table-list tr td.listing-thumb
{
	text-align: center;
	padding: 10px 6px 8px 6px;
}

table#table-list tr td h3
{
	margin: 0;
	padding: 0;
	font-size: 1.2em;
}

table#table-list tr td h3 a
{
	text-decoration: none;
}

table#table-list tr td p
{
	font-size: 1.1em;
	margin: 2px 0 0 0;
	padding: 0;
}

table#table-list tr td.listing-small
{
	vertical-align: bottom;
	text-align: right;
	width: 150px;
	padding: 0 2px 0 6px;
}

table#table-list tr td.listing-small span
{
	font-weight: bold;
}

</style>
"}