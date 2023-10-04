var bProvision = false;
var PageParam;
$(document).ready(function () {
    setAdminLevel();
    $("input[type=text]").keypress(function () {
        if (event.keyCode == 39) {
            event.keyCode = 0;
            return false;
        }
    });

    if (GetQueryStringParams('MISId').trim() != "") {
        PageParam = GetQueryStringParams('MISId').split('_');
        if (PageParam[1] == 'Up') {
            $("li[value=1]").css("visibility", "visible");
            BindAllFeilds(PageParam[2]);
            $("#btnOk")[0].value = "Update";
        }
        else {
            BidClients(null);
            BidHDetails(null);
            BidDocs(null);
        }
    }
    else {
        BidClients(null);
        BidHDetails(null);
        BidDocs(null);
    }
    setInterval(function () {
        if ($("#btnOk")[0].value == "Update") {
            isAuto = true;
            $("#lblSave").css('visibility', 'visible')
            $("#lblSave").text('Saving');
            AutoSave();
            isAuto = false;
            setTimeout(function () {
                $("#lblSave").css('visibility', 'hidden');
            }, 10000);
        }
    }, 120000);
});
var isAuto = false;
function AutoSave() {
    var SaveDoc = false;
    var sBriefFacts = $find("EdtBrf").get_content().toString().replace(/'/g, '#11aqw');;
    //        var sStatus = $find("EdtStatus").get_content().toString();
    var sRiskWorst = $find("EdtRisk").get_content().toString().replace(/'/g, '#11aqw');;
    var sRiskFav = $find("EditRiskFav").get_content().toString().replace(/'/g, '#11aqw');;

    //        var sLawItem = $find("EditLawItem").get_content().toString();
    var sAdv = $("#txtAdvId").val();
    var SuitNo = "";
    var Forum = "";
    var CaseName = "";
    var sClients = jQuery("#grdClients").jqGrid('getGridParam', 'data');
    var sStatus = jQuery("#grdHDetails").jqGrid('getGridParam', 'data');

    if ($('#ddlStages :selected').val() > 1) {
        //            sAdv = $("#txtAdvId").val();
        SuitNo = $("#txtSuitNo").val();
        Forum = $("#txtForum").val();
        CaseName = $("#txtCaseNAme").val();

    }
    var ids = -1;
    if (GetQueryStringParams('MISId').trim() != "") {
        ids = PageParam[2];
    }
    bProvision = $("#txtfinProv")[0].checked;
    var oMIS = { Stages: $("#ddlStages").val(), SuitNo: $("#txtSuitNo").val(), Forum: $("#txtForum").val(),
        //            Client1: $("#ddlClient1 :selected").val() + '@' + $("#txtClientId1").val(),
        //            Client2: $("#ddlClient2 :selected").val() + '@' + $("#txtClientId2").val(),
        AdvId: sAdv, FirmId: $("#txtFirmId").val(), Adv: $("#txtAdvDesc").val(),
        Nature: $("#txtNature :selected").val(), Vertical: $("#txtVertical").val(),
        FinanProv: bProvision, Amount: $("#txtAmountPay").val(), AmountRecv: $("#txtAmtRecv").val(),
        Reason: $("#txtReason").val(), CaseName: $("#txtCaseNAme").val(),
        LawName: $("#txtLawName").val(), lawYear: $("#txtLawYear").val(),
        HDate: $("#txtHDate").val(), AdvFees: $("#txtAdvFees").val(), ClaimAmt: $("#txtClaim").val(),
        AutPerson: $("#txtAutPerson").val(), AutEmail: $("#txtAutEmail").val(), AutPersonId: $("#txtAuthId").val(),
        StartDate: $("#txtStartDate").val(), CloseDate: $("#txtCloseDate").val(), ClientCtg: $("#txtClientCatg").val(),
        sType: $('#ddlType').val(),
        ID: ids, ActId: $("#hdnActId").val()
    };
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/UpdateMISDetails",
        data: "{cMIS :'" + JSON.stringify(oMIS) + "',sBriefFacts :'" + sBriefFacts + "',sStatus:'" + JSON.stringify(sStatus).replace(/'/g, '#11aqw') + "',sRisk:'" + sRiskWorst + "',sRiskFav:'" + sRiskFav + "',sCLients:'" + JSON.stringify(sClients) + "',sSaveDoc:'" + SaveDoc + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            //                         if (!isAuto)
            if (msg.d == "Session") {
                sessionExpired();
            }

        }
    });
}
function setAdminLevel() {
    var wAdmin = parent.document.getElementById('hdnAdminLevel').value;
    if (wAdmin == '0') {
        //        swal({ title: 'Only Admin-access user can save and edit data!', type: "info", timer: 5000 });
        $("#btnOk")[0].disabled = "disabled";
        $("#btnDeleteDoc")[0].disabled = "disabled";
        $("#btnDelete")[0].disabled = "disabled";

    }
}

function SaveClient() {
    if (validate()) {
        //      var r = confirm("Do you want to save as Pdf document ?");
        var SaveDoc = false;

        swal({ title: "Do you want to save as Pdf document ?", text: "",
            type: "info", showCancelButton: true, confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, save it!", closeOnConfirm: false
        },
         function (isConfirm) {
             SaveDoc = isConfirm;
             var sBriefFacts = $find("EdtBrf").get_content().toString().replace(/'/g, '#11aqw');;
             //        var sStatus = $find("EdtStatus").get_content().toString();
             var sRiskWorst = $find("EdtRisk").get_content().toString().replace(/'/g, '#11aqw');;
             var sRiskFav = $find("EditRiskFav").get_content().toString().replace(/'/g, '#11aqw');;

             //        var sLawItem = $find("EditLawItem").get_content().toString();
             var sAdv = $("#txtAdvId").val();
             var SuitNo = "";
             var Forum = "";
             var CaseName = "";
             var sClients = jQuery("#grdClients").jqGrid('getGridParam', 'data');
             var sStatus = jQuery("#grdHDetails").jqGrid('getGridParam', 'data');

             if ($('#ddlStages :selected').val() > 1) {
                 //            sAdv = $("#txtAdvId").val();
                 SuitNo = $("#txtSuitNo").val();
                 Forum = $("#txtForum").val();
                 CaseName = $("#txtCaseNAme").val();

             }
             var ids = -1;
             if (GetQueryStringParams('MISId').trim() != "") {
                 ids = PageParam[2];
             }
             bProvision = $("#txtfinProv")[0].checked;
             var oMIS = { Stages: $("#ddlStages").val(), SuitNo: $("#txtSuitNo").val(), Forum: $("#txtForum").val(),
                 //            Client1: $("#ddlClient1 :selected").val() + '@' + $("#txtClientId1").val(),
                 //            Client2: $("#ddlClient2 :selected").val() + '@' + $("#txtClientId2").val(),
                 AdvId: sAdv, FirmId: $("#txtFirmId").val(), Adv: $("#txtAdvDesc").val(),
                 Nature: $("#txtNature :selected").val(), Vertical: $("#txtVertical").val(),
                 FinanProv: bProvision, Amount: $("#txtAmountPay").val(), AmountRecv: $("#txtAmtRecv").val(),
                 Reason: $("#txtReason").val(), CaseName: $("#txtCaseNAme").val(),
                 LawName: $("#txtLawName").val(), lawYear: $("#txtLawYear").val(),
                 HDate: $("#txtHDate").val(), AdvFees: $("#txtAdvFees").val(), ClaimAmt: $("#txtClaim").val(),
                 AutPerson: $("#txtAutPerson").val(), AutEmail: $("#txtAutEmail").val(), AutPersonId: $("#txtAuthId").val(),
                 StartDate: $("#txtStartDate").val(), CloseDate: $("#txtCloseDate").val(), ClientCtg: $("#txtClientCatg").val(),
                 sType: $('#ddlType').val(),
                 ID: ids, ActId: $("#hdnActId").val()
             };
             if ($("#btnOk")[0].value != "Update") {
                 $.ajax({
                     type: "POST",
                     url: "MisDetails.aspx/SaveMISDetails",
                     data: "{cMIS :'" + JSON.stringify(oMIS) + "',sBriefFacts :'" + sBriefFacts + "',sStatus:'" + JSON.stringify(sStatus).replace(/'/g, '#11aqw') + "',sRisk:'" + sRiskWorst + "',sRiskFav:'" + sRiskFav + "',sCLients:'" + JSON.stringify(sClients) + "',sSaveDoc:'" + SaveDoc + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {
                         if (msg.d == "Session") {
                             sessionExpired();
                         }
                         else if (msg.d == "Done") {
                             swal({ title: 'saved succesfully!', type: "success" },
                                     function () {
                                         Closethis();
                                     });
                         }
                         else {
                             swal({ title: msg.d, type: "error", timer: 3000 });
                         }
                     }
                 });
             }
             else {
                 $.ajax({
                     type: "POST",
                     url: "MisDetails.aspx/UpdateMISDetails",
                     data: "{cMIS :'" + JSON.stringify(oMIS) + "',sBriefFacts :'" + sBriefFacts + "',sStatus:'" + JSON.stringify(sStatus).replace(/'/g, '#11aqw') + "',sRisk:'" + sRiskWorst + "',sRiskFav:'" + sRiskFav + "',sCLients:'" + JSON.stringify(sClients) + "',sSaveDoc:'" + SaveDoc + "'}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (msg) {
                         if (msg.d == "Session") {
                             sessionExpired();
                         }
                         else if (msg.d == "Done") {
                             swal({ title: 'Updated succesfully!', type: "success", timer: 5000 });
                             UpdateDocs();
                         }
                         else {
                             swal({ title: msg.d, type: "error", timer: 3000 });
                         }
                     }
                 });
             }
         });
        //        if (r == true) {
        //            SaveDoc = true;
        //        }

    }

}

function validate() {
    //    if ($("#txtSuitNo").val() == "") {
    //        alert('Please enter Suit No.!');
    //        return false;
    //    }
    if ($('#ddlStages :selected').val() > 1) {
        //        if ($("#txtSuitNo").val() == "") {
        //            alert('Please enter Suit Number!');
        //            return false;
        //        }
        if ($("#txtCaseNAme").val() == "") {
            swal({ title: 'Please enter Case Name!', type: "info", timer: 5000 });
            return false;
        }
        //        if ($("#txtForum").val() == "") {
        //            alert('Please enter Forum!');
        //            return false;
        //        }
    }
    if ($("#txtNature").val() == "") {
        swal({ title: 'Please enter Nature of Case!', type: "info", timer: 5000 });
        return false;
    }
    if ($("#txtVertical").val() == "") {
        swal({ title: 'Please enter Vertical!', type: "info", timer: 5000 });
        return false;
    }
    //    if ($("#txtRules").val() == "") {
    //        alert('Please enter Law/Acts/ Rules!');
    //        return false;
    //    }

    //   // if ($("#txtLawName").val() == "") {
    //    //    alert('Please enter Law/Acts/ Rules Names!');
    //      //  return false;
    //    }
    //    if ($("#txtLawYear").val() == "") {
    //        alert('Please enter Law Year!');
    //        return false;
    //    }
    //    if ($("#txtfinProv")[0].checked) {
    //        if ($("#txtAmount").val() == "") {
    //            alert('Please enter Amount!');
    //            return false;
    //        }
    //    }
    //    if ($("#txtAdvId")[0].value == "") {       
    //            alert('Please enter Advocate Details!');
    //            return false;       
    //    }

    //    if ($find("EdtBrf").get_content() == "") {
    //        alert('Please enter Brief Facts!');
    //        return false;
    //    }
    //    if ($find("EdtRisk").get_content() == "") {
    //        alert('Please enter Risk Factors!');
    //        return false;
    //    }
    //    if ($find("EditRiskFav").get_content() == "") {
    //        alert('Please enter Risk Factors favourable!');
    //            return false;
    //        }
    //    if ($find("EdtStatus").get_content() == "") {
    //        alert('Please enter Present Status!');
    //        return false;
    //    }
    //Validate Clients
    //    if ($("#grdClielnts tr").length == 1) {
    //        alert('Please Enter Client!');
    //        return false;
    //    }
    //    else if ($("#grdClients tr").length == 2) {
    //        alert('Minimum 2 Client is required!');
    //        return false;
    //    }
    return true;
}
function onClientChange() {
    var Clientdata = $('#grdClients').jqGrid('getGridParam', 'data');
    var Client1 = '0';
    var Client2 = '0';
    var ClientTypeId = '0';
    var ClientType = 'none';
    var ClientTypeId2 = '0';
    var ClientType2 = 'none';
    $.each(Clientdata, function (i, data) {
        if (data.ClientVs == 1) {
            Client1 = data.ClientVs;
            ClientTypeId = data.ClientTypeId;
            ClientType = data.ClientType;
        }
        else {
            Client2 = data.ClientVs;
            ClientTypeId2 = data.ClientTypeId;
            ClientType2 = data.ClientType;
        }
    });
    if ($("#ddlClient")[0].value == '1') {
        if (Client1 != '0') {
            if ($("#ddlClientType")[0].value != ClientTypeId) {
                $("#ddlClientType")[0].value = ClientTypeId;
                swal({ title: 'Client Type allowed is :' + ClientType, type: "info", timer: 5000 });
            }
        }
        else if ($("#ddlClientType")[0].value == ClientTypeId2) {
            //            $("#ddlClientType")[0].value = ClientTypeId;
            swal({ title: 'Client1 Type and Client2 Type cannot be same ', type: "info", timer: 5000 });
            return false;
        }
    }
    else {
        if (Client2 != '0') {
            if ($("#ddlClientType")[0].value != ClientTypeId2) {
                $("#ddlClientType")[0].value = ClientTypeId2;
                swal({ title: 'Client Type allowed is :' + ClientType2, type: "info", timer: 5000 });
            }
        }
        else if ($("#ddlClientType")[0].value == ClientTypeId) {
            //            $("#ddlClientType")[0].value = ClientTypeId;
            swal({ title: 'Client1 Type and Client2 Type cannot be same', type: "info", timer: 5000 });
            return false;
        }
    }
}
function DisableAccnt(id) {
    if (id.checked == true) {
        $("#divAmountPR")[0].style.display = "";
        //        $("#divAmountR")[0].style.display = "";
        $("#divReason")[0].style.display = "none";
        bProvision = true;
    }
    else {
        $("#divAmountPR")[0].style.display = "none";
        //        $("#divAmountR")[0].style.display = "none !important";
        $("#divReason")[0].style.display = "";
        bProvision = false;
    }
}

function onStageChange() {
    //As per discussion on 30-07-14
    if ($('#ddlStages :selected').val() > 1) {
        //        $("#divAdv")[0].style.display = "";
        //        $("#divPreLit")[0].style.visibility = "visible";
    }
    else {
        //        $("#divAdv")[0].style.display = "none";
        //        $("#divPreLit")[0].style.visibility = "hidden";
    }
}
function OpenDialog(id) {
    var btnOpen = parent.document.getElementById('btnDialogOpen');
    switch (id.id) {
        case "btnClient2":
            btnOpen.title = "PopUp_Client_MisData_2"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId
            break;
        case "btnClient1":
            btnOpen.title = "PopUp_Client_MisData_1";
            break;
        case "btnAdvcate":
            btnOpen.title = "PopUp_Advocate_MisData";
            break;
        case "btnAutPrsn":
            btnOpen.title = "PopUp_AuthPer_MisData";
            break;
        default:
            break;
    }
    btnOpen.click();
}

function Closethis() {

    var btnClose = parent.parent.document.getElementById('btnDialogClose');
    var btnUpdate = $(parent.document).find('#MISView').find('#iHold').contents().find('#btnUpdate');
    btnUpdate.click();
    btnClose.click();
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
function sessionExpired() {
    swal({ title: 'Session expired you are being redirected to LogIn Pages!', type: "error" },
                                     function () {
                                         $(parent.parent.window).attr("location", "LogIn.aspx");
                                     });
}
function BindAllFeilds(MisId) {
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/LoadData",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d[0].ErrorMsg == "Done") {
                grdData = msg.d;
                BindData(grdData);
                bindEditBox(MisId);
            }
            else if (msg.d == "Session") {
                sessionExpired();
            }
            else {
                swal({ title: msg.d, type: "error", timer: 3000 });
            }
        },
        error: function (result) {
            // alert('Error');
            swal({ title: 'Error!', type: "error", timer: 5000 });
        }
    });
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/GetAllClients",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                BidClients(grdData);
            }
        },
        error: function (result) {
            //                    alert('Error');
            BidClients();

        }
    });
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/GetAllHDetails",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                BidHDetails(grdData);
            }
        },
        error: function (result) {
            //                    alert('Error');
            BidHDetails();

        }
    });
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/GetAllEmails",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                BidEmail(grdData);
            }
        },
        error: function (result) {
            //                    alert('Error');
            BidEmail();

        }
    });
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/GetAllDocuments",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                BidDocs(grdData);
            }
        },
        error: function (result) {
            //                    alert('Error');
            BidDocs();

        }
    });
}
function bindEditBox(MisId) {
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/LoadStrings",
        data: "{Id :'Notes',sMisId:'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                $find("EdtBrf").set_content(msg.d);
            }
        },
        error: function (result) {
            swal({ title: 'Error!', type: "error", timer: 5000 });
        }
    });

    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/LoadStrings",
        data: "{Id :'Status',sMisId:'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                //                $find("EdtStatus").set_content(msg.d);
                $("#EdtStatus")[0].value = msg.d;
            }
        },
        error: function (result) {
            swal({ title: 'Error!', type: "error", timer: 5000 });

        }
    });

    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/LoadStrings",
        data: "{Id :'Risk',sMisId:'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                $find("EdtRisk").set_content(msg.d);
            }
        },
        error: function (result) {
            swal({ title: 'Error!', type: "error", timer: 5000 });
        }
    });

    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/LoadStrings",
        data: "{Id :'Favs',sMisId:'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                $find("EditRiskFav").set_content(msg.d);
            }
        },
        error: function (result) {
            swal({ title: 'Error!', type: "error", timer: 5000 });
        }
    });
}
function BindData(grdData) {
    try {

        //All ddl feilds
        $("#ddlStages")[0].value = grdData[0].StageId;
        $("#txtNature")[0].value = grdData[0].CaseTypeId;
        $("#txtVertical")[0].value = grdData[0].Vertical;
        if (grdData[0].FinProvision == true) {
            $("#txtfinProv")[0].checked = "checked";
            $("#divAmountPR")[0].style.display = "";
            $("#divReason")[0].style.display = "none";
        }

        if (grdData[0].StageId > 1) {
            //        $("#divAdv")[0].style.display = "";
            //            $("#divPreLit")[0].style.visibility = "visible";
        }
        else {
            //        $("#divAdv")[0].style.display = "none";
            //            $("#divPreLit")[0].style.visibility = "hidden";
        }
        //All text feild

        $("#txtAmountPay")[0].value = grdData[0].AmountPay;
        $("#txtAmtRecv")[0].value = grdData[0].Amount;
        $("#txtReason")[0].value = grdData[0].Reason;
        $("#hdnActId")[0].value = grdData[0].ActId;
        $("#txtLawName")[0].value = grdData[0].ActName;
        $("#txtLawYear")[0].value = grdData[0].ActYear;
        $("#txtAdvId")[0].value = grdData[0].AdvocateId;
        $("#txtFirmId")[0].value = grdData[0].FirmId;
        $("#txtAdvDesc")[0].value = grdData[0].Advocate;
        $("#txtAuthId")[0].value = grdData[0].AuthPersonId;
        $("#txtAutPerson")[0].value = grdData[0].AuthPerson;
        $("#txtAutEmail")[0].value = grdData[0].AuthPersonEmail;
        $("#txtAdvFees")[0].value = grdData[0].AdvFeesAgr;
        $("#txtClaim")[0].value = grdData[0].ClaimAmount;
        $("#txtStartDate")[0].value = grdData[0].startDate;
        $("#txtCloseDate")[0].value = grdData[0].CloseDate;
        $("#txtClientCatg")[0].value = grdData[0].CltCtg;
        $('#lblType').text(grdData[0].cType);
        $('#ddlType').val(grdData[0].cType);
        //        if (grdData[0].StageId > 1) {
        $("#txtSuitNo")[0].value = grdData[0].SuitNum;
        $("#txtForum")[0].value = grdData[0].Forum;
        $("#txtCaseNAme")[0].value = grdData[0].CaseName;
        //        }
    }
    catch (err) {

    }
}

function saveDoc() {
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/SaveDoc",
        data: "{Id :'" + MisId + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                //                BindData();
            }
        },
        error: function (result) {
            swal({ title: 'Error!', type: "error", timer: 5000 });
        }
    });
}

function OpenMail() {
    var wIsPreff = parent.document.getElementById('hdnPreff').value;
    if (wIsPreff == "false") {
        swal({ title: 'Please Update Email Prefferences to proceed!', type: "error", timer: 5000 });
        return false;
    }
    var MisId = PageParam[2];
    var btnOpen = parent.document.getElementById('btnDialogOpen');

    btnOpen.title = "Email_MisData_" + MisId; //OpenFrnId_BindingData_PageIdtoReturnData_controlId

    btnOpen.click();
}

function OpenDocs() {
    if (GetQueryStringParams('MISId').trim() == "") {
        swal({ title: 'Please Save litigation to add document!', type: "error", timer: 5000 });
        return false;
    }
    var MisId = PageParam[2];
    var btnOpen = parent.document.getElementById('btnDialogOpen');

    btnOpen.title = "Docs_MisData_" + MisId; //OpenFrnId_BindingData_PageIdtoReturnData_controlId

    btnOpen.click();
}

function BidEmail(grdData) {
    try {
        jQuery("#grdEmails").jqGrid({
            datatype: "local",
            colNames: ['To', 'From', 'Cc', 'Subject', 'Date', 'Id'],
            colModel: [
                     { name: 'EmailTo', index: 'EmailTo', width: 200 },
                     { name: 'EmailFrom', index: 'EmailFrom', width: 200 },
                       { name: 'EmailCC', index: 'EmailCC', width: 250 },
                     { name: 'Subject', index: 'Subject', width: 190 },

                     { name: 'EmailDate', index: 'EmailDate', width: 80, align: "right" },
                     { name: 'wEmailId', index: 'wEmailId', width: 80, align: "right", hidden: true }

               ],
            multiselect: true,
            rowNum: 10,
            rowList: [5, 10, 20, 50, 100],
            pager: jQuery('#pager'),
            sortorder: "desc",
            viewrecords: true,
            caption: "All Emails",
            height: 250,
            width: 675,
            ondblClickRow: function (rowId) {

            }
        });
        for (var i = 0; i <= grdData.length; i++) {
            jQuery("#grdEmails").jqGrid('addRowData', i + 1, grdData[i]);
        }
    }
    catch (err) {

    }
}

function BidDocs(grdData) {
    try {
        jQuery("#grdDocs").jqGrid({
            datatype: "local",
            colNames: ['ID', 'FileName', "UPLOADED ON"],
            colModel: [
                     { name: 'DocId', index: 'DocId', width: 80, align: "right", hidden: true },

                     { name: 'DocumentName', index: 'DocumentName', width: 400 },

                     { name: 'UploadedOn', index: 'UploadedOn', width: 100 }

               ],
            multiselect: true,
            rowNum: 10,
            rowList: [5, 10, 20, 50, 100],
            pager: jQuery('#pagerDocs'),
            sortorder: "desc",
            viewrecords: true,
            caption: "All Documents",
            height: 250,
            width: 675
        });
        for (var i = 0; i <= grdData.length; i++) {
            jQuery("#grdDocs").jqGrid('addRowData', i + 1, grdData[i]);
        }
    }
    catch (err) {

    }
}

function BidClients(grdData) {

    jQuery("#grdClients").jqGrid({
        datatype: "local",
        colNames: ['Client Id', 'Client Name', 'ClientTypeId', 'Client Type', 'ClientVs', 'Client','Vertical', 'MisId'],
        colModel: [
                     { name: 'ClientId', index: 'ClientId', width: 20, hidden: true },
                       { name: 'ClientName', index: 'ClientName', width: 120 },
                     { name: 'ClientTypeId', index: 'ClientTypeId', width: 10, hidden: true },
                     { name: 'ClientType', index: 'ClientType', width: 100 },

                     { name: 'ClientVs', index: 'ClientVs', width: 80, align: "right", hidden: true },
                     { name: 'Client', index: 'Client', width: 60, align: "right" },
                      { name: 'Vertical', index: 'Vertical', width: 60, align: "right" },
                      { name: 'MisId', index: 'MisId', width: 20, hidden: true }

               ],
        multiselect: true,
        rowNum: 10,
        rowList: [5, 10, 20, 50, 100],
        pager: jQuery('#ClientPager'),
        sortorder: "desc",
        viewrecords: true,
        caption: "All Clients",
        height: 165,
        width: 675,
        ondblClickRow: function (rowId) {

        }
    });
    if (grdData != null) {
        for (var i = 0; i <= grdData.length; i++) {
            jQuery("#grdClients").jqGrid('addRowData', i + 1, grdData[i]);
        }
    }
    //    jQuery("#grdClients").jqGrid('setGridParam',
    //                 {
    //                     datatype: 'local',
    //                     data: grdData
    //                 }).trigger("reloadGrid");
}
function AddClient() {
    if (validateClient($('#txtClientId2').val())) {
        var data = { MisId: $('#hdnId').val(), ClientId: $('#txtClientId2').val(),
            ClientName: $('#txtClient2').val(),
            ClientTypeId: $("#ddlClientType :selected").val(),
            ClientType: $("#ddlClientType :selected").text(),
            ClientVs: $("#ddlClient :selected").val(), Client: $("#ddlClient :selected").text(),
            Vertical: $('#txtcVertical').val()
        };
        //        jQuery("#grdClients").jqGrid('addRowData', 1, data);
        jQuery("#grdClients").addRowData(jQuery("#grdClients").jqGrid('getDataIDs') + 1, data, "last");
        $('#txtClientId2')[0].value = "";
        $('#txtClient2')[0].value = "";
    }
}
function validateClient(id) {
    var bvalidate = true;
    var Clientdata = $('#grdClients').jqGrid('getGridParam', 'data');
    $.each(Clientdata, function (i, data) {
        if (data.ClientId == id) {
            bvalidate = false;
            swal({ title: 'Client already added', type: "info", timer: 5000 });
            //            return false;
        }

    });
    if ($('#txtClientId2').val() == '') {
        swal({ title: 'Select Client', type: "info", timer: 5000 });
        return false;
    }
    if (onClientChange() == false) {
        bvalidate = false;
    }
    if (bvalidate == false) {
        return false;
    }
    return true;
}
function DeleteClient() {

    var gr = jQuery("#grdClients").jqGrid('getGridParam', 'selrow');
    if (gr != null) jQuery("#grdClients").jqGrid('delRowData', gr);
    else swal({ title: "Please Select Row to delete!", type: "info", timer: 5000 });

}

function BidHDetails(grdData) {

    jQuery("#grdHDetails").jqGrid({
        datatype: "local",
        colNames: ['ID', 'Hearing Date', 'Hearing Description', "Authorized Person"],
        colModel: [
                     { name: 'HrdId', index: 'HrdId', width: 10, hidden: true },
                     { name: 'HearingDate', index: 'HearingDate', width: 100 },
                     { name: 'Notes', index: 'Notes', width: 600 },
                    { name: 'PersonId', index: 'PersonId', width: 20, hidden: true },

               ],
        multiselect: true,
        rowNum: 10,
        rowList: [5, 10, 20, 50, 100],
        pager: jQuery('#HPager'),
        sortorder: "desc",
        viewrecords: true,
        caption: "Present Status",
        height: 150,
        ondblClickRow: function (rowId) {

        }
    });
    if (grdData != null) {
        for (var i = 0; i <= grdData.length; i++) {
            jQuery("#grdHDetails").jqGrid('addRowData', i + 1, grdData[i]);
        }
    }
    //    jQuery("#grdHDetails").jqGrid('setGridParam',
    //                 {
    //                     datatype: 'local',
    //                     data: grdData
    //                 }).trigger("reloadGrid");

}
function AddHDetails() {
    if ($('#txtHDate').val() == '') {
        swal({ title: 'Enter valid Hearing Date', type: "info", timer: 5000 });
        return false;
    }
    if ($('#txtAuthId').val() == '0') {
        swal({ title: 'Assign Authorised person first', type: "info", timer: 5000 });
        return false;
    }
    var data = { ID: '0', HearingDate: $('#txtHDate').val(),
        //        Notes: $find("EdtStatus").get_content().toString(),
        Notes: $("#EdtStatus").val().toString(),
        PersonId: $('#txtAuthId').val()
    };
    //    jQuery("#grdHDetails").jqGrid('addRowData', i + 1, data);
    jQuery("#grdHDetails").addRowData(jQuery("#grdHDetails").jqGrid('getDataIDs') + 1, data, "last");

    $('#txtHDate')[0].value = "";
}
function DeleteHDetails() {

    var gr = jQuery("#grdHDetails").jqGrid('getGridParam', 'selrow');
    if (gr != null) jQuery("#grdHDetails").jqGrid('delRowData', gr);
    else swal({ title: "Please Select Row to delete!", type: "info", timer: 5000 });

}
function onClientUploadComplete(sender, e) {
    onImageValidated("TRUE", e);
}

function onImageValidated(arg, context) {

    var test = document.getElementById("testuploaded");
    test.style.display = 'block';

    var fileList = document.getElementById("fileList");
    var item = document.createElement('div');
    item.style.padding = '4px';

    if (arg == "TRUE") {
        var url = context.get_postedUrl();
        url = url.replace('&amp;', '&');
        item.appendChild(createThumbnail(context, url));
    } else {
        item.appendChild(createFileInfo(context));
    }

    fileList.appendChild(item);
}

function createFileInfo(e) {
    var holder = document.createElement('div');
    holder.appendChild(document.createTextNode(e.get_fileName() + ' with size ' + e.get_fileSize() + ' bytes'));

    return holder;
}

function createThumbnail(e, url) {
    var holder = document.createElement('div');
    var img = document.createElement("img");
    img.style.width = '80px';
    img.style.height = '80px';
    img.setAttribute("src", url);

    holder.appendChild(createFileInfo(e));
    holder.appendChild(img);

    return holder;
}

function onClientUploadStart(sender, e) {
    document.getElementById('uploadCompleteInfo').innerHTML = 'Please wait while uploading ' + e.get_filesInQueue() + ' files...';
}

function onClientUploadCompleteAll(sender, e) {

    var args = JSON.parse(e.get_serverArguments()),
                unit = args.duration > 60 ? 'minutes' : 'seconds',
                duration = (args.duration / (args.duration > 60 ? 60 : 1)).toFixed(2);

    var info = 'At <b>' + args.time + '</b> server time <b>'
                + e.get_filesUploaded() + '</b> of <b>' + e.get_filesInQueue()
                + '</b> files were uploaded with status code <b>"' + e.get_reason()
                + '"</b> in <b>' + duration + ' ' + unit + '</b>';

    document.getElementById('uploadCompleteInfo').innerHTML = info;
}

//    function Closethis() {

//                var btnClose = parent.parent.document.getElementById('btnDialogClose');
//                btnClose.click();
//            }

function Download() {

    var gr = jQuery("#grdDocs").jqGrid('getGridParam', 'selrow');
    if (gr != null) {
        var DocId = jQuery("#grdDocs").jqGrid('getRowData', gr).DocId;
        var MisId = PageParam[2];
        var btnOpen = parent.document.getElementById('btnDialogOpen');

        btnOpen.title = "DownLoad_" + DocId + '@' + MisId + "_MIS"; //OpenFrnId_BindingData_PageIdtoReturnData_controlId

        btnOpen.click();
        //                    window.open('frmDownload.aspx?DocId=' & jQuery("#grdDocs").jqGrid('getRowData', gr[0]).DocId);
    }
    else swal({ title: "Please Select document to download!", type: "info", timer: 5000 });
}

function DeleteDoc() {

    var gr = jQuery("#grdDocs").jqGrid('getGridParam', 'selrow');
    if (gr != null) {
        var DocIds = jQuery("#grdDocs").jqGrid('getGridParam', 'selarrrow');
        var MisId = PageParam[2];
        var ids = "";
        $.each(DocIds, function (i, data) {
            var RowData = jQuery("#grdDocs").getRowData(this);
            if (ids == "") {
                ids = RowData.DocId + "@";
            }
            else {
                ids = ids + RowData.DocId + "@";
            }
        });

        $.ajax({
            type: "POST",
            url: "MisDetails.aspx/DeleteData",
            data: "{cIds :'" + ids + "' ,Lit :'" + MisId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                swal({ title: 'deleted succesfully.', type: "info", timer: 5000 });
                UpdateDocs();
            }
        });
    }
    else swal({ title: "Please Select document to delete!", type: "info", timer: 5000 });
}

function UpdateDocs() {
    $.ajax({
        type: "POST",
        url: "MisDetails.aspx/GetAllDocuments",
        data: "{Id :'" + PageParam[2] + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != null) {
                grdData = msg.d;
                $("#grdDocs").jqGrid('clearGridData');
                for (var i = 0; i <= grdData.length; i++) {
                    jQuery("#grdDocs").jqGrid('addRowData', i + 1, grdData[i]);
                }
            }
        },
        error: function (result) {
            //                    alert('Error');
            BidDocs();

        }
    });
}


function checkQuote() {
    if (event.keyCode == 39) {
        event.keyCode = 0;
        return false;
    }
}

function onTypeChange() {
    var sType = $('#ddlType').val();
    $('#lblType').text(sType);
}
            