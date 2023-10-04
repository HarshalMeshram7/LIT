<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmEmail.aspx.cs" Inherits="frmEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title><%--
    --%><link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/metro-bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>

</head>
<body class="metro">
    <form id="frmEmails" runat="server" class="PPForm">
    <div class="example" >
        <fieldset class="PPFieldset">
            <div style="width: 100%;">
                <div class="inline-block">
                    <label>
                        To:
                    </label>
                    <input id="txtTo" type="text" style="width:550px" />
                    <input id="btnTo" type="button" class="button info" value="..." style="width: 40px"
                        onclick="OpenDialog(this)" />
                </div>
                <div class="inline-block">
                    <label>
                        Cc:
                    </label>
                    <input id="txtCc" type="text" style="width:550px" />
                    <input id="btnCc" type="button" class="button info" value="..." style="width: 40px"
                        onclick="OpenDialog(this)" />
                </div>
                  <div class="inline-block">
                    <label>
                       Bcc:
                    </label>
                    <input id="txtBcc" type="text" style="width:550px" />
                    <input id="btnBcc" type="button" class="button info" value="..." style="width: 40px"
                        onclick="OpenDialog(this)" />
                </div>
                <div class="inline-block">
                    <label>
                        Subject:
                    </label>
                    <input id="txtSubject" type="text" style="width:600px" />
                </div>
                <div class="inline-block">
                    <textarea id="txtContent" cols="20" rows="2" runat="server" style="width:600px;height:260px;margin-top:2%"></textarea>
                    <%--<input id="Text1" type="text" style="width:600px;height:260px;margin-top:2%" />--%>
                </div>
                <div class="inline-block" style="margin-top:2%">
                    
                    <input id="btnSend" type="button" class="button default" value="Send" onclick="SendMail()" />
                    <input id="btnCancel" class="button default" type="button" value="Cancel" onclick="Closethis()"/>               
                   
                </div>
            </div>
        </fieldset>
    </div>
    </form>
     <script type="text/javascript">
        function SendMail() {
            var cMail = { To: $("#txtTo").val(), Cc: $("#txtCc").val(), Bcc: $("#txtBcc").val(),
                    Body: $("#txtContent").val(), Subject: $("#txtSubject").val()
                };
                var MISiD = window.location.search.substring(1).split('_')[2];
                $.ajax({
                    type: "POST",
                    url: "frmEmail.aspx/SendMail",
                    data: "{cMail :'" + JSON.stringify(cMail) + "',MisId:'" + MISiD + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        // Replace the div's content with the page method's return.
                        //                          $("#Result").text(msg.d);
                        alert(msg);
                        Closethis();
                    }
                });
           }

        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }

        function OpenDialog(id) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            switch (id.id) {
                case "btnTo":
                    btnOpen.title = "PopUp_Cotacts_txtTo"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId;
                    break;
                case "btnCc":
                    btnOpen.title = "PopUp_Cotacts_txtCc";
                    break;
                case "btnBcc":
                    btnOpen.title = "PopUp_Cotacts_txtBcc";
                    break;
                default:
                    break;
            }
            btnOpen.click();
        }
        </script>
</body>
</html>
