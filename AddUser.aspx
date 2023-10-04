<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="AddUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Js/load-metro.js" type="text/javascript"></script>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
   
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div class="example" >
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Add User</legend>
            <div style="width: 80%; padding-left: 2%">
                <div style="float: left; padding-right: 3%; width: 150px">
                    <label>
                        Full Name:
                    </label>
                </div>
                <div style="float: left">
                    <input id="txtUserName" type="text" style="width: 300px" />
                </div>
            </div>            
            <div style="width: 100%; padding-left: 2%; padding-top: 5%">
                <div style="float: left; padding-right: 3%; width: 150px">
                    <label>
                        Password:
                    </label>
                </div>
                <div style="float: left">
                    <input id="txtPassword" type="password" style="width: 300px" />
                </div>
            </div>
            <div class="inline-block" style="width: 100%; padding-left: 2%;">
                <div class="inline-block">
                    <label>
                        Email:
                    </label>
                    <input id="txtEmail" type="text" /></div>
                <div style="padding-left: 2%;" class="inline-block">
                    <label>
                        User Access Rights:
                    </label>
                    <select id="ddlLevel">
                    <option class="info" value="200">Master</option>
                        <option class="info" value="100">Admin</option>
                        <option value="0">Non-Admin</option>
                         <option value="300">Home</option>
                    </select>
                </div>
            </div>
            <div style="width: 100%; padding-left: 2%; margin-top: 2%">
                <div style="padding-left: 5%; float: right">
                    <input id="btnCancel" class="button success" type="button" value="Cancel" onclick="Closethis()" />
                </div>
                <div style="float: right">
                    <input id="btnOk" type="button" class="button success" value="OK" onclick="SaveUser()" /></div>
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            setAdminLevel();
            $("input[type=text]").keypress(function () {
                if (event.keyCode == 39) {
                    event.keyCode = 0;
                    return false;
                }
            });
        });
        function SaveUser() {
            if (validate()) {
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/CheckUserExist",
                    data: "{sUserName :'" + $("#txtUserName")[0].value + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        // Replace the div's content with the page method's return.
                        if (msg.d == true) {
                            alert('User Name already exits');
                        }
                        else {
                            save();
                        }
                    }
                });
            }
        }
        function setAdminLevel() {
            var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wAdmin == '0') {
//                alert('Only Admin-access user can save and edit data!');
                $("#btnOk")[0].disabled = "disabled";
            }
        }
        function validate() {
            if ($("#txtUserName").val() == "") {
                alert('Please enter User Name!');
                return false;
            }
            if ($("#txtPassword").val() == "") {
                alert('Please enter Password!');
                return false;
            }
            if ($("#txtEmail").val() == "") {

                alert('Please enter Email ID!');
                return false;
            }
            else if (!ValidateEmail($("#txtEmail").val())) {
                alert('Invalid Email Address');
                return false;
            }
            return true;
        }

        function ValidateEmail(inputText) {
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (inputText.match(mailformat)) {
                return true;
            }
            else {
                alert("You have entered an invalid email address!");
                return false;
            }
        }

        function save() {
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/SaveUser",
                data: "{sUserName :'" + $("#txtUserName")[0].value + "',sPassword :'" + $("#txtPassword")[0].value + "',sAccessRight :'" + $("#ddlLevel option:selected").text() + "',wAdmin :'" + $("#ddlLevel").val() + "',sEmail:'" + $("#txtEmail")[0].value + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    // Replace the div's content with the page method's return.
                    alert('saved succesfully!');
                    Closethis();
                }
            });
        }
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#UserView').find('#iHold').contents().find('#btnUpdate');
            btnUpdate.click();
            btnClose.click();
        }
    </script>
</body>
</html>
