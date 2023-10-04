<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LitClient.aspx.cs" Inherits="LitClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Js/grid.locale-en.js" type="text/javascript"></script>
    <script src="Js/jquery.jqGrid.src.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmLIT" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Add Client</legend>
            <div>
                <div style="padding-left: 2%; width: 60%">
                    <div style="padding-right: 3%; width: 150px">
                        <label>
                            Name:
                        </label>
                    </div>
                    <div>
                        <input id="txtName" type="text" maxlength="100" style="width: 360px" />
                    </div>
                </div>
                <div style="padding-left: 2%; width: 60%">
                    <div style="padding-right: 3%; width: 150px">
                        <label>
                            Address:
                        </label>
                    </div>
                    <div>
                        <input id="txtAddr" type="text" maxlength="200" style="width: 360px" />
                    </div>
                </div>
                <div style="width: 100%; padding-left: 2%;" class="inline-block">
                    <div class="inline-block">
                        <label>
                            City:
                        </label>
                        <input id="txtCity" type="text" maxlength="50" /></div>
                    <div class="inline-block">
                        <label>
                            State:
                        </label>
                        <input id="txtState" type="text" maxlength="50" /></div>
                </div>
                <div style="width: 100%; padding-left: 2%;" class="inline-block">
                    <div class="inline-block">
                        <label>
                            Email Id:
                        </label>
                        <input id="txtEmail" type="text" maxlength="50" />
                    </div>
                    <div class="inline-block">
                        <label>
                            Mobile No:
                        </label>
                        <input id="txtMobile" type="text" maxlength="50" />
                    </div>
                    <div class="inline-block">
                        <label>
                            Phone No:
                        </label>
                        <input id="txtPhn" type="text" maxlength="50" />
                    </div>
                    <div class="inline-block">
                        <label>
                            Vertical
                        </label>
                        <asp:DropDownList ID="ddlVertical" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div style="width: 100%">
                    <div style="width: 30%; float: right; padding-left: 2%; padding-top: 10px">
                        <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                    </div>
                    <div style="width: 30%; float: right; padding-left: 2%; padding-top: 10px">
                        <input id="btnOk" type="button" class=" button success" value="Save" onclick="SaveClient()" />
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        var PageParam;
        $(document).ready(function () {
            setAdminLevel();
            PageParam = window.location.search.substring(1).split('_'); ;

            if (PageParam[1] == 'Up') {
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
                //                salert("Only Admin-access user can save and edit data", "info");
                $("#btnOk")[0].disabled = "disabled";
            }
        }

        function BindAllFeilds(Id) {
            $.ajax({
                type: "POST",
                url: "LitClient.aspx/LoadData",
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
            $("#txtName")[0].value = grdData[0].ClientName;
            $("#txtAddr")[0].value = grdData[0].Address;
            $("#txtCity")[0].value = grdData[0].City;
            $("#txtState")[0].value = grdData[0].State;
            $("#txtMobile")[0].value = grdData[0].Mobile;
            $("#txtPhn")[0].value = grdData[0].Phone;
            $("#txtEmail")[0].value = grdData[0].Email;
            $("#ddlVertical").val(grdData[0].VerticalId);
        }




        function SaveClient() {
            if (validate()) {
                var cLitClient = { Name: $("#txtName").val(), City: $("#txtCity").val(),
                    State: $("#txtState").val(), EmailId: $("#txtEmail").val(),Vertical: $("#ddlVertical").val(),
                    MobNo: $("#txtMobile").val(), PhoneNo: $("#txtPhn").val(), ID: PageParam[2]
                };
                var Addr = $("#txtAddr").val();
                if ($("#btnOk")[0].value != "Update") {
                    $.ajax({
                        type: "POST",
                        url: "LitClient.aspx/SaveClientDetails",
                        data: "{cClient :'" + JSON.stringify(cLitClient) + "',Addrrs :'" + Addr + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //                            swal({ title: "saved successfully!", type: "success", timer: 5000 });
                            salert("saved successfully", "success");
                            Closethis();
                        }
                    });
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "LitClient.aspx/UpdateClientDetails",
                        data: "{cClient :'" + JSON.stringify(cLitClient) + "',Addrrs :'" + Addr + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //                          alert('Updated succesfully!');
                            salert("Updated successfully", "success");
                            Closethis();
                        }
                    });
                }
            }
        }
        function validate() {
            if ($("#txtName").val() == "") {
                alert('Please enter Name!');
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
            //validation for Numbers
            var filter = /^[a-zA-Z]*$/;
            if ($("#txtMobile").val() == "") {
                //                alert('Please enter Mobile Number!');
                //                return false;
            }
            else if (filter.test($("#txtMobile").val())) {
                //                alert('Mobile Number is invalid!');
                //                return false;
            }
            //            if (filter.test($("#txtPhn").val())) {
            //                alert('Mobile Number is invalid!');
            //                return false;
            //            }
            if ($("#txtEmail").val() == "") {
                //                alert('Please enter Email Id!');
                //                return false;
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
                //                alert("You have entered an invalid email address!");
                salert("You have entered an invalid email address!", "warning");
                return false;
            }
        }

        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            var btnUpdate = $(parent.document).find('#ClientView').find('#iHold').contents().find('#btnUpdate');
            btnUpdate.click();
            btnClose.click();
        }
        function checkQuote() {
            if (event.keyCode == 39) {
                event.keyCode = 0;
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
