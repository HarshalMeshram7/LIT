<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientView.aspx.cs" Inherits="ClientView" %>

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
    </style>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div>
        <div class="example">
            <fieldset class="PPFieldset">
                <legend class="PPLegend"></legend>
                <div style="width: 100%; height: 405px">
                    <div style="width: 570px; overflow: auto !important; height: 375px">
                        <%--<asp:GridView runat="server" ID="grdClient" SelectedRowStyle-CssClass="Selected"
                        CssClass="table  wijgrid"  RowStyle-CssClass="Row" HeaderStyle-CssClass="headertext"
                        AutoGenerateColumns="true">
                        <Columns>
                            <asp:BoundField DataField="sAdvFName" HeaderText="First Name" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="sAdvLName" HeaderText="Last Name" />
                            <asp:BoundField DataField="sAddress" HeaderText="Address" />
                            <asp:BoundField DataField="sCity" HeaderText="City" />
                            <asp:BoundField DataField="sState" HeaderText="State" />
                            <asp:BoundField DataField="sEmail" HeaderText="Email" />
                        </Columns>
                    </asp:GridView>--%>
                        <table id="grdClient" class="table">
                        </table>
                        <div id="pager">
                        </div>
                    </div>
                    <div style="width: 100%;">
                        <input id="btnOk" type="button" class="button success" value="New Client" onclick="New()" />
                        <input id="btnDelete" type="button" class="button success" value="Delete Client"
                            onclick="DeleteClient()" />
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
            setAdminLevel();
            ISViews();
            $.ajax({
                type: "POST",
                url: "ClientView.aspx/LoadData",
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
            jQuery("#grdClient").jqGrid({
                datatype: "local",
                colNames: ['Name', 'Address', 'City', 'State', 'Mobile No','Vertical', 'ID'],
                colModel: [
                     { name: 'ClientName', index: 'ClientName', width: 100 },
                     { name: 'Address', index: 'Address', width: 100 },
                       { name: 'City', index: 'City', width: 70 },
                     { name: 'State', index: 'State', width: 80 },

                     { name: 'Mobile', index: 'Mobile', width: 80, align: "left" },
                      { name: 'Vertical', index: 'Vertical', width: 50 },
                      { name: 'ClientId', index: 'ClientId', width: 80, hidden: true, align: "right" }

               ],
                multiselect: true,
                rowNum: 10,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                gridview: true,
                rownumbers: true,
                viewrecords: true,
                caption: "Client Views",
                height: 295,
                ondblClickRow: function (rowId) {
                    var rowData = jQuery(this).getRowData(rowId);
                    var ClientId = rowData['ClientId'];
                    openClientDetail(ClientId);
                }
            });

            //                for (var i = 0; i <= grdData.length; i++) {
            //                    jQuery("#grdClient").jqGrid('addRowData', i + 1, grdData[i]);
            //                }
            jQuery("#grdClient").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");

        }
        function DeleteClient() {
            if (jQuery('#grdClient').jqGrid('getGridParam', 'selarrrow').length == 0) {
                alert('Please select client to delete');
                return false;
            }
            var RowIds = jQuery('#grdClient').jqGrid('getGridParam', 'selarrrow');
            var ids = "";
            $.each(RowIds, function (i, data) {
                var RowData = jQuery("#grdClient").getRowData(this);
                if (ids == "") {
                    ids = RowData.ClientId + "@";
                }
                else {
                    ids = ids + RowData.ClientId + "@";
                }
            });
            $.ajax({
                type: "POST",
                url: "ClientView.aspx/DeleteData",
                data: "{cIds :'" + ids + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    alert('deleted succesfully.');
                    //                    UpdateGrid();
                    $.each(jQuery("#grdClient").jqGrid('getGridParam', 'selarrrow'),function (index, value) {
                        jQuery("#grdClient").jqGrid('delRowData', this);
                    });
                }
            });
        }

        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }

        function openClientDetail(Id) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "a3_Up_" + Id;
            btnOpen.click();
        }
        function UpdateGrid() {
            $.ajax({
                type: "POST",
                url: "ClientView.aspx/LoadData",
                //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        //                          $("#grdConct").jqGrid('GridUnload');
                        $("#grdClient").jqGrid('clearGridData');
                        //                        for (var i = 0; i <= grdData.length; i++) {
                        //                            jQuery("#grdClient").jqGrid('addRowData', i + 1, grdData[i]);
                        //                        }
                        jQuery("#grdClient").jqGrid('setGridParam',
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
            btnOpen.title = "a3_New_";
            btnOpen.click();
        }
    </script>
</body>
</html>
