<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmAuthPrsn.aspx.cs" Inherits="frmAuthPrsn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmAuthPsn" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Authorized Person Details </legend>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <div class="inline-block">
                    <label>
                        Name:
                    </label>
                    <input id="txtFirstName" type="text"  maxlength="100" style="width: 310px" />
                </div>
            </div>
             <div style="padding-left: 2%; width: 100%"  class="inline-block">
                    <div class="inline-block">
                        <label>
                            Address:
                        </label>                   
                        <input id="txtAddr" type="text" maxlength="200" style="width: 310px" />
                    </div>
                </div>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <div class="inline-block">
                    <label>
                        Email:
                    </label>
                    <input id="txtEmail" type="text"  maxlength="60" /></div>
                <div class="inline-block">
                    <label>
                        Mobile No:
                    </label>
                    <input id="txtMobile" type="text"  maxlength="30" /></div>
            </div>
            <div style="padding-left: 2%; margin-top: 5px; margin-left: 35%" class="inline-block">
                <input id="btnOk" type="button" class="button success" value="Save" onclick="SavePerson()" />
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
                 Id = PageParam[2];
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

         function BindAllFeilds(Id) {
             $.ajax({
                 type: "POST",
                 url: "frmAuthPrsn.aspx/LoadData",
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
             $("#txtFirstName")[0].value = grdData[0].Name;
             //            $("#txtLastNAme")[0].value = grdData[0].LastName;

             $("#txtMobile")[0].value = grdData[0].PhoneNumber;
             $("#txtAddr")[0].value = grdData[0].Address;
             $("#txtEmail")[0].value = grdData[0].EmailId;
             $("#txtFirmId")[0].value = grdData[0].FirmId;
         }
         function setAdminLevel() {
             var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
             if (wAdmin == '0') {
//                 alert('Only Admin-access user can save and edit data!');
                 $("#btnOk")[0].disabled = "disabled";
             }
         }
         var Id = 0;
         function SavePerson() {
             if (validate()) {

                 var cPerson = { Fname: $("#txtFirstName").val(),
                     MobNo: $("#txtMobile").val(),
                     Addr: $("#txtAddr").val(),
                     EmailId: $("#txtEmail").val(),
                     Id: Id
                 };
                 if ($("#btnOk")[0].value != "Update") {
                     $.ajax({
                         type: "POST",
                         url: "frmAuthPrsn.aspx/SaveAdvocateDetails",
                         data: "{cPerson :'" + JSON.stringify(cPerson) + "'}",
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
                         url: "frmAuthPrsn.aspx/UpdateAdvocateDetails",
                         data: "{cPerson :'" + JSON.stringify(cPerson) + "'}",
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
             if ($("#txtFirstName").val() == "") {
                 alert('Please enter First Name!');
                 return false;
             }
            
//             if ($("#txtMobile").val() == "") {
//                 alert('Please enter Mobile Number!');
//                 return false;
//             }
             if ($("#txtEmail").val() == "") {

//                 alert('Please enter Email ID!');
//                 return false;
             }
             else if (!ValidateEmail($("#txtEmail").val())) {
//                 alert('Invalid Email Address');
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
             var btnUpdate = $(parent.document).find('#AuthView').find('#iHold').contents().find('#btnUpdate');
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
    </script>
</body>
</html>
