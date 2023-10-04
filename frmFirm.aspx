<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmFirm.aspx.cs" Inherits="frmFirm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmFirmm" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Firm Details </legend>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <%--<div class="inline-block">
                    <label>
                        Name:
                    </label>
                    <input id="txtFirstName" type="text" style="width: 310px" />
                </div>--%>
                <%--   <div class="inline-block">
                    <label>
                        Last Name:
                    </label>
                    <input id="txtLastNAme" type="text" />
                </div>--%>
                <div class="inline-block">
                    <label>
                        Firm Name:
                    </label>
                    <input id="txtForum" type="text" style="width: 310px" maxlength="100" />
                </div>
            </div>
            <div style="width: 100%" class="inline-block">
                <div style="float: left; padding-left: 2%; width: 70%">
                    <div style="width: 150px">
                        <label>
                            Address:
                        </label>
                    </div>
                    <div>
                        <input id="txtAddr" type="text" style="width: 100%" maxlength="200" />
                    </div>
                </div>
            </div>
            <div style="width: 100%" class="inline-block">
                <div style="width: 35%; float: left; padding-left: 2%" class="inline-block">
                    <div style="float: left; padding-right: 3%; width: 150px">
                        <label>
                            City:
                        </label>
                    </div>
                    <div style="float: left">
                        <input id="txtCity" type="text" maxlength="20" />
                    </div>
                </div>
                <div class="inline-block">
                    <label>
                        State:
                    </label>
                    <input id="txtState" type="text" maxlength="50" /></div>
            </div>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <div class="inline-block">
                    <label>
                        Email:
                    </label>
                    <input id="txtEmail" type="text" maxlength="50" /></div>
                <div class="inline-block">
                    <label>
                        Mobile No:
                    </label>
                    <input id="txtMobile" type="text" maxlength="20" /></div>
                <div class="inline-block">
                    <label>
                        Phone No:
                    </label>
                    <input id="txtPhn" type="text" maxlength="20" /></div>
            </div>
            <div style="padding-left: 2%; margin-top: 5px; margin-left: 35%" class="inline-block">
                <input id="btnOk" type="button" class="button success" value="Save" onclick="SaveFirm()" />
                <input id="btnCancel" class=" button success" type="button" value="Cancel" onclick="Closethis()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        var PageParam;
        $(document).ready(function () {
            setAdminLevel();
            PageParam = window.location.search.substring(1).split('_');

            if (PageParam[1] == 'Up') {
                FirmId = PageParam[2];
                BindAllFeilds(PageParam[2]);
                $("#btnOk")[0].value = "Update";
            }
            $("input[type=text]").keypress(function () {
                if (event.keyCode == 39) {
                    event.keyCode = 0;
                    return false;
                }
            });
        });
        function setAdminLevel() {
            var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wAdmin == '0') {
//                alert('Only Admin-access user can save and edit data!');
                $("#btnOk")[0].disabled = "disabled";
            }
        }
        function BindAllFeilds(Id) {
            $.ajax({
                type: "POST",
                url: "frmFirm.aspx/LoadData",
                data: "{Id :'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        Bind(msg.d);
                    }
                },
                error: function (result) {
                    alert('Error');
                }
            });
        };

        function Bind(grdData) {

            $("#txtForum")[0].value = grdData[0].FirmName;
            $("#txtAddr")[0].value = grdData[0].Address;
            $("#txtCity")[0].value = grdData[0].City;
            $("#txtState")[0].value = grdData[0].State;
            $("#txtMobile")[0].value = grdData[0].mobile;
            $("#txtPhn")[0].value = grdData[0].PhoneNumber;
            $("#txtEmail")[0].value = grdData[0].EmailId;

        }
        var FirmId = 0;
        function SaveFirm() {
            if (validate()) {

                var cFirm = { Fname: $("#txtForum").val(),
                    Addr: $("#txtAddr").val(), City: $("#txtCity").val(),
                    State: $("#txtState").val(), MobNo: $("#txtMobile").val(), EmailId: $("#txtEmail").val(),
                    PhoneNo: $("#txtPhn").val(), FirmId: FirmId
                };
                if ($("#btnOk")[0].value != "Update") {
                    $.ajax({
                        type: "POST",
                        url: "frmFirm.aspx/SaveFirmDetails",
                        data: "{cFirm :'" + JSON.stringify(cFirm) + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            // Replace the div's content with the page method's return.
                            //                          $("#Result").text(msg.d);
                            alert('Saved Successfully');
                            Closethis();
                        }
                    });
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "frmFirm.aspx/UpdateFirmDetails",
                        data: "{cFirm :'" + JSON.stringify(cFirm) + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            // Replace the div's content with the page method's return.
                            //                          $("#Result").text(msg.d);
                            alert('Updated Successfully');
                            Closethis();
                        }
                    });
                }
            }
        }
        function validate() {
            if ($("#txtForum").val() == "") {
                alert('Please enter Firm Name!');
                return false;
            }
            //            if ($("#txtAddr").val() == "") {
            //                alert('Please enter Address!');
            //                return false;
            //            }
            //            if ($("#txtCity").val() == "") {
            //                alert('Please enter City!');
            //                return false;
            //            }
            //            if ($("#txtState").val() == "") {
            //                alert('Please enter State!');
            //                return false;
            //            }
            //            if ($("#txtMobile").val() == "") {
            //                alert('Please enter Mobile Number!');
            //                return false;
            //            }
            if ($("#txtEmail").val() == "") {

                //                alert('Please enter Email ID!');
                //                return false;
            }
            else if (!ValidateEmail($("#txtEmail").val())) {
                //                alert('Invalid Email Address');
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
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#FirmViews').find('#iHold').contents().find('#btnUpdate');
            btnUpdate.click();
            btnClose.click();
        }

        function GetQueryStringParams(sParam) {

            var sPageURL = window.location.search.substring(1);
            var sURLVariables = sPageURL.split('&');
            for (var i = 0; i < sURLVariables.length; i++) {
                var sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] == sParam) {
                    return sParameterName[1];
                }
            }
        }
    </script>
</body>
</html>
