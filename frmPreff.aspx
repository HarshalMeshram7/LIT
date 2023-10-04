<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmPreff.aspx.cs" Inherits="frmPreff" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Js/jquery.widget.min.js" type="text/javascript"></script>
    <script src="Js/metro.min.js" type="text/javascript"></script>
    <style type="text/css">
        input[type=text]
        {
            width: 200px !important;
        }
        input[type=password]
        {
            width: 200px !important;
        }
    </style>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm" style="width: 320px">
    <div style="width: 240px;">
        <fieldset class="PPFieldset">
            <div class="frames">
                <div class="frame" id="_page_1" style="display: block; height: 310px;">
                    <fieldset runat="server" id="fldUser" class="PPFieldset">
                        <legend runat="server" id="lgdUser" class="PPLegend">User :</legend>
                        <div style="width: 100%;">
                            <div style="width: 100%;" class="inline-block">
                                <label>
                                    Current Password
                                </label>
                                <input id="txtCurrent" type="password" disabled="disabled" />
                            </div>
                            <div style="" class="inline-block">
                                <label>
                                    New Password
                                </label>
                                <input id="txtNew" type="password" disabled="disabled" /></div>
                            <div class="inline-block">
                                <label>
                                    Confirm Password
                                </label>
                                <input id="txtConfirm" type="password" disabled="disabled" /></div>
                            <div class="inline-block ">
                                <label>
                                    Email Id:
                                </label>
                                <input id="txtEmail" type="text" />
                            </div>
                            <div class="inline-block ">
                                <label>
                                    User Access Rights:
                                </label>
                                <select id="ddlLevel">
                                    <option class="info" value="200">Master</option>
                                    <option class="info" value="100">Admin</option>
                                    <option value="0">Non-Admin</option>
                                </select>
                            </div>
                        </div>
                    </fieldset>
                    <div style="margin-top: 5%">
                        <input id="btnUsrUPdate" class="default button" type="button" value="Update" onclick="USrUpdate()" />
                        <input id="btnCancel" class="default button" type="button" value="Cancel" onclick="Closethis()" />
                    </div>
                </div>
                <div class="frame" id="_page_2" style="height: 310px;">
                    <div style="width: 100%;">
                        <div style="width: 100%;" class="inline-block">
                            <label>
                                Smtp
                            </label>
                            <input id="txtSmtp" type="text" />
                        </div>
                        <div class="inline-block">
                            <label>
                                User Email
                            </label>
                            <input id="txtUsrEmail" type="text" /></div>
                        <div class="inline-block">
                            <label>
                                Port
                            </label>
                            <input id="txtPort" type="text" /></div>
                        <div class="inline-block ">
                            <label>
                                Password:
                            </label>
                            <input id="txtPassword" type="password" /></div>
                    </div>
                    <div style="margin-top: 5%">
                        <input id="btnPreff" class="success button" type="button" value="Update" onclick="UpdatePreff()" />
                        <input id="Button3" class="success button" type="button" value="Cancel" onclick="Closethis()" />
                    </div>
                </div>
            </div>
            <asp:HiddenField runat="server" ID="hdnUser" Value="-1" />
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        var wCurrAdmin = -1;
        function setAdminLevel() {
            wCurrAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wCurrAdmin == '0') {
                //                salert('Only Admin-access user can save and edit data!', "info");
                $("#btnUsrUPdate")[0].disabled = "disabled";
                $("#btnPreff")[0].disabled = "disabled";
            }
        }
        $(document).ready(function () {
            setAdminLevel();
            $("input[type=text]").keypress(function () {
                if (event.keyCode == 39) {
                    event.keyCode = 0;
                    return false;
                }
            });
            $.ajax({
                type: "POST",
                url: "frmPreff.aspx/LoadData",
                //                data: "{Id :'" + MisId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        BindAll(msg.d);
                    }
                },
                error: function (result) {
                    alert('Error');
                }
            });
            if ($("#hdnUser").val() != "-1")
                $("#_page_2").css("display", "none");
            else
                $("#_page_1").css("display", "none");

        });
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#UserView').find('#iHold').contents().find('#btnUpdate');
            btnUpdate.click();
            btnClose.click();
        }
        var Curr;
        var isUpdate;
        function BindAll(grdData) {
            $("#txtEmail")[0].value = grdData[0].UserEmail;
            Curr = grdData[0].UserPassword;
            var wAdminLevel = grdData[0].AdminLevel;
            $("#ddlLevel").val(wAdminLevel);
            $("#txtSmtp")[0].value = grdData[0].smtp;
            $("#txtUsrEmail")[0].value = grdData[0].preffEmail;
            $("#txtPort")[0].value = grdData[0].port;
            $("#txtPassword")[0].value = grdData[0].password;

            if (wCurrAdmin != "200") {
                if (wAdminLevel == "200")
                    $("#btnUsrUPdate")[0].disabled = "disabled";
            }
            //Set All Priv
            if (grdData[0].isUpd == false) {
                isUpdate = "false";
            }
            else
                isUpdate = "true";
        }

        function USrUpdate() {
            if (validateURs()) {
                $.ajax({
                    type: "POST",
                    url: "frmPreff.aspx/UpdateUser",
                    data: "{sPassword :'" + $("#txtConfirm")[0].value + "',sEmail:'" + $("#txtEmail")[0].value + "',sLevel:'" + $("#ddlLevel").val() + "',sAdminLevel:'" + $("#ddlLevel option:selected").text() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        // Replace the div's content with the page method's return.
                        alert('Updated succesfully!');
                        Closethis();
                    }
                });
            }
        }
        function validateURs() {
            if ($("#txtCurrent").val() != Curr) {
                //                alert('Current password is invalid!');
                //                return false;
            }
            if ($("#txtNew").val() != $("#txtConfirm").val()) {
                //                alert('Please enter same password on both feild !');
                //                return false;
            }
            if ($("#txtEmail").val() == "") {
                //                alert('Please enter Email!');
                //                return false;
            }
            else if (!ValidateEmail($("#txtEmail").val())) {
                //                alert('Invalid Email Address');
                return false;
            }
            return true;
        }
        function UpdatePreff() {
            if (validate()) {

                $.ajax({
                    type: "POST",
                    url: "frmPreff.aspx/UpdatePreff",
                    data: "{sSmtp :'" + $("#txtSmtp")[0].value + "',sEmail :'"
                    + $("#txtUsrEmail")[0].value + "',sPort :'" + $("#txtPort").val() +
                    "',sPassword:'" + $("#txtPassword")[0].value + "',isUpdate:'" + isUpdate + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        // Replace the div's content with the page method's return.
                        //                        Curr = msg.d.UserPassword;
                        alert('Updated succesfully!');
                        Closethis();
                    }
                });
            }
        }
        function validate() {
            if ($("#txtSmtp").val() == "") {
                alert('Please enter Smtp!');
                return false;
            }
            if ($("#txtUsrEmail").val() == "") {
                alert('Please enter Email!');
                return false;
            }
            else if (!ValidateEmail($("#txtUsrEmail").val())) {
                //                alert('Invalid Email Address');
                return false;
            }
            if ($("#txtPort").val() == "") {
                alert('Please enter Port!');
                return false;
            }
            if ($("#txtPassword").val() == "") {
                alert('Please enter Password!');
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
        function salert(cTitle, cType) {
            var btnAlert = parent.parent.document.getElementById('btnAlert');
            btnAlert.title = cTitle;
            btnAlert.lang = cType;
            btnAlert.click();
        }
    </script>
</body>
</html>
