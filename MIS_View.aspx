<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MIS_View.aspx.cs" Inherits="Styles_MIS_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="Styles/redmond/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="Styles/sweet-alert.css" rel="stylesheet" type="text/css" />
    <%-- <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>--%>
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Js/grid.locale-en.js" type="text/javascript"></script>
    <script src="Js/jquery.jqGrid.src.js" type="text/javascript"></script>
    <%-- <script src="Js/JqGridPrintPlugin.js" type="text/javascript"></script>--%>
    <script src="Js/pdfmake.min.js" type="text/javascript"></script>
    <script src="Js/vfs_fonts.js" type="text/javascript"></script>
    <script src="Js/sweet-alert.min.js" type="text/javascript"></script>
    <style type="text/css">
        .headertext
        {
            font-family: "Segoe UI" ,Arial,Helvetica,sans-serif;
            font-weight: normal;
            color: White;
            font-size: 12px;
            height: 15px !important;
            width: 50px;
            padding-bottom: 3px;
            border-top: 1px solid #133C44;
            border-bottom: 1px solid #133C44;
            background: -prefix-linear-gradient(top, #97C2D7, #6AA6C2 50%, #358DB0 50%,#7BBBCF 100%) !important;
            background: linear-gradient(to bottom, #97C2D7, #6AA6C2 50%, #358DB0 50%,#7BBBCF 100%) !important;
            background-image: -webkit-linear-gradient(top,#97C2D7 ,#6AA6C2 50%,#358DB0 50%,#7BBBCF 100%) !important;
            color: #fff;
            text-shadow: none;
        }
        .Selected
        {
            background: -prefix-linear-gradient(top, #D9EEF9, #BDDEF4 40%, #9DDAF2 40%,#BFE3F6 100%) !important;
            background: linear-gradient(to bottom, #D9EEF9, #BDDEF4 40%, #9DDAF2 40%,#BFE3F6 100%) !important;
            background-image: -ms-linear-gradient(top, #D9EEF9, #BDDEF4 40%, #9DDAF2 40%,#BFE3F6 100%) !important;
            color: Black;
            text-shadow: none;
            border-top: 1px solid #5590A6;
            border-bottom: 1px solid #5590A6;
        }
        .wijgrid
        {
            border-radius: 12px 12px 12px 12px;
            border: 1px solid #358DB0;
            outline: none;
            overflow: auto !important;
        }
        .Row
        {
            color: Black;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            text-shadow: none;
            line-height: 16px;
        }
        .ui-jqgrid-bdiv
        {
            max-width: 660px;
        }
    </style>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend"></legend>
            <div style="width: 100%; ">
                <div style="width: 650px; overflow: hidden !important; height: 460px">
                    <%--   <asp:GridView runat="server" ID="grdMis" SelectedRowStyle-CssClass="Selected"
                        CssClass="table  wijgrid"  RowStyle-CssClass="Row" HeaderStyle-CssClass="headertext"
                        AutoGenerateColumns="true">
                        <Columns>
                            <asp:BoundField DataField="sAdvFName" HeaderText="First Name" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="sAdvMName" HeaderText="Middle Name" />
                            <asp:BoundField DataField="sAdvLName" HeaderText="Last Name" />
                            <asp:BoundField DataField="sAddress" HeaderText="Address" />
                            <asp:BoundField DataField="sCity" HeaderText="City" />
                            <asp:BoundField DataField="sState" HeaderText="State" />
                            <asp:BoundField DataField="sEmail" HeaderText="Email" />
                        </Columns>
                    </asp:GridView>--%>
                    <table id="grdMisView" class="table">
                    </table>
                    <div id="pager">
                    </div>
                    <div id='prt-container' style="display: none">
                    </div>
                </div>
                <div style="width: 100%;">
                </div>
                <input id="btnOk" type="button" class="button success" value="New LIT" onclick="New()" />
                <input id="btnDelete" type="button" class="button success" value="Delete LIT" onclick="Delete()" />
                <input id="btnPrint" type="button" class="button success" value="Print" onclick="PrintPdf()" />
                <%--  <input id="btnPrintPdf" type="button" class="button success" value="Print Pdf" onclick="PrintPdf()" />--%>
                <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                <input id="btnUpdate" type="button" class="button success" style="display: none"
                    value="none" onclick="UpdateGrid()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        function Closethis() {
            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
        var grdData;
        function ISViews() {
            var IsViews = GetQueryStringParams('ISViews');
            if (IsViews.split('_')[0] == "true") {
                $("#btnOk").css("display", "none");
                $("#btnDelete").css("display", "none");
            }
        }
        var DataQuery = "";
        $(document).ready(function () {
            setAdminLevel();
            ISViews();
            var Criteria = GetQueryStringParams('ISViews');
            if (Criteria.split('_')[1] != "true") {
                var naturId = GetQueryStringParams('NatureId');
                var vertical = GetQueryStringParams('Vertical');
                DataQuery = "{Nature :'" + naturId + "',Vertical:'" + vertical + "'}";
                $.ajax({
                    type: "POST",
                    url: "MIS_View.aspx/LoadData",
                    data: DataQuery,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != null) {
                            grdData = msg.d;
                            BindData();
                        }
                    },
                    error: function (result) {
                        alert('Error');
                    }
                });
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "MIS_View.aspx/SearchData",
                    //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != null) {
                            grdData = msg.d;
                            BindData();
                        }
                    },
                    error: function (result) {
                        alert('Error');
                    }
                });
            }
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
        function BindData() {
            jQuery("#grdMisView").jqGrid({
                datatype: "local",
                colNames: ['LitID', 'Case Name', 'Type No', 'Forum', 'Vertical', 'Stages', 'Nature'],
                colModel: [
                     { name: 'MISId', index: 'MISId', width: 100, hidden: true },
                     { name: 'CaseName', index: 'CaseName', width: 180 },
                       { name: 'SuitNum', index: 'SuitNum', width: 100 },
                     { name: 'Forum', index: 'Forum', width: 120 },

                     { name: 'Vertical', index: 'Vertical', width: 60 },
                     { name: 'Stage', index: 'Stage', width: 90 },
                     { name: 'Nature', index: 'Nature', width: 80 }
               ],
                multiselect: true,
                rowNum: 50,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                viewrecords: true,
//                grouping: true,
//                groupingView: {
//                    groupField: ['Vertical'],
//                    groupColumnShow: false,
//                    groupCollapse: true
//                },
                height: 360,
                width: 650,
                caption: "Litigation Views",
                ondblClickRow: function (rowId) {
                    var rowData = jQuery(this).getRowData(rowId);
                    var MISId = rowData['MISId'];
                    openMisDetail(MISId);
                }
            });
            jQuery("#grdMisView").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
            //            for (var i = 0; i <= grdData.length; i++) {
            //                jQuery("#grdMisView").jqGrid('addRowData', i + 1, grdData[i]);
            //            }
            $("#grdMisView").navGrid('#pager', { view: false, del: false, add: false, edit: false, search: false, reload: false },
           {}, // default settings for edit
           {}, // default settings for add
           {}, // delete
           {}, // search options
           {}
 );
            setPrintGrid('grdMisView', 'pager', 'Litigation Views');
            $('.ui-icon-refresh').click(function () {
                UpdateGrid();
            });
        }

        function setPrintGrid(gid, pid, pgTitle) {
            // print button title.
            var btnTitle = 'Print Grid';
            //            // setup print button in the grid top navigation bar.
            //            $('#' + gid).jqGrid('navSeparatorAdd', '#' + gid
            //                + '_toppager_left', { sepclass: 'ui-separator' });
            //            $('#' + gid).jqGrid('navButtonAdd', '#' + gid
            //                + '_toppager_left', { caption: '', title: btnTitle,
            //                    position: 'last', buttonicon: 'ui-icon-print',
            //                    onClickButton: function () { PrintGrid(); }
            //                });
            // setup print button in the grid bottom navigation bar.
            $('#' + gid).jqGrid('navSeparatorAdd', '#' + pid,
                { sepclass: "ui-separator" });
            $('#' + gid).jqGrid('navButtonAdd', '#' + pid,
                { caption: '', title: btnTitle, position: 'last',
                    buttonicon: 'ui-icon-print', onClickButton: function 
                () { PrintGrid(); }
                });
            function PrintGrid() {
                //                    // empty the print div container.
                //                    $('#prt-container').empty();
                //                    // copy and append grid view to print div container.
                //                    $('#gview_' + gid).clone().appendTo('#prt-container').css({ 'page-break-after': 'auto' });
                //                    // remove navigation divs.
                //                    $('#prt-container div').remove('.ui-jqgrid-toppager,.ui-jqgrid-titlebar,.ui-jqgrid-pager');
                //                    // print the contents of the print container.
                //                    $('#prt-container').printElement({ pageTitle: pgTitle, overrideElementCSS:
                //                   [{ href: 'Styles/print-grid.css', media: 'print'}]
                //                    });
                PrintPdf();
            }
        }

        function openMisDetail(Id) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "A1_Up_" + Id;
            btnOpen.click();
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

        function UpdateGrid() {
            $.ajax({
                type: "POST",
                url: "MIS_View.aspx/LoadData",
                data: DataQuery,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        //                          $("#grdConct").jqGrid('GridUnload');
                        $("#grdMisView").jqGrid('clearGridData');
                        jQuery("#grdMisView").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
                        //                        for (var i = 0; i <= grdData.length; i++) {
                        //                            jQuery("#grdMisView").jqGrid('addRowData', i + 1, grdData[i]);
                        //                        }
                    }
                }
            });

        }
        function New() {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "A1_New_";
            btnOpen.click();
        }
        function Delete() {
            if (jQuery('#grdMisView').jqGrid('getGridParam', 'selarrrow').length == 0) {
                alert('Please select row to delete');
                return false;
            }
            var RowIds = jQuery('#grdMisView').jqGrid('getGridParam', 'selarrrow');
            var ids = "";
            $.each(RowIds, function (i, data) {
                var RowData = jQuery("#grdMisView").getRowData(this);
                if (ids == "") {
                    ids = RowData.MISId + "@";
                }
                else {
                    ids = ids + RowData.MISId + "@";
                }
            });
            $.ajax({
                type: "POST",
                url: "MIS_View.aspx/DeleteData",
                data: "{liitId :'" + ids + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
//                    alert('deleted successfully');
                    $.each(jQuery("#grdMisView").jqGrid('getGridParam', 'selarrrow'), function (index, value) {
                        jQuery("#grdMisView").jqGrid('delRowData', this);
                    });
//                    UpdateGrid();
                    swal({ title: "deleted successfully!", type: "success", timer: 5000 });
                }
            });
        }
        function Print() {
            //            // empty the print div container.
            //            $('#prt-container').empty();
            //            // copy and append grid view to print div container.
            //            $('#grdMisView').clone().appendTo('#prt-container').css({ 'page-break-after': 'auto' });
            //            // remove navigation divs.
            //            $('#prt-container div').remove('.ui-jqgrid-toppager,.ui-jqgrid-titlebar,.ui-jqgrid-pager');
            //            // print the contents of the print container.
            $('#grdMisView').printElement({ pageTitle: 'Litigation Views', overrideElementCSS:
                   [{ href: '../../Styles/print-grid.css', media: 'print'}]

            });
            //            $("#grdMisView").printElement({ pageTitle: 'Litigation Views', printBodyOptions: {
            //                styleToAdd: 'padding:10px;margin:10px;color:#FFFFFF !important;'
            //            }
            //            });
        }
        function PrintPdf() {
            var grdData = jQuery('#grdMisView').jqGrid('getGridParam', 'data');
            var printData = [];
            var ColHeader = ['Case Name', 'Type No', 'Forum', 'Vertical', 'Stages', 'Nature'];
            printData.push(ColHeader);
            $.each(grdData, function (i, data) {
                var RowData = []
                RowData.push(data.CaseName);
                RowData.push(data.SuitNum);
                RowData.push(data.Forum);
                RowData.push(data.Vertical);
                RowData.push(data.Stage);
                RowData.push(data.Nature);
                printData.push(RowData);
            });
            var docDefinition = {
//                header: 'ISS Reports',
                pageOrientation: 'landscape',
                content: [
                {
                    stack: ['ISS Reports',
				{ text: 'Litigation Views', margin: [0, 20], style: 'subheader' },
                ],
                    style: 'header'
                },
                {
                    style: 'tableExample',
                    table: {
                        body: printData
                    }
                }
                ]
            };
            //            pdfMake.createPdf(docDefinition).open();
            pdfMake.createPdf(docDefinition).print();
        }

    </script>
</body>
</html>
