<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditView.aspx.cs" Inherits="EditView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmEditView" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Select Search Criteria</legend>
            <div style="height: 240px">
                <div class="inline-block">
                    <label>
                        Advocate</label>
                    <input id="txtAdvId" type="text" class="info " disabled="disabled" style="width: 130px"
                        value="" />
                    <input id="txtAdv" type="text" style="width: 350px" />
                    <input id="btnAdv" type="button" class="button info" value="..." style="width: 40px"
                        onclick="OpenDialog(this)" />
                </div>
                <div class="inline-block">
                    <label>
                        Client</label>
                    <input id="txtClientId" type="text" class="info " disabled="disabled" style="width: 130px"
                        value="" />
                    <input id="txtlient" type="text" style="width: 350px" />
                    <input id="btnClient" type="button" class="button info" value="..." style="width: 40px"
                        onclick="OpenDialog(this)" />
                </div>
                <div class="inline-block">
                    <div class="inline-block">
                        <label>
                            case-name</label>
                        <input id="txtCase" type="text" class="info " value="" style="width: 350px" />
                    </div>
                    <div class="inline-block">
                        <label>
                            verticals</label>
                        <%--<input id="txtVertical" type="text" class="info " value="" />--%>
                        <select id="txtVertical" style="width: 155px">
                            <option class="info">None</option>
                            <option class="info" selected="selected">IFS</option>
                            <option>SDB</option>
                            <option>MPIL</option>
                        </select>
                    </div>
                </div>
                <div class="inline-block">
                    <div class="inline-block">
                        <label>
                            Forum</label>
                        <input id="txtForum" type="text" style="width: 350px" />
                    </div>
                    <div class="inline-block">
                        <label>
                            Location</label>
                        <input id="txtLocation" type="text" class="info " value="" />
                    </div>
                </div>
            </div>
            <div class="inline-block" style="padding-left: 70%">
                <input id="btnSearch" type="button" class="button default" value="Search" onclick="Search()" />
                <input id="btnCancel" type="button" class="button default" value="Cancel" onclick="Closethis()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        function OpenDialog(id) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            switch (id.id) {
                case "btnAdv":
                    btnOpen.title = "PopUp_Advocate_EditView"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId;
                    break;
                case "btnForum":

                    break;
                case "btnClient":
                    btnOpen.title = "PopUp_Client_EditView";
                    break;
                default:
                    break;
            }
            btnOpen.click();
        }
        function Closethis() {
            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }

        function Search() {
            var cSearchCriteria = { AdvID: $("#txtAdvId").val(), ClientID: $("#txtClientId").val(),
                Forum: $("#txtForum").val(),
                Case: $("#txtCase").val(), verticals: $("#txtVertical").val()
            };
            $.ajax({
                type: "POST",
                url: "EditView.aspx/Search",
                data: "{cSearch :'" + JSON.stringify(cSearchCriteria) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    // Replace the div's content with the page method's return.

                    openSearch("aLitViews_" +  msg.d);
                }
            });
        }

        function openSearch(val) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = val;
            btnOpen.click();
        }
    </script>
</body>
</html>
