<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvocateDetails.aspx.cs"
    Inherits="AdvocateDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmAdvocate" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Advocate Details </legend>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <div class="inline-block">
                    <label>
                        Name:
                    </label>
                    <input id="txtFirstName" type="text" style="width: 210px" maxlength="100"/>
                </div>
                <div class="inline-block">
                    <label>
                        Area of Expertise:
                    </label>
                    <input id="txtAoe" type="text" />
                </div>
               <%-- <div class="inline-block">
                    <label>
                        Firm Name:
                    </label>
                    <input id="txtForum" type="text" />
                </div>--%>
            </div>
          <%--  <div style="width: 100%" class="inline-block">
                <div style="float: left; padding-left: 2%; width: 70%">
                    <div style="width: 150px">
                        <label>
                            Address:
                        </label>
                    </div>
                    <div>
                        <input id="txtAddr" type="text" style="width: 100%" />
                    </div>
                </div>
            </div>
            <div style="width: 100%" class="inline-block">
                <div style="width: 30%; float: left; padding-left: 2%" class="inline-block">
                    <div style="float: left; padding-right: 3%; width: 150px">
                        <label>
                            City:
                        </label>
                    </div>
                    <div style="float: left">
                        <input id="txtCity" type="text" />
                    </div>
                </div>
                <div class="inline-block">
                    <label>
                        State:
                    </label>
                    <input id="txtState" type="text" /></div>
            </div>--%>
            <div style="width: 100%;padding-left: 2%;" class="inline-block">
            <label>
                                    Firm 
                                </label>
                                <input id="txtFirmId" type="text" style="display:none" />
                                <input id="txtFirm" type="text" disabled="disabled" style="width: 310px" />
                                <input id="btnFirm" type="button" class="button info" value="..." style="width: 40px"
                                    onclick="OpenDialog()" />
            </div>
    <div style="width: 100%; padding-left: 2%;" class="inline-block">
        <div class="inline-block">
            <label>
                Email:
            </label>
            <input id="txtEmail" type="text" maxlength="100"/></div>
        <div class="inline-block">
            <label>
                Mobile No:
            </label>
            <input id="txtMobile" type="text" maxlength="50"/></div>
       
    </div>
    <div style="padding-left: 2%; margin-top: 5px; margin-left: 35%" class="inline-block">
        <input id="btnOk" type="button" class="button success" value="Save" onclick="SaveAdvocate()" />
        <input id="btnCancel" class=" button success" type="button" value="Cancel" onclick="Closethis()" />
    </div>
    </fieldset> 
    </div>
    </form>
    <script type="text/javascript">
        var PageParam;
        var AllAdv = [];
        $(document).ready(function () {
            setAdminLevel();
            $("input[type=text]").keypress(function () {
                if (event.keyCode == 39) {
                    event.keyCode = 0;
                    return false;
                }
            });
            PageParam = window.location.search.substring(1).split('_');
            $.ajax({
                type: "POST",
                url: "AdvocateDetails.aspx/LoadAllData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        AllAdv = JSON.parse(msg.d);
                    }
                },
                error: function (result) {
//                    alert('Error');
                }
            });
            if (PageParam[1] == 'Up') {
                AdvId = PageParam[2];
                BindAllFeilds(PageParam[2]);
                $("#btnOk")[0].value = "Update";
            }
        });


        function setAdminLevel() {
            var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wAdmin == '0') {
                $("#btnOk")[0].disabled = "disabled";
//                salert("Only Admin-access user can save and edit data", "info");
            }
        }

        function BindAllFeilds(Id) {
            $.ajax({
                type: "POST",
                url: "AdvocateDetails.aspx/LoadData",
                data: "{Id :'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        Bind(msg.d);
                    }
                },
                error: function (result) {
//                    alert('Error');
                    salert("Error Loading", "error");
                }
            });
        };

        function Bind(grdData) {
            $("#txtFirstName")[0].value = grdData[0].AdvName;
//            $("#txtLastNAme")[0].value = grdData[0].LastName;
            $("#txtFirmId")[0].value = grdData[0].FirmId;           
            $("#txtMobile")[0].value = grdData[0].mobile;
            $("#txtFirm")[0].value = grdData[0].FirmName;
            $("#txtEmail")[0].value = grdData[0].EmailId;
            $("#txtAoe")[0].value = grdData[0].AOfExperties;
        }
        var AdvId=0;
        function SaveAdvocate() {
            if (validate()) {

                var cAdvocate = { Fname: $("#txtFirstName").val(),
                    Forum: $("#txtFirmId").val(), MobNo: $("#txtMobile").val(),
                    EmailId: $("#txtEmail").val(), AOExp: $("#txtAoe").val(),
                   AdvId: AdvId
                };
                if ($("#btnOk")[0].value != "Update") {
                    $.ajax({
                        type: "POST",
                        url: "AdvocateDetails.aspx/SaveAdvocateDetails",
                        data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {                           
//                            alert('Saved Successfully');
                            salert("Saved Successfully", "success");
                            Closethis();
                        }
                    });
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "AdvocateDetails.aspx/UpdateAdvocateDetails",
                        data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {                           
//                            alert('Updated Successfully');
                            salert("Updated Successfully", "success");
                            Closethis();
                        }
                    });
                }
            }
        }
        function validate() {
            if ($("#txtFirstName").val() == "") {
//                alert('Please enter Name!');
                salert("Please enter Name!", "warning");
                return false;
            }
//            if ($("#txtAddr").val() == "") {
//                alert('Please enter Address!');
//                return false;
//            }
            if ($("#txtFirmId").val() == "") {
                alert('Please enter Firm!');
                return false;
            }
           
            if ($("#txtMobile").val() == "") {
//                alert('Please enter Mobile Number!');
//                return false;
            }
            if ($("#txtEmail").val() == "") {

//                alert('Please enter Email ID!');
//                return false;
            }
            else if (!ValidateEmail($("#txtEmail").val())) {
//                alert('Invalid Email Address');
                return false;
            }            //$("#txtFirstName").val()
            if ($("#btnOk")[0].value != "Update") {
                var IsNamePresent = false;
                $.each(AllAdv, function (i, data) {
                    var sName = $("#txtFirstName").val();
                    if (sName == data.sAdvName) {
                        IsNamePresent = true;
                    }
                });
                if (IsNamePresent) {
                    //                alert('Advocate Name already Present!');
                    salert("Advocate Name already Present!", "warning");
                    return false;
                }
            }
            return true;
        }

        function ValidateEmail(inputText) {
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (inputText.match(mailformat)) {
                return true;
            }
            else {
//                alert("You have entered an invalid email address!");
                salert("You have entered an invalid email address!", "warning");
                return false;
            }
        }
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#AdvocateView').find('#iHold').contents().find('#btnUpdate');
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

        function OpenDialog() {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "PopUp_Firm_Adv"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId
            btnOpen.click();

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
