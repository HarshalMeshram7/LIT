<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvocateView.aspx.cs" Inherits="Styles_AdvocateView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="Styles/redmond/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Js/grid.locale-en.js" type="text/javascript"></script>
    <script src="Js/jquery.jqGrid.src.js" type="text/javascript"></script>
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
        }
        .Row
        {
            color: Black;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            text-shadow: none;
            line-height: 16px;
        }
    </style>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend"></legend>
            <div style="width: 100%; height: 405px">
                <div style="width: 100%; overflow: auto; height: 375px">
                    <%-- <asp:GridView runat="server" ID="grdAdvocate" SelectedRowStyle-CssClass="Selected"
                        CssClass="table  wijgrid" DataKeyNames="wAdvId" RowStyle-CssClass="Row" HeaderStyle-CssClass="headertext"
                        AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="sAdvFName" HeaderText="First Name" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="sAdvLName" HeaderText="Last Name" />
                            <asp:BoundField DataField="sAddress" HeaderText="Address" />
                            <asp:BoundField DataField="sCity" HeaderText="City" />
                            <asp:BoundField DataField="sState" HeaderText="State" />
                            <asp:BoundField DataField="sEmail" HeaderText="Email" />
                        </Columns>
                    </asp:GridView>--%>
                    <table id="grdAdv" class="table">
                    </table>
                    <div id="pager">
                    </div>
                </div>
                <div style="width: 100%;">
                </div>
                <input id="btnOk" type="button" class="button success" value="New Advocate" onclick="New()" />
                <input id="btnDelete" type="button" class="button success" value="Delete Advocate"
                    onclick="DeleteAdvocate()" />
                <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                <input id="btnUpdate" type="button" class="button success" style="display: none"
                    value="none" onclick="UpdateGrid()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
         var grdData;
         $(document).ready(function () {
             setAdminLevel();
             ISViews();
             $.ajax({
                 type: "POST",
                 url: "AdvocateView.aspx/LoadData",
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
             jQuery("#grdAdv").jqGrid({
                 datatype: "local",
                 colNames: ['AdvId','Name', 'firm Name', 'E-mail','City', 'State', 'mobile'],
                 colModel: [
                     { name: 'AdvocateId', index: 'AdvocateId',hidden: true, width: 100 },
                     { name: 'AdvName', index: 'AdvName', width: 100 },
                     { name: 'FirmName', index: 'FirmName', width: 100 },
                      { name: 'EmailId', index: 'EmailId', width: 100 },
                     { name: 'City', index: 'City', width: 100 },
                     { name: 'State', index: 'State', width: 90 },
                     { name: 'mobile', index: 'mobile', width: 80, align: "right" }
               ],
                 multiselect: true,
                 rowNum: 10,
                 rowList: [5, 10, 20, 50, 100],
                 pager: jQuery('#pager'),
                 sortorder: "desc",
                  gridview: true,
                rownumbers: true,
                viewrecords: true,
                height: 295,
                 width:580,
                 caption: "Advocate Views",
                 ondblClickRow: function (rowId) {
                     var rowData = jQuery(this).getRowData(rowId);
                     var AdvId = rowData['AdvocateId'];
                     openAdvDetail(AdvId);
                 }
             });
//             for (var i = 0; i <= grdData.length; i++) {
//                 jQuery("#grdAdv").jqGrid('addRowData', i + 1, grdData[i]);
//             }
             jQuery("#grdAdv").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");

        
         }
         function New() {
             var RowId = jQuery('#grdAdv').jqGrid('getGridParam', 'selarrrow')[0];
             var RowData = jQuery("#grdAdv").getRowData(RowId);
             var AdvId = RowData.AdvocateId;
         }
         function Delete() {
             var RowId = jQuery('#grdAdv').jqGrid('getGridParam', 'selarrrow')[0];
             var RowData = jQuery("#grdAdv").getRowData(RowId); 
             var AdvId = RowData.AdvocateId;
         }
         function Closethis() {

             var btnClose = parent.parent.document.getElementById('btnDialogClose');
             btnClose.click();
         }
         function openAdvDetail(Id) {
             var btnOpen = parent.document.getElementById('btnDialogOpen');
             btnOpen.title = "a2_Up_" + Id;
             btnOpen.click();
         }
         function DeleteAdvocate() {
             if (jQuery('#grdAdv').jqGrid('getGridParam', 'selarrrow').length == 0) {
                 alert('Please select Advocate to delete');
                 return false;
             }
             var RowIds = jQuery('#grdAdv').jqGrid('getGridParam', 'selarrrow');
             var ids = "";
             $.each(RowIds, function (i, data) {
                 var RowData = jQuery("#grdAdv").getRowData(this);
                 if (ids == "") {
                     ids = RowData.AdvocateId + "@";
                 }
                 else {
                     ids = ids + RowData.AdvocateId + "@";
                 }
             });
             $.ajax({
                 type: "POST",
                 url: "AdvocateView.aspx/DeleteData",
                 data: "{cIds :'" + ids + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (msg) {
                     alert('deleted succesfully.');
                     UpdateGrid();
                 }
             });
         }
         function UpdateGrid() {
             $.ajax({
                 type: "POST",
                 url: "AdvocateView.aspx/LoadData",
                 //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (msg) {
                     if (msg.d != null) {
                         grdData = msg.d;
                         //                          $("#grdConct").jqGrid('GridUnload');
                         $("#grdAdv").jqGrid('clearGridData');
//                         for (var i = 0; i <= grdData.length; i++) {
//                             jQuery("#grdAdv").jqGrid('addRowData', i + 1, grdData[i]);
//                         }
                         jQuery("#grdAdv").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
                     }
                 }
             });

         }
         function New() {
             var btnOpen = parent.document.getElementById('btnDialogOpen');
             btnOpen.title = "a2_New_" ;
             btnOpen.click();
         }
    </script>
</body>
</html>
