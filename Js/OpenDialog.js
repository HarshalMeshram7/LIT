var oPRFormId = { "MisDetails": "MisDetails", "NewAdvocate": "NewAdvocate", "NewClient": "NewClient",
    "NewUser": "NewUser", "AdvocateView": "AdvocateView", "MISView": "MISView", "ClientView": "ClientView",
    "EditView": "EditView", "frmPopUp": "frmPopUp", "Email": "Email",
    "URS": "URS", "book": "book", "ContactView": "ContactView",
    "Reports": "Reports", "Newfirm": "Newfirm", "AuthPrsn": "AuthPrsn",
    "down": "down", "FirmViews": "FirmViews", "AuthView": "AuthView", "UserView": "UserView",
    "MISReports": "MISReports", "StanDraft": "StanDraft", "StanDocs": "StanDocs"
};

function OpenUrl(id) {
    
   var wAdmin = $('#hdnAdminLevel').val();
   if (wAdmin == "0" || wAdmin == '300') {
      // alert('User does not have access to Edit and Upload.')
       return false;
   }
    switch (id.id) {
        case "A1":
            //            OpenMis(id);
            OpenMISView(id, false);
            break;
        case "a2":
//            OpenAdvocate(id);
            OpenAdvocateView(id, false);
            break;
        case "a3":
//            OpenClient(id);
            OpenClientView(id, false);
            break;
        case "A4":
            OpenUserView(id, false);
//            OpenUserDialog('New Employee', 'IsPosEmp=0');
            break;
        case "A5":
            OpenStageDialog();
            break;
        case "A6":
            OpenReportsDialog();
            break;
        case "aAdvocate":
            OpenAdvocateView(id, true);
            break;
        case "tileScroll0_1-1":
            OpenEditViews(id, true);
            break;
        case "aClient": 
            OpenClientView(id, true);
            break;
        case "firmTile":
            OpenFirmView(true);
            break;
        case "aLitViews":
            OpenMISView(id, true);
            break;
        case "URSetting":
            OpenUrs(id);
            break;
        case "addrBook":
           OpenBookView(id);
           break;
       case "a7":
//           OpenFirm(id);
           OpenFirmView(false);
           break;
       case "A8":
           OpenAuthPrsnView(id, false);
//           OpenAuthPrsn(id);
           break;
       case "a9":
           OpenAuthPrsnView(id, true);
           break;
       case "aUserView":
           OpenUserView(id, true);
           break;
       case "aMIS":
           OpenMISREport(id); 
           break;
       case "aStandard":
           OpenStandartDraft(id, true);
           break;
       case "aStandardE":
           OpenStandartDraft(id, false);
           break;
        default: 
            break;
    }
}

function OpenDialog(id) {
    switch (id.title.split('_')[0]) {
        case "PopUp":
            OpenPopUp(id);
            break;
        case "a2":
            OpenAdvocate(id);
            break;
        case "a3":
            OpenClient(id);
            break;
        case "URSetting":
            OpenUrs(id);
            break;
        case "A4":
            OpenUserDialog('New Employee', 'IsPosEmp=0');
            break;
        case "aAdvocate":
            OpenAdvocateView(id, 'IsPosEmp=1');
            break;
        case "tileScroll0_1-1":
            OpenEditViews(id, 'IsPosEmp=1');
            break;
        case "aClient":
            OpenClientView(id, 'IsPosEmp=1');
            break;
        case "firmTile":
            OpenFirmView();
            break;
        case "aLitViews":
            OpenMISView(id, true);
            break;
        case "A1":
            OpenMis(id);
            break;
        case "Email":
            OpenEmail(id);
            break;
        case "Docs":
            OpenDocs(id);
            break;
        case "aLitViews":
            OpenMISView(id, true);
            break;
        case "aContact":
            OpenBook(id);
            break;
        case "a7":
            OpenFirm(id);
            break;
        case "DownLoad":
            OpenDownloa(id);
            break;
        case "A8":
            OpenAuthPrsn(id);
            break;
        case "aMIS":
            OpenMISREport(id);
            break;
        case "sDocs":
            OpensDocs(id);
            break;
        default:
            break;
    }
}

function OpenMis(sID) {/// <reference path="../../MisDetails.aspx" />

    $.nsWindow.open({
        title: '',
        width: 900,
        height: 620,
        dataUrl: 'MisDetails.aspx?MISId=' + sID.title,
        formId: oPRFormId.MisDetails
    });
    return false;
}
function OpenDownloa(sID) {/// <reference path="../../MisDetails.aspx" />

//    $.nsWindow.open({
//        title: 'Download',
//        width: 900,
//        height: 620,
//        dataUrl: 'frmDownload.aspx?Data=' + sID.title.split('_')[1],
//        formId: oPRFormId.down
    //    });
    window.open('frmDownload.aspx?Data=' + sID.title.split('_')[1] + '&sPage=' + sID.title.split('_')[2], 'Download', null, null);
    return false;
}
function OpenAdvocate(sID) {/// <reference path="../../AdvocateDetails.aspx" />OpenEmail

    $.nsWindow.open({
        title: '',
        width: 500,
        height: 305,
        dataUrl: 'AdvocateDetails.aspx?' + sID.title,
        formId: oPRFormId.NewAdvocate
    });
    return false;
}

function OpenFirm(sID) {/// <reference path="../../AdvocateDetails.aspx" />OpenEmail

    $.nsWindow.open({
        title: 'Add New Firm',
        width: 650,
        height: 350,
        dataUrl: 'frmFirm.aspx?' + sID.title,
        formId: oPRFormId.Newfirm
    });
    return false;
}

function OpenAuthPrsn(sID) {/// <reference path="../../AdvocateDetails.aspx" />OpenEmail

    $.nsWindow.open({
        title: '',
        width: 500,
        height:300,
        dataUrl: 'frmAuthPrsn.aspx?' + sID.title,
        formId: oPRFormId.AuthPrsn
    });
    return false;
}
function OpenClient(sID) {/// <reference path="../../LitClient.aspx" />



    $.nsWindow.open({
        title: '',
        width: 580,
        height: 410,
        dataUrl: 'LitClient.aspx?' + sID.title,
        formId: oPRFormId.NewClient
    });
    return false;
}
function OpenUserDialog(sID, id) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 450,
        height: 300,
        dataUrl: 'AddUser.aspx',
        formId: oPRFormId.NewUser
    });
    return false;
}

function OpenStageDialog() {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 450,
        height: 260,
        dataUrl: 'frmStages.aspx',
        formId: oPRFormId.NewUser
    });
    return false;
} 
function OpenAdvocateView(sID, ISViews) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 700,
        height: 540,
        dataUrl: 'AdvocateView.aspx?ISViews=' + ISViews,
//        dataUrl: 'frmEmail.aspx',
        formId: oPRFormId.AdvocateView
    });
    return false;
}
function OpenMISREport(sID, ISViews) {


    $.nsWindow.open({
        title: '',
        width: 700,
        height: 540,
        dataUrl: 'ReportMis.aspx?ISViews=' + ISViews,
        //        dataUrl: 'frmEmail.aspx',
        formId: oPRFormId.MISReports
    });
    return false;
}
function OpenStandartDraft(sID, ISViews,isType) {


    $.nsWindow.open({
        title: '',
        width: 700,
        height: 540,
        dataUrl: 'StandardDraft.aspx?ISViews=' + ISViews + "&IsType=" + isType,
        //        dataUrl: 'frmEmail.aspx',
        formId: oPRFormId.StanDraft
    });
    return false;
}
function OpenMISView(sID, ISViews) {/// <reference path="../../AddUser.aspx" />
    var QueryString = "";
    if (sID.title.split('_') != undefined) {
        QueryString = sID.title.split('_')[1];
    }

    $.nsWindow.open({
        title: '',
        width: 750,
        height: 590,
        dataUrl: 'MIS_View.aspx?ISViews=' + ISViews+ '_'+ QueryString,
        formId: oPRFormId.MISView
    });

    return false;
}

function OpenClientView(sID, ISViews) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 650,
        height: 525,
        dataUrl: 'ClientView.aspx?ISViews=' + ISViews,
        formId: oPRFormId.ClientView
    });
    return false;
}


function OpenUserView(sID, ISViews) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 650,
        height: 525,
        dataUrl: 'UserViews.aspx?ISViews=' + ISViews,
        formId: oPRFormId.UserView
    });
    return false;
}


function OpenFirmView(ISViews) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 650,
        height: 525,
        dataUrl: 'frmFirmView.aspx?ISViews=' + ISViews,
        formId: oPRFormId.FirmViews
    });
    return false;
}
function OpenAuthPrsnView(ISViews) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 650,
        height: 525,
        dataUrl: 'AuthView.aspx?ISViews=' + ISViews,
        formId: oPRFormId.AuthView
    });
    return false;
}

function OpenEditViews(sID, id) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 650,
        height: 385,
        dataUrl: 'EditView.aspx',
        formId: oPRFormId.EditView
    });
    return false;
}

function OpenPopUp(id) {
    
//    switch (id.title.split('_')[1]) {
//        case "Advocate":
//            title = "";
//            break;
//        case "Client":
//            title = "";
//            break;
//        case "a3":
//           
//            break;
//        case "A4":
//           
//            break;
//        default:
//            break;
//    }
    $.nsWindow.open({
        title: '',
        width: 650,
        height: 550,
        dataUrl: 'frmPopUp.aspx?Param='+id.title,
        formId: oPRFormId.frmPopUp
    });
    return false;
}

function CloseMe(Me) {
    $.nsWindow.close();
    return CloseDialog(Me);
}
function CloseDialog(Me) {
    return false;
}

function OpenEmail(sID) {/// <reference path="../../AdvocateDetails.aspx" />

    $.nsWindow.open({
        title: '',
        width: 700,
        height: 610,
        dataUrl: 'frmEmail.aspx?' + sID.title,
        formId: oPRFormId.Email
    });
    return false;
}

function OpenDocs(sID) {
    $.nsWindow.open({
        title: '',
        width: 520,
        height: 500,
        dataUrl: 'frmDocs.aspx?LitId=' + sID.title,
        formId: oPRFormId.StanDocs
    });
    return false;
}
function OpensDocs(sID) {
    $.nsWindow.open({
        title: '',
        width: 520,
        height: 530,
        dataUrl: 'frmStandardDocs.aspx?IsType=' + sID.title.split('_')[2],
        formId: oPRFormId.StanDocs
    });
    return false;
}
function OpenUrs(sID) {
    $.nsWindow.open({
        title: '',
        width: 365,
        height: 420,
        dataUrl: 'frmPreff.aspx?UserId=' + sID.title.split('_')[1],
        formId: oPRFormId.URS
    });
    return false;
}

function OpenBook(sID) {
    $.nsWindow.open({
        title: '',
        width: 350,
        height: 410,
        dataUrl: 'frmAddrbook.aspx?' + sID.title,
        formId: oPRFormId.book
    });
    return false;
}

function OpenBookView(sID, id) {/// <reference path="../../AddUser.aspx" />


    $.nsWindow.open({
        title: '',
        width: 700,
        height: 540,
        dataUrl: 'ContactView.aspx',
        //        dataUrl: 'frmEmail.aspx',
        formId: oPRFormId.ContactView
    });
    return false;
}

function OpenReportsDialog(Id) {
    var wAdmin = $('#hdnAdminLevel').val();
    if (wAdmin == "0" || wAdmin == '300') {
        // alert('User does not have access to Edit and Upload.')
        return false;
    }
    $.nsWindow.open({
        title: '',
        width: 800,
        height: 620,
        dataUrl: 'frmReports.aspx',
        //        dataUrl: 'frmEmail.aspx',
        formId: oPRFormId.Reports
    });
    return false;
}

//For custom Alerts
function Salert(Me) {
    //    swal({ title: "deleted successfully!", type: "success", timer: 5000 });
    var ctitle = Me.title;
    var ctype = Me.lang;
    switch (ctype) {
        case "success":
            swal({ title: ctitle, type: ctype, timer: 5000 });
            break;
        case "warning":
            swal({ title: ctitle, type: ctype, timer: 5000 });
            break;
        case "error":
            swal({ title: ctitle, type: ctype, timer: 5000 });
            break;
        case "info":
            swal({ title: ctitle, type: ctype });
            break;
    }
    return false;
}
