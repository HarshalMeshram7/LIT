<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/LogIn.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <!-- TOP BAR -->
        <div id="top-bar">
            <div class="page-full-width">
                <%--<a href="#" class="round button dark ic-left-arrow image-left ">Return to website</a>--%>
            </div>
            <!-- end full-width -->
        </div>
        <!-- end top-bar -->
        <!-- HEADER -->
        <div id="header">
            <div class="page-full-width cf">
                <div id="login-intro" class="fl">
                    <h1>
                        Login to LITIGATION</h1>
                    <h5>
                        Enter your credentials below</h5>
                </div>
                <!-- login-intro -->
                <!-- Change this image to your own company's logo -->
                <!-- The logo will automatically be resized to 39px height. -->
                <a href="#" id="company-branding" class="fr">
                    <img src="Styles/images/company-logo.png" alt="Blue Hosting" /></a>
            </div>
            <!-- end full-width -->
        </div>
        <!-- end header -->
        <div id="content">
            <fieldset style="width: 30%; padding-left: 35%">
                <p>
                    <label for="login-username">
                        username</label>
                    <input type="text" id="login-username" class="round full-width-input" onkeypress="return EnterEvent(event);" autofocus />
                </p>
                <p>
                    <label for="login-password">
                        password</label>
                    <input type="password" id="login-password" class="round full-width-input" onkeypress="return EnterEvent(event);" />
                </p>
                <p><a href="#" onclick="ForgetPass()">Forget password</a>.</p>
                <%-- <a href="dashboard.html" class="button round blue image-right ic-right-arrow">LOG IN</a>--%>
                <%-- <asp:Button ID="btnLogIn" runat="server"  class="button round blue image-right ic-right-arrow" Text="LOG IN" />--%>
                <input type="button" id="btnLogIn" onclick="CheckUserLogin()" class="button round blue image-right ic-right-arrow"
                    value="LOG IN" />
                <div class="information-box round" style="margin-top: 2%">
                    Just click on the "LOG IN" button to continue, no login information required.</div>
            </fieldset>
        </div>
        <br />
        <!-- end content -->
        <!-- FOOTER -->
        <div id="footer">
            <p>
                &copy; Copyright 2014 <a href="#">LitigationMaster, LLC</a>. All rights reserved.</p>
            <p>
        </div>
        <!-- end footer -->
    </div>
    </form>
    <script type="text/javascript">
        function CheckUserLogin() {
              if (validate()) {
                  $.ajax({
                      type: "POST",
                      url: "LogIn.aspx/CheckUserLogin",
                      data: "{sUserName :'" + $("#login-username").val() + "',sPassWord :'" + $("#login-password").val() + "'}",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (msg) {
                          // Replace the div's content with the page method's return.
                          //                          alert(msg.d);
                          if (msg.d == "Done") {
//                              $(window).attr("location", "DefaultMIS.aspx");
                              $(window).attr("location", "MainPage.aspx");
                          }
                          else {
                              alert(msg.d);
                          }
                      },
                      error: function (result) {
                          //                          $(window).attr("location", "DefaultMIS.aspx");                
                      }
                  });
              }
//              $(window).attr("location", "DefaultMIS.aspx");              

          }
          function validate() {
              if ($("#login-username").val() == "") {
                  alert('Please enter User Name!');
                  return false;
              }
              if ($("#login-password").val() == "") {
                  alert('Please enter Password!');
                  return false;
              }
              
              return true;
          }

          function ForgetPass() {
              $.ajax({
                  type: "POST",
                  url: "LogIn.aspx/SendPass",
                  data: "{sUserName :'" + $("#login-username").val() + "'}",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (msg) {
                      // Replace the div's content with the page method's return.
                      //                          alert(msg.d);
                      if (msg.d == null) {
                          //                          $(window).attr("location", "DefaultMIS.aspx");
                          alert('Check your mail for Authentication details.');
                      }
                      else {
                          //                          alert(msg.d);
                          alert('Check your mail for Authentication details.');

                      }
                  },
                  error: function (result) {
                      //                          $(window).attr("location", "DefaultMIS.aspx");                
                  }
              });
          }
          function EnterEvent(e) {
              if (e.keyCode == 13) {
                  CheckUserLogin();
              }
          }
    </script>
</body>
</html>
