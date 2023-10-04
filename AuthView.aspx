<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AuthView.aspx.cs" Inherits="AuthView" %>

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
    <form id="frmFirmview" runat="server" class="PPForm">
     <div>
      <div class="example" >
        <fieldset class="PPFieldset">
            <legend class="PPLegend"></legend>
            <div style="width: 100%; height: 405px">
                <div style="width: 560px; overflow: auto !important; height: 375px">                    
                    <table id="grdFirm" class="table"></table>
                    <div id="pager"></div>     
                </div>
                <div style="width: 100%;">
               
                <input id="btnOk" type="button" class="button success" value="New " onclick="New()" />
                <input id="btnDelete" type="button" class="button success" value="Delete "
                    onclick="DeleteFirm()" />
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
                    url: "AuthView.aspx/LoadData",
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
                jQuery("#grdFirm").jqGrid({
                    datatype: "local",
                    colNames: ['Name', 'Address', 'Email-Id', 'Mobile No', 'ID'],
                    colModel: [
                     { name: 'Name', index: 'Name', width: 100 },
                     { name: 'Address', index: 'Address', width: 200 },
                       { name: 'EmailId', index: 'EmailId', width: 100 },

                     { name: 'PhoneNumber', index: 'PhoneNumber', width: 80, align: "right" },
                      { name: 'PersonId', index: 'PersonId', width: 80, hidden: true, align: "right" }

               ],
                    multiselect: true,
                    rowNum: 10,
                    rowList: [5, 10, 20, 50, 100],
                    pager: jQuery('#pager'),
                    sortorder: "desc",
                    viewrecords: true,
                    caption: "Authorised Person Views",
                    height: 295,
                    ondblClickRow: function (rowId) {
                        var rowData = jQuery(this).getRowData(rowId);
                        var ClientId = rowData['PersonId'];
                        openClientDetail(ClientId);
                    }
                });

                //                for (var i = 0; i <= grdData.length; i++) {
                //                    jQuery("#grdFirm").jqGrid('addRowData', i + 1, grdData[i]);
                //                }
                jQuery("#grdFirm").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: grdData
                 }).trigger("reloadGrid");
            }
            function DeleteFirm() {
                if (jQuery('#grdFirm').jqGrid('getGridParam', 'selarrrow').length == 0) {
                    alert('Please select client to delete');
                    return false;
                }
                var RowIds = jQuery('#grdFirm').jqGrid('getGridParam', 'selarrrow');
                var ids = "";
                $.each(RowIds, function (i, data) {
                    var RowData = jQuery("#grdFirm").getRowData(this);
                    if (ids == "") {
                        ids = RowData.PersonId + "@";
                    }
                    else {
                        ids = ids + RowData.PersonId + "@";
                    }
                });
                $.ajax({
                    type: "POST",
                    url: "AuthView.aspx/DeleteData",
                    data: "{cIds :'" + ids + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        alert('deleted succesfully.');
                        UpdateGrid();
                    }
                });
            }

            function Closethis() {

                var btnClose = parent.parent.document.getElementById('btnDialogClose');
                btnClose.click();
            }

            function openClientDetail(Id) {
                var btnOpen = parent.document.getElementById('btnDialogOpen');
                btnOpen.title = "A8_Up_" + Id;
                btnOpen.click();
            }
            function UpdateGrid() {
                $.ajax({
                    type: "POST",
                    url: "AuthView.aspx/LoadData",
                    //                 data: "{cAdvocate :'" + JSON.stringify(cAdvocate) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != null) {
                            grdData = msg.d;
                            //                          $("#grdConct").jqGrid('GridUnload');
                            $("#grdFirm").jqGrid('clearGridData');
                            //                            for (var i = 0; i <= grdData.length; i++) {
                            //                                jQuery("#grdFirm").jqGrid('addRowData', i + 1, grdData[i]);
                            //                            }
                            jQuery("#grdFirm").jqGrid('setGridParam',
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
                btnOpen.title = "A8_New_";
                btnOpen.click();
            }
     </script>
</body>
</html>
