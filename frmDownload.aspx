<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmDownload.aspx.cs" Inherits="frmDownload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>     
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    <script type="text/javascript">
        function CloseWindow() {
            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
        $(document).ready(function () {
            //            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            //            btnClose.click();
            window.close();
        });
               
    </script>
</body>
</html>
