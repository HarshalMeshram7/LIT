<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmAddrbook.aspx.cs" Inherits="frmAddrbook" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
     <style type="text/css">
        input[type=text]
        {
            width: 200px !important;
        }
        
    </style>
</head>
<body class="metro">
    <form id="frmBook" runat="server" class="PPForm">
    <div>
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Add Contact</legend>
            <div style="width: 100%;">
                <div style="width: 100%;" class="inline-block">
                    <label>
                        Name
                    </label>
                    <input id="txtName" type="text"  maxlength="60" />
                </div>
                <div style="width: 100%;" class="inline-block">
                    <label>
                       Job title
                    </label>
                    <input id="txtJob" type="text" maxlength="60"/>
                </div>
                <div style="width: 100%;" class="inline-block">
                    <label>
                        Company
                    </label>
                    <input id="txtComp" type="text" maxlength="60"/>
                </div>
                 <div class="inline-block ">
                    <label>
                        Email Id:
                    </label>
                    <input id="txtEmail" type="text"  maxlength="60" /></div>
                <div style="" class="inline-block">
                    <label>
                        Phone No
                    </label>
                    <input id="txtPhone" type="text"  maxlength="60"  /></div>
               
            </div>
            <div style="margin-top: 5%">
                <input id="btnUsrUPdate" class="default button" type="button" value="Save" onclick="Save()" />
                <input id="btnCancel" class="default button" type="button" value="Cancel" onclick="Closethis()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#ContactView').find('#iHold').contents().find('#btnUpdate');
            btnUpdate.click();

            btnClose.click();
        }

        function Save() {
            if (validateURs()) {

                if ($("#btnUsrUPdate")[0].value != "Update") {
                    $.ajax({
                        type: "POST",
                        url: "frmAddrbook.aspx/Save",
                        data: "{sName :'" + $("#txtName")[0].value + "',sEmail:'" + $("#txtEmail")[0].value + "',sJob:'" + $("#txtJob")[0].value + "',sComp:'" + $("#txtComp")[0].value + "', sPhone :'" + $("#txtPhone")[0].value + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            // Replace the div's content with the page method's return.
                            alert('Saved succesfully!');
                            $("#txtName")[0].value = "";
                            $("#txtEmail")[0].value = "";
                            $("#txtPhone")[0].value = "";
                            $("#txtComp")[0].value = "";
                            $("#txtJob")[0].value = "";
                        }
                    });


                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "frmAddrbook.aspx/UpdateDetails",
                        data: "{sName :'" + $("#txtName")[0].value + "',sEmail:'" + $("#txtEmail")[0].value + "',sJob:'" + $("#txtJob")[0].value + "',sComp:'" + $("#txtComp")[0].value + "', sPhone :'" + $("#txtPhone")[0].value + "', sId :'" + Id + "'}",
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
        function validateURs() {
            if ($("#txtName").val() == "") {
                alert('Please enter Name!');
                return false;
            }
            if ($("#txtEmail").val() == "") {
                alert('Please enter emailId !');
                return false;
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
        var Id;
        $(document).ready(function () {
            PageParam = window.location.search.substring(1).split('_');

            if (PageParam[1] == 'Up') {
                Id = PageParam[2];
                BindAllFeilds(PageParam[2]);
                $("#btnUsrUPdate")[0].value = "Update";
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
                url: "frmAddrbook.aspx/LoadData",
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
            $("#txtName")[0].value = grdData[0].Name;
            //            $("#txtLastNAme")[0].value = grdData[0].LastName;

            $("#txtJob")[0].value = grdData[0].Job;
            $("#txtComp")[0].value = grdData[0].Company;
            $("#txtEmail")[0].value = grdData[0].Email;
            $("#txtPhone")[0].value = grdData[0].Phone;
            
        }
    </script>
</body>
</html>
