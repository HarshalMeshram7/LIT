<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportMis.aspx.cs" Inherits="Styles_ReportMis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="Styles/redmond/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Js/grid.locale-en.js" type="text/javascript"></script>
    <script src="Js/jquery.jqGrid.src.js" type="text/javascript"></script>

</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div>
        <div class="example">
            <fieldset class="PPFieldset">
                <legend class="PPLegend">MIS Report</legend>
                <div style="width: 100%; height: 405px">
                    <div style="width: 560px; overflow: auto !important; height: 375px">
                       
                        <table id="grdReport" class="table">
                        </table>
                        <div id="pager">
                        </div>
                    </div>
                    <div style="width: 100%;">
                        <input id="btnOk" type="button" class="button success" value="Download" onclick="Download()" />
                        
                        <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                        <input id="btnUpdate" type="button" class="button success" style="display: none"
                            value="none" onclick="UpdateGrid()" />
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        var grdData;
        $(document).ready(function () {
//            setAdminLevel();
//            ISViews();
            $.ajax({
                type: "POST",
                url: "ReportMis.aspx/LoadData",
                //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        BindData();
                    }
                }
            });
        });
        function setAdminLevel() {
            var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
            if (wAdmin == '100') {
                $("#btnDelete")[0].disabled = "disabled";
            }
            if (wAdmin == '0') {
                $("#btnOk")[0].disabled = "disabled";
                $("#btnDelete")[0].disabled = "disabled";
            }
        }
        function ISViews() {
            var IsViews = GetQueryStringParams('ISViews');
            if (IsViews == "true") {
                $("#btnOk").css("display", "none");
                $("#btnDelete").css("display", "none");
            }
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
        function BindData() {
            jQuery("#grdReport").jqGrid({
                datatype: "local",
                colNames: ['FileName', 'ID','MisId'],
                colModel: [
                     { name: 'DocumentName', index: 'DocumentName', width: 400 },

                      { name: 'DocId', index: 'DocId', width: 80, hidden: true, align: "right" },
                        { name: 'MISId', index: 'MISId', width: 80, hidden: true, align: "right" }
               ],
                multiselect: true,
                rowNum: 10,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                gridview: true,
                rownumbers: true,
                viewrecords: true,
                caption: "MIS",
                height: 295,
                ondblClickRow: function (rowId) {
                   
                }
            });

            jQuery("#grdReport").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");

        }
  
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
        function Download() {

            var gr = jQuery("#grdReport").jqGrid('getGridParam', 'selrow');
            if (gr != null) {
                var DocIds = jQuery("#grdReport").jqGrid('getGridParam', 'selarrrow');
                $.each(DocIds, function (i, gr) {
                    var DocId = jQuery("#grdReport").jqGrid('getRowData', gr).DocId;
                    var MisId = jQuery("#grdReport").jqGrid('getRowData', gr).MISId;
                    var btnOpen = parent.document.getElementById('btnDialogOpen');

                    btnOpen.title = "DownLoad_" + DocId + '@' + MisId+"_MIS"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId

                    btnOpen.click();
                });
                //                    window.open('frmDownload.aspx?DocId=' & jQuery("#grdDocs").jqGrid('getRowData', gr[0]).DocId);
            }
            else swal({ title: "Please Select document to download!", type: "info", timer: 5000 });
        } 

    </script>
</body>
</html>
