<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Others.aspx.cs" Inherits="Others" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/metro-bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="Dtop/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/css/nav.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/css/tiles.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/themes/theme_default/theme.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/accordion/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/lightbox/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/panels/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/plugintemplate/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tileflip/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tilefliptext/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tileslide/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tileslidefx/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tileslideshow/plugin.css" />
    <link rel="stylesheet" type="text/css" href="Dtop/plugins/tiletemplate/plugin.css" />
    <link href="Styles/sweet-alert.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        html
        {
            background-color: #180052;
        }
        #bgImage
        {
            position: fixed;
            top: 0;
            left: 0;
            z-index: -4;
            min-width: 115%;
            min-height: 100%;
            -webkit-transition: margin-left 450ms linear;
            -moz-transition: margin-left 450ms linear;
            -o-transition: margin-left 450ms;
            -ms-transition: margin-left 450ms;
            transition: margin-left 450ms;
        }
        .tile
        {
            -webkit-transition-property: box-shadow, margin-left, margin-top;
            -webkit-transition-duration: 0.25s, 0.5s, 0.5s;
            -moztransition-property: box-shadow, margin-left, margin-top;
            -moz-transition-duration: 0.25s, 0.5s, 0.5s;
            -o-transition-property: box-shadow, margin-left, margin-top;
            -o-transition-duration: 0.25s, 0.5s, 0.5s;
            -ms-transition-property: box-shadow, margin-left, margin-top;
            -ms-transition-duration: 0.25s, 0.5s, 0.5s;
            transition-property: box-shadow, margin-left, margin-top;
            transition-duration: 0.25s, 0.5s, 0.5s;
        }
    </style>
    <link href="Styles/ns-window.css" rel="stylesheet" type="text/css" />
    <script src="Js/sweet-alert.min.js" type="text/javascript"></script>
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Js/OpenDialog.js" type="text/javascript"></script>
    <script src="Js/ns-window.js" type="text/javascript"></script>
    <!-- ======== Code For Accordion Start here ========== -->
    <link href="Dtop/plugins/accordion/Accordion.css" rel="stylesheet" type="text/css" />
    <script src="Dtop/plugins/accordion/jquery.dimensions.js" type="text/javascript"></script>
    <script src="Dtop/plugins/accordion/jquery.accordion.js" type="text/javascript"></script>
    <script type="text/javascript">
        function SetDelay() {
            setTimeout("make()", 100);
        }
        function make() {
            jQuery('#list1a').accordion();
            setTimeout("make()", 200);
        }        
    </script>
    <!-- ======== Code For Accordion End here ========== -->
    <script type="text/javascript" src="Dtop/js/html5.js"></script>
    <script type="text/javascript">        window.jQuery || document.write('<\/script><script type="text/javascript" src="js/jquery1102.js"><\/script>')</script>
    <script type="text/javascript" src="Dtop/js/plugins.js"></script>
    <script type="text/javascript">
        scale = 145;
        spacing = 10;
        stitle = "Log Out";
        theme = 'theme_default';
        $group.titles = stitle.split('|'); //["File", "Planbook", "Reports/Views", "Admin"]; // ["File", "Planbook", "Reports/Views", "Admin", "Payroll", "CapEX"];
        $group.spacingFull = [4, 4];
        $group.inactive.opacity = "1";
        $group.inactive.clickable = "1";
        $group.showEffect = 0;
        $group.direction = "horizontal";

        mouseScroll = "groups";

        siteTitle = 'Litigation';
        siteTitleHome = 'Home';
        showSpeed = 400;
        hideSpeed = 300;
        scrollSpeed = 550;

        device = "desktop";
        scrollHeader = "1";
        disableGroupScrollingWhenVerticalScroll = "";

        /*For background image*/
        bgMaxScroll = "130";
        bgScrollSpeed = "450";

        /*For responsive */
        autoRearrangeTiles = "1";
        autoResizeTiles = "1";
        rearrangeTreshhold = 2;

        /*Locale */
        lang = "en";
        l_pageNotFound = "404 - Page not Found";
        l_pageNotFoundDesc = "<h2 class='margin-t-0'>404 - Page not Found</h2>We're sorry, the page you're looking for is not found.";
        l_menu = "Menu";
        l_goToFullSiteRedirect = "You'll be redirected to the full site";
        panelDim = '0'; hidePanelOnClick = '1'; panelGroupScrolling = '';
        function LogOut() {
            $(window).attr("location", "LogIn.aspx");
        }
        function GotoHome() {
            $(window).attr("location", "MainPage.aspx");
        }
    </script>
    <script type="text/javascript" src="Dtop/plugins/accordion/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/lightbox/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/panels/desktop.js"></script>
    <script type="text/javascript" src="Dtop/plugins/plugintemplate/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tileflip/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tilefliptext/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tileslide/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tileslidefx/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tileslideshow/plugin.js"></script>
    <script type="text/javascript" src="Dtop/plugins/tiletemplate/plugin.js"></script>
    <script type="text/javascript" src="Dtop/js/functions.js"></script>
    <script type="text/javascript" src="Dtop/js/main.js"></script>
    <style type="text/css">
        .bodyImg
        {
            background-image: url("Dtop/img/bg/bg.png");
            background-repeat: repeat;
        }
        #catchScroll
        {
            background: rgb(30,30,30);
            -ms-filter: 'progid:DXImageTransform.Microsoft.Alpha(Opacity=00)';
            filter: alpha(opacity=00);
            -moz-opacity: 0;
            -khtml-opacity: 0;
            opacity: 0;
        }
        .image
        {
            position: relative;
        }
        .image .text
        {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 300px;
        }
        #tileContainer
        {
            display: block;
        }
    </style>
</head>
<body class="full desktop">
    <form id="form1" runat="server">
    <div style="display: none;">
        <input type="button" id="btnDialogClose" onclick="javascript:return CloseMe(this);"
            style="visibility: hidden;" />
        <input type="button" id="btnDialogOpen" onclick="javascript:return OpenDialog(this);"
            style="visibility: hidden;" />
        <input type="button" id="btnLevelClose" onclick="javascript:return CloseMe(this);"
            style="visibility: hidden;" />
        <input type="button" id="btnAlert" onclick="javascript:return Salert(this);" style="visibility: hidden;" />
        <asp:HiddenField ID="hdnPageType" runat="server" Value="" />
    </div>
    <div style="width: 2000px">
        <header>
	        <div id="headerWrapper">
		        <div id="headerCenter">
			        <div id="headerTitles" onclick="javascript:location.reload();" style="height: 80px">
                        <img src="Styles/images/company-logo.png"  alt="Litigation Login"/>
                         <a id="A1" runat="server" style="width:130px" class="PPLegend">
	                        User
                         </a> 
		   		        <h2><i><b></b></i></h2>                         
		            </div>
		            <nav>
                         
                        <a id="group0" style="width:130px" onclick="javascript:GotoHome();">
	                        <img src="Dtop/img/Content/law2.png" alt="Reports/Views"/>
	                      LIT Home
                         </a>    
                                                                    
                          <a id="group1" onclick="LogOut()">
	                        <img src="Dtop/img/Content/Logout.png" alt="Admin"/>
	                        Log Out
                         </a>
                        
                    </nav>
		        </div>
            </div>
       </header>
        <div id="wrapper">
            <div id="centerWrapper">
                <div id="tileContainer">
                    <img id='arrowLeft' class="navArrows" src='Dtop/themes/theme_default/img/primary/arrowLeft.png'
                        onclick="javascript:$group.goLeft();" alt="left arrow" />
                    <img id='arrowRight' class="navArrows" src='Dtop/themes/theme_default/img/primary/arrowRight.png'
                        onclick="javascript:$group.goRight();" alt="right arrow" />
                    <a href="#&amp;group-1" id="groupTitle2" class="groupTitle" style="margin-left: 0px;
                        margin-top: 0px" onclick="javascript:$group.goTo(0);">
                        <h3>
                            LIT Home</h3>
                    </a>
                    <!--- Add Litigation tab Sart -->
                    <a class="tile tileGreen group2 " id="A4" onclick="OpenUrl(this);" href="javascript:void(0);"
                        style="margin-top: 45px; margin-left: 0px; width: 300px; height: 145px;" data-pos='45-0-300'>
                        <div class='tileTitleTop' style='margin-left: 10px; z-index: 11;'>
                            User</div>
                        <div class="BigIcon" style="margin-top: 0px;">
                            <img title='' alt='' src="Dtop/img/Content/NewPos.png" height="80" width="80" />
                        </div>
                    </a><a class="tile tileOrange group2 " id="A8" onclick="OpenUrl(this);" href="javascript:void(0);"
                        style="margin-top: 45px; margin-left: 310px; width: 300px; height: 145px;" data-pos='45-310-300'>
                        <div class='tileTitleTop' style='margin-left: 10px; z-index: 11;'>
                            Authorized Person</div>
                        <div class="BigIcon" style="margin-top: 0px;">
                            <img title='' alt='' src="Dtop/img/Content/Audit.png" height="80" width="80" />
                        </div>
                    </a><a class="tile tilePurple group2 " id="a3" onclick="OpenUrl(this);" href="javascript:void(0);"
                        style="margin-top: 200px; margin-left: 0px; width: 300px; height: 145px;" data-pos='45-0-300'>
                        <div class="BigIcon" style="margin-top: 25px;">
                            <img title='' alt='' src="Dtop/img/Content/NewEmp.png" height="80" width="80" />
                        </div>
                        <div class='tileTitleBottom' style='margin-left: 10px; z-index: 11;'>
                            Client
                        </div>
                    </a><a class="tile tileCrim group2 " id="A5" onclick="OpenUrl(this);" href="javascript:void(0);"
                        style="margin-top: 200px; margin-left: 310px; width: 300px; height: 145px;" data-pos='200-310-300'>
                        <div class='tileTitleTop' style='margin-left: 10px; z-index: 11;'>
                            Stages</div>
                        <div class="BigIcon" style="margin-top: 0px;">
                            <img title='' alt='' src="Dtop/img/Content/Process.png" height="80" width="80" />
                        </div>
                    </a>
                    <asp:HiddenField ID="hdnAdminLevel" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnPreff" runat="server" Value="false" />
                    <!--- Edit View tab End -->
                </div>
                <div id="subNavWrapper">
                </div>
                <div id="contentWrapper">
                    <div id="content">
                    </div>
                </div>
            </div>
            <footer>
    <div>
		This site is owned and operated by ISS Legal Team and developed only for the purpose of internal use. Any reproduction or reference of the documents or contents shall be only withthe authorized consent from Legal Team of ISS India 
    </div>
    </footer>
        </div>
        <div id="catchScroll" class="bodyImg">
        </div>
        <div id='panel' style='width: 285px; max-width: 600px; right: -400px;'>
            <img id='panelArrow' src='Dtop/themes/theme_default/img/panels/arrow.png' onclick='javascript:hidePanel();'
                alt='hide panel' />
            <img id='panelLoader' src='Dtop/themes/theme_default/img/panels/loader.gif' alt='Loading...' />
            <div id='panelContent' style="height: 50px;">
            </div>
        </div>
    </div>
    </form>
</body>
</html>
