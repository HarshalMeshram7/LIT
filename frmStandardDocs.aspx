<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmStandardDocs.aspx.cs"
    Inherits="frmStandardDocs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <ajaxtoolkit:toolkitscriptmanager runat="Server" enablepartialrendering="true" id="ScriptManager1" />
    <fieldset class="PPFieldset">
        <legend class="PPLegend">Select Documents</legend>
        <div>
            <label>
                Select Service Type</label>
            <asp:DropDownList ID="ddlServiceType" runat="server">
            </asp:DropDownList>
        </div>
        <div class="example" style="overflow: auto">
            <div class="demoarea" style="height: 300px; overflow: auto">
                Click '<i>Select File</i>
                <br />
                <br />
                <ajaxtoolkit:asyncfileupload onclientuploadstarted="uploadStarted" onclientuploaderror="uploadError"
                    onclientuploadcomplete="uploadComplete" runat="server" id="AsyncFileUpload1"
                    allowedfiletypes="jpg,jpeg,pdf" width="400px" uploaderstyle="Modern" uploadingbackcolor="#CCFFFF"
                    throbberid="myThrobber" />
                &nbsp;<asp:Label runat="server" ID="myThrobber" Style="display: none;"><img align="absmiddle" alt="" src="Styles/images/loading.gif" /></asp:Label>
                <asp:Label runat="server" Text="&nbsp;" ID="uploadResult" />
                <br />
                <br />
                <div>
                    <strong>Current events:</strong></div>
                <table style="border-collapse: collapse; border-left: solid 1px #aaaaff; border-top: solid 1px #aaaaff;"
                    runat="server" cellpadding="3" id="clientSide" />
            </div>
            <label style="color: Red">
                *Note:Selecting file will save it in database.</label>
            <div style="margin-top: 2%">
                <input id="btnCancel" class="default button" type="button" value="Cancel" onclick="Closethis()" />
                <asp:HiddenField runat="server" ID="hdnMisId" Value="0" />
            </div>
        </div>
    </fieldset>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {

        });
        function fillCell(row, cellNumber, text) {
            var cell = row.insertCell(cellNumber);
            cell.innerHTML = text;
            cell.style.borderBottom = cell.style.borderRight = "solid 1px #aaaaff";
        }
        function addToClientTable(name, text) {
            var table = document.getElementById("<%= clientSide.ClientID %>");
            var row = table.insertRow(0);
            fillCell(row, 0, name);
            fillCell(row, 1, text);
        }

        function uploadError(sender, args) {
            addToClientTable(args.get_fileName(), "<span style='color:red;'>" + args.get_errorMessage() + "</span>");
        }
        function uploadComplete(sender, args) {
            var contentType = args.get_contentType();
            var text = args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += ", '" + contentType + "'";
            }
            addToClientTable(args.get_fileName(), text);
        }

        function uploadStarted(sender, args) {
            var ext = args.get_fileName().substring(args.get_fileName().lastIndexOf(".") + 1);
            var flag = true;
            switch (ext.toLowerCase()) {
                case 'jpg':
                case 'jpeg':
                case 'png':
                case 'gif':
                case 'pdf':
                case 'doc':
                case 'docx':
                    flag = true;
                    break;
                default:
                    flag = false;

                    var err = new Error();
                    err.name = "Upload Error";
                    err.message = "Please upload only Image/PDF files ";
                    throw (err);
                    //cancel upload

                    return false;
                    break;

            }
            if (flag == false) {
                return false;
            }
        }
        function Closethis() {
            var UpdateDoc = $(parent.document).find('#StanDraft').find('#iHold').contents().find('#btnUpdate');
            UpdateDoc.click();
            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
    
    </script>
</body>
</html>
