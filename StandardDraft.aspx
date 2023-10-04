<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StandardDraft.aspx.cs" Inherits="StandardDraft" %>

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
    <link href="Styles/sweet-alert.css" rel="stylesheet" type="text/css" />
    <script src="Js/sweet-alert.min.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div>
        <div class="example">
            <fieldset class="PPFieldset">
                <legend class="PPLegend"></legend>
                <div style="width: 100%; height: 405px">
                    <div style="width: 560px; overflow: auto !important; height: 375px">
                        <table id="grdDocs" class="table">
                        </table>
                        <div id="pager">
                        </div>
                    </div>
                    <div style="width: 100%;">
                        <input id="btnAdd" type="button" class="button success" value="Download" onclick="Download()" />
                        <input id="btnOk" type="button" class="button success" value="New Document" onclick="OpenDocs()" />
                        <input id="btnDelete" type="button" class="button success" value="Delete Document"
                            onclick="DeleteDoc()" />
                        <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                        <input id="btnUpdate" type="button" class="button success" style="display: none"
                            value="none" onclick="GetGrid()" />
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        var grdData;
        $(document).ready(function () {
            setAdminLevel();
            ISViews();
            GetGrid();
        });
        function ISViews() {
            var IsViews = GetQueryStringParams('ISViews');
            if (IsViews == "true") {
                $("#btnOk").css("display", "none");
                $("#btnDelete").css("display", "none");
            }
        }
        function GetGrid() {
            $.ajax({
                type: "POST",
                url: "StandardDraft.aspx/LoadData",
                data: "{cType :'" + GetQueryStringParams('IsType') + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        BindData();
                    }
                }
            });
        }
        function DeleteDoc() {

            var gr = jQuery("#grdDocs").jqGrid('getGridParam', 'selrow');
            if (gr != null) {
                //                var r = confirm("Do you want to delete this document ?");
                //                if (r == false) {
                //                    return false;
                //                }
                swal({ title: "Do you want to delete this document ?", text: "",
                    type: "info", showCancelButton: true, confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Yes, delete it!", closeOnConfirm: false
                },
         function (isConfirm) {
             var DocIds = jQuery("#grdDocs").jqGrid('getGridParam', 'selarrrow');
             //                var MisId = PageParam[2];
             var ids = "";
             $.each(DocIds, function (i, data) {
                 var RowData = jQuery("#grdDocs").getRowData(this);
                 if (ids == "") {
                     ids = RowData.DocId;
                 }
                 else {
                     ids = ids + "@" + RowData.DocId;
                 }
             });

             $.ajax({
                 type: "POST",
                 url: "StandardDraft.aspx/DeleteData",
                 data: "{cIds :'" + ids + "' ,Lit :'" + 0 + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (msg) {
                     $.each(jQuery("#grdDocs").jqGrid('getGridParam', 'selarrrow'), function (index, value) {
                         jQuery("#grdDocs").jqGrid('delRowData', this);
                     });
                     swal({ title: 'deleted succesfully.', type: "info", timer: 5000 });
                 }
             });
         });
            }
            else swal({ title: "Please Select document to delete!", type: "info", timer: 5000 });
        }

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
            jQuery("#grdDocs").jqGrid({
                datatype: "local",
                colNames: ['FileName', 'ID', 'ServiceId'],
                colModel: [
                     { name: 'DocumentName', index: 'DocumentName', width: 400 },
//                     { name: 'ServiceType', index: 'ServiceType', width: 400 },
                      { name: 'DocId', index: 'DocId', width: 80, hidden: true, align: "right" },
                        { name: 'ServiceId', index: 'ServiceId', hidden: true, width: 80, align: "right" }
               ],
                multiselect: true,
                rowNum: 50,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                gridview: true,
                rownumbers: true,
                viewrecords: true,
                grouping: true,
//                groupingView: {
//                    groupField: ['ServiceType'],
//                    groupColumnShow: false,
//                    groupCollapse: true
//                },
                caption: "Standard Draft",
                height: 295,
                ondblClickRow: function (rowId) {

                }
            });

            jQuery("#grdDocs").jqGrid('setGridParam',
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

            var gr = jQuery("#grdDocs").jqGrid('getGridParam', 'selrow');
            if (gr != null) {
                var DocIds = jQuery("#grdDocs").jqGrid('getGridParam', 'selarrrow');
                $.each(DocIds, function (i, gr) {
                    var DocId = jQuery("#grdDocs").jqGrid('getRowData', gr).DocId;
                    var btnOpen = parent.document.getElementById('btnDialogOpen');

                    btnOpen.title = "DownLoad_" + DocId + '_StandardDraft'; //OpenFrnId_BindingData_PageIdtoReturnData_controlId

                    btnOpen.click();
                });
                //                    window.open('frmDownload.aspx?DocId=' & jQuery("#grdDocs").jqGrid('getRowData', gr[0]).DocId);
            }
            else swal({ title: "Please Select document to download!", type: "info", timer: 5000 });
        }
        function OpenDocs() {
            var btnOpen = parent.document.getElementById('btnDialogOpen');

            btnOpen.title = "sDocs_MisData_" + GetQueryStringParams('IsType'); //OpenFrnId_BindingData_PageIdtoReturnData_controlId

            btnOpen.click();
        }

    </script>
</body>
</html>
