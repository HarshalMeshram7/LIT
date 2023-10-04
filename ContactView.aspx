<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactView.aspx.cs" Inherits="ContactView" %>

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
</head>
<body class="metro">
    <form id="frmContact" runat="server" class="PPForm">
    <div class="example">
        <fieldset class="PPFieldset">
            <legend class="PPLegend"></legend>
            <div style="width: 100%; height: 405px">
                <div style="width: 100%; overflow: auto; height: 375px">
                    <table id="grdConct" class="table">
                    </table>
                    <div id="pager">
                    </div>
                </div>
                <div style="width: 100%;">
                </div>
                <input id="btnOk" type="button" class="button success" value="New Contact" onclick="New()" />
                <input id="btnDelete" type="button" class="button success" value="Delete Contact"
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
            $.ajax({
                type: "POST",
                url: "ContactView.aspx/LoadData",
                //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        BindData(grdData);
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

        function BindData(grdData) {
            jQuery("#grdConct").jqGrid({
                datatype: "local",
                colNames: ['ConId', 'Name', 'Job Title', 'Company', 'Email', 'mobile'],
                colModel: [
                     { name: 'ConId', index: 'ConId', hidden: true, width: 100 },
                     { name: 'Name', index: 'Name', width: 100 },
                     { name: 'Job', index: 'Job', width: 100 },

                     { name: 'Company', index: 'Company', width: 100 },
                     { name: 'Email', index: 'Email', width: 90 },
                     { name: 'Phone', index: 'Phone', width: 80, align: "right" }
               ],
                multiselect: true,
                rowNum: 10,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                viewrecords: true,
                height: 295,
                caption: "All Contacts",
                ondblClickRow: function (rowId) {
                    var rowData = jQuery(this).getRowData(rowId);
                    var AdvId = rowData['ConId'];
                    openAdvDetail(AdvId);
                }
            });
            //              for (var i = 0; i <= grdData.length; i++) {
            //                  jQuery("#grdConct").jqGrid('addRowData', i + 1, grdData[i]);
            //              }
            jQuery("#grdConct").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
        }
        function New() {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "aContact"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId
            btnOpen.click();
        }
        function Delete() {
            var RowId = jQuery('#grdConct').jqGrid('getGridParam', 'selarrrow')[0];
            var RowData = jQuery("#grdConct").getRowData(RowId);
            var AdvId = RowData.ConId;
        }
        function Closethis() {

            var btnClose = parent.parent.document.getElementById('btnDialogClose');
            btnClose.click();
        }
        function openAdvDetail(Id) {
            var btnOpen = parent.document.getElementById('btnDialogOpen');
            btnOpen.title = "aContact_Up_" + Id;
            btnOpen.click();
        }
        function DeleteAdvocate() {
            if (jQuery('#grdConct').jqGrid('getGridParam', 'selarrrow').length == 0) {
                alert('Please select Contact to delete');
                return false;
            }
            var RowIds = jQuery('#grdConct').jqGrid('getGridParam', 'selarrrow');
            var ids = "";
            $.each(RowIds, function (i, data) {
                var RowData = jQuery("#grdConct").getRowData(this);
                if (ids == "") {
                    ids = RowData.ConId + "@";
                }
                else {
                    ids = ids + RowData.ConId + "@";
                }
            });
            $.ajax({
                type: "POST",
                url: "ContactView.aspx/DeleteData",
                data: "{cIds :'" + ids + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    alert('deleted succesfully.');
                    //                      var gr = jQuery("#grdConct").jqGrid('getGridParam', 'selrow');
                    //                      if (gr != null) jQuery("#grdConct").jqGrid('delRowData', gr);
                    UpdateGrid();
                }
            });
        }

        function UpdateGrid() {
            $.ajax({
                type: "POST",
                url: "ContactView.aspx/LoadData",
                //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != null) {
                        grdData = msg.d;
                        //                          $("#grdConct").jqGrid('GridUnload');
                        $("#grdConct").jqGrid('clearGridData');
                        //                          for (var i = 0; i <= grdData.length; i++) {
                        //                              jQuery("#grdConct").jqGrid('addRowData', i + 1, grdData[i]);
                        //                          }
                        jQuery("#grdConct").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
                    }
                }
            });

        }
    </script>
</body>
</html>
