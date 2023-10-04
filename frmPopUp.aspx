<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmPopUp.aspx.cs" Inherits="frmPopUp" %>

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
        .ui-jqgrid .ui-jqgrid-bdiv
        {
            position: relative;
            margin: 0;
            padding: 0;
            overflow: auto;
            text-align: left;
        }
    </style>
</head>
<body class="metro">
    <form id="form1" runat="server" class="PPForm">
    <div class="example" style="width: 100%;">
        <div style="overflow: auto !important; height: 435px">
            <table id="grdPopUp">
            </table>
            <div id="pager">
            </div>
        </div>
        <div style="width: 100%;">
            <input id="btnOk" type="button" class="button success" value="Select" onclick="Selected()" />
            <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
        </div>
    </div>
    </form>
    <script type="text/javascript">
        var client;
        var PageParam;
        $(document).ready(function () {
            //                        alert('hi');
            //            $("#tabs").metro - tabcontrol();
            client = GetQueryStringParams('Param');
            PageParam = client.split('_');
            var data = [];
            $.ajax({
                type: "POST",
                url: "frmPopUp.aspx/GetData",
                data: "{BindId :'" + PageParam[1] + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (msg) {
                    data = msg.d;
                    if (PageParam[1] == "Client") {
                        BindClientData(data);
                    }
                    else if (PageParam[1] == "Advocate") {
                        BindAdvData(data);
                    }
                    else if (PageParam[1] == "Firm") {
                        BindFirmData(data);
                    }
                    else if (PageParam[1] == "AuthPer") {
                        BindAuthData(data);
                    }
                    else {
                        BindConData(data);
                    }
                    jQuery("#grdPopUp").jqGrid('setGridParam',
                 {
                     datatype: 'local',
                     data: data
                 }).trigger("reloadGrid");
                }
            });
            $('.ui-jqgrid-bdiv').height(350);
        });
        function BindClientData(Data) {
            jQuery("#grdPopUp").jqGrid({
                datatype: "local",
                colNames: ['Client Id', 'Name', 'Address', 'City', 'State', 'Mobile No','Vertical'],
                colModel: [
                { name: 'ClientId', index: 'ClientId', width: 50,hidden:true },
                     { name: 'ClientName', index: 'ClientId', width: 90 },
                     { name: 'Address', index: 'Address', width: 100 },
                       { name: 'City', index: 'City', width: 70 },
                     { name: 'State', index: 'State', width: 80 },

                     { name: 'Mobile', index: 'Mobile', width: 80, align: "right" },
                     { name: 'Vertical', index: 'Vertical', width: 50 },
               ],
                multiselect: true,
                rowNum: 10,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
               sortorder: "desc",
                gridview: true,
                rownumbers: true,
                viewrecords: true,               
                 caption: "Client Views"
            });
//            for (var i = 0; i <= Data.length; i++) {
//                jQuery("#grdPopUp").jqGrid('addRowData', i + 1, Data[i]);
//            }
//            jQuery("#grdPopUp").jqGrid('setGridParam',
//                 {
//                     datatype: 'local',
//                     data: Data
//                 }).trigger("reloadGrid");
        }
        function BindAdvData(Data) {
            jQuery("#grdPopUp").jqGrid({
                datatype: "local",
                colNames: ['Advocate Id','FirmId', 'Name', 'City', 'State', 'mobile'],
                colModel: [
                
                     { name: 'AdvocateId', index: 'AdvocateId', width: 50 ,hidden:true},
                     { name: 'FirmId', index: 'FirmId', width: 50 },
                     { name: 'AdvName', index: 'AdvName', width: 100 },                   
                     
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
                caption: "Advocate Views"
            });
//            for (var i = 0; i <= Data.length; i++) {
//                jQuery("#grdPopUp").jqGrid('addRowData', i + 1, Data[i]);
//            }
//            jQuery("#grdPopUp").jqGrid('setGridParam',
//                 {
//                     datatype: 'local',
//                     data: Data
//                 }).trigger("reloadGrid");
        }
        function BindAuthData(Data) {
            jQuery("#grdPopUp").jqGrid({
                datatype: "local",
                colNames: ['Id', 'Name', 'Email', 'mobile'],
                colModel: [

                     { name: 'PersonId', index: 'PersonId', width: 50, },
                     { name: 'Name', index: 'Name', width: 100 },
                     { name: 'EmailId', index: 'EmailId', width: 90 },
                     { name: 'PhoneNumber', index: 'PhoneNumber', width: 80, align: "right" }

               ],
                multiselect: true,
                rowNum: 10,
                rowList: [5, 10, 20, 50, 100],
                pager: jQuery('#pager'),
                sortorder: "desc",
                gridview: true,
                rownumbers: true,
                viewrecords: true,
                caption: "Authorised Person Views"
            });
//            for (var i = 0; i <= Data.length; i++) {
//                jQuery("#grdPopUp").jqGrid('addRowData', i + 1, Data[i]);
//            }
        }
        function BindFirmData(Data) {
            jQuery("#grdPopUp").jqGrid({
                datatype: "local",
                colNames: ['Firm Id', 'Firm Name', 'City', 'State', 'mobile'],
                colModel: [

                     { name: 'FirmId', index: 'FirmId', width: 50 },
                     { name: 'FirmName', index: 'FirmName', width: 100 },


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
                caption: "Firm Views"
            });
//            for (var i = 0; i <= Data.length; i++) {
//                jQuery("#grdPopUp").jqGrid('addRowData', i + 1, Data[i]);
//            }
        }

        function BindConData(Data) {
            jQuery("#grdPopUp").jqGrid({
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
                 gridview: true,
                rownumbers: true,
                viewrecords: true,
                caption: "Contact Views"
            });
//            for (var i = 0; i <= Data.length; i++) {
//                jQuery("#grdPopUp").jqGrid('addRowData', i + 1, Data[i]);
//            }
        }
        function Selected() {
            if (PageParam[1] == "Client") {
                if (PageParam[2] == "MisData") {
                    var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                    var returnValue = "";
                    var RowData = jQuery("#grdPopUp").getRowData(selRows);
                    returnValue = RowData.ClientId;
                     if (PageParam[3] == "1") {

                        var cntrlId = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtClientId1');
                        var cntrlDesc = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtClient1');
                    }
                    else {

                        var cntrlId = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtClientId2');
                        var cntrlDesc = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtClient2');
                        var cntrVertical= $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtcVertical');
                        $(cntrVertical)[0].value = RowData.Vertical;
                    }
                   
                    $(cntrlId)[0].value = returnValue;
                    returnValue = RowData.ClientName;
                    $(cntrlDesc)[0].value = returnValue;
                }
                else if (PageParam[2] == "EditView") {
                    var cntrlID = $(parent.document).find('#EditView').find('#iHold').contents().find('#txtClientId');
                    var cntrlDesc = $(parent.document).find('#EditView').find('#iHold').contents().find('#txtlient');
                    var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                    var returnValue = "";
                    var RowData = jQuery("#grdPopUp").getRowData(selRows);
                    $(cntrlID)[0].value = RowData.ClientId;
                    $(cntrlDesc)[0].value = RowData.ClientName;
                }
            }
            else if (PageParam[1] == "Advocate") {
                if (PageParam[2] == "EditView") {
                    var cntrlID = $(parent.document).find('#EditView').find('#iHold').contents().find('#txtAdvId');
                    var cntrlDesc = $(parent.document).find('#EditView').find('#iHold').contents().find('#txtAdv');
                    var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                    var returnValue = "";
                    var RowData = jQuery("#grdPopUp").getRowData(selRows);
                    $(cntrlID)[0].value = RowData.AdvocateId;
                    $(cntrlDesc)[0].value = RowData.AdvName;

                }
                else {
                    var cntrlID = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtAdvId');
                    var cntrlDesc = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtAdvDesc');
                    var cntrlFirmID = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtFirmId');

                    var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                    var returnValue = "";
                    var RowData = jQuery("#grdPopUp").getRowData(selRows);
                    $(cntrlID)[0].value = RowData.AdvocateId;
                    $(cntrlDesc)[0].value = RowData.AdvName;
                    $(cntrlFirmID)[0].value = RowData.FirmId;
                }
            }
            else if (PageParam[1] == "Cotacts")  {
                var cntrlID = $(parent.document).find('#Email').find('#iHold').contents().find('#'+PageParam[2]);
                var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                var returnValue = "";
                var RowData = jQuery("#grdPopUp").getRowData(selRows);
                $(cntrlID)[0].value = RowData.Email;
            }
            else if (PageParam[1] == "Firm") {
                var cntrlID = $(parent.document).find('#NewAdvocate').find('#iHold').contents().find('#txtFirmId');
                var cntrlDesc = $(parent.document).find('#NewAdvocate').find('#iHold').contents().find('#txtFirm');

                var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                var returnValue = "";
                var RowData = jQuery("#grdPopUp").getRowData(selRows);
                $(cntrlID)[0].value = RowData.FirmId;
                $(cntrlDesc)[0].value = RowData.FirmName;
            }
            else if (PageParam[1] == "AuthPer") {
                var cntrlID = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtAuthId');
                var cntrlDesc = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtAutPerson');
                var cntrlEmail = $(parent.document).find('#MisDetails').find('#iHold').contents().find('#txtAutEmail');

                var selRows = jQuery('#grdPopUp').jqGrid('getGridParam', 'selarrrow')[0];
                var returnValue = "";
                var RowData = jQuery("#grdPopUp").getRowData(selRows);
                $(cntrlID)[0].value = RowData.PersonId;
                $(cntrlDesc)[0].value = RowData.Name;
                $(cntrlEmail)[0].value = RowData.EmailId;

            }
            Closethis();
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

        function Closethis() {
            
                var btnClose = parent.parent.document.getElementById('btnDialogClose');                
                btnClose.click();           
        }
    </script>
</body>
</html>
