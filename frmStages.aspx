<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmStages.aspx.cs" Inherits="frmStages" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Js/load-metro.js" type="text/javascript"></script>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/sweet-alert.css" rel="stylesheet" type="text/css" />
    <script src="Js/sweet-alert.min.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div class="example" >
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Stages</legend>
            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                <%-- <label>
                Stages.
            </label>--%>
                <asp:DropDownList ID="ddlStages" Width="255px" runat="server">
                </asp:DropDownList>
            </div>
            <div style="width: 100%; padding-left: 2%;margin-top:5%" class="inline-block">
                <label>
                    Add New Stage.
                </label>
                <input id="txtStage" type="text" maxlength="50"/>
            </div>
            <div style="margin-top:5%">
                <input id="btnOk" type="button" class="button success" value="Save" onclick="SaveStages()" />
                <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
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
        function SaveStages() {
            if ($("#txtStage").val() == "") {
                alert('Please enter stage Name!');
                return false;
            }
            $.ajax({
                type: "POST",
                url: "frmStages.aspx/SaveStages",
                data: "{sStage :'" + $("#txtStage")[0].value + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    // Replace the div's content with the page method's return.
                    //                    alert('saved succesfully!');
                    swal({ title: "saved successfully!", type: "success", timer: 5000 });
                    Closethis();
                }
            });

        }
        function setAdminLevel() {
            var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wAdmin == '0') {
//                alert('Only Admin-access user can save and edit data!');
                $("#btnOk")[0].disabled = "disabled";
            }
        }
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
    </script>
</body>
</html>
