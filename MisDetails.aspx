<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MisDetails.aspx.cs" Inherits="MisDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="HTMLEditor" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Styles/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="Styles/redmond/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="Styles/sweet-alert.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="Js/jquery.widget.min.js" type="text/javascript"></script>
    <script src="Js/metro.min.js" type="text/javascript"></script>
    <script src="Js/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="Js/MisDetails.js" type="text/javascript"></script>
    <script src="Js/grid.locale-en.js" type="text/javascript"></script>
    <script src="Js/jquery.jqGrid.src.js" type="text/javascript"></script>
    <script src="Js/sweet-alert.min.js" type="text/javascript"></script>
    <style type="text/css">
        .padded-multiline
        {
            line-height: 1.3;
            padding: 2px 0;
            background: grey;
            box-shadow: 10px 0 0 grey;
        }
        .PPLegend
        {
            color: #064c93;
            font-size: 11px;
            font-family: Verdana,Arial,Helvetica,sans-serif;
            font-weight: bold;
            font-style: oblique;
            text-align: left;
        }
        .ajax__htmleditor_editor_default .ajax__htmleditor_editor_container
        {
            border: 1px solid #C2C2C2;
        }
    </style>
</head>
<body class="metro">
    <form id="frmMIS" runat="server" class="PPForm">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <div class="example" style="height: 530px">
        <fieldset class="PPFieldset">
            <legend class="PPLegend">Litigation Details</legend>
            <div class="tab-control" data-role="tab-control">
                <ul class="tabs">
                    <li class="active"><a href="#_page_1">General</a></li>
                    <li><a href="#_page_8">Clients:</a></li>
                    <li><a href="#_page_2">Brief Facts:</a></li>
                    <li><a href="#_page_3">Present Status:</a></li>
                    <li><a href="#_page_4">Risk Factors:</a></li>
                    <%-- <li><a href="#_page_5">Law/Acts/Rules:</a></li>--%>
                    <%-- <li><a href="#_page_5">Risk Factors:</a></li>--%>
                    <li value="0"><a href="#_page_6">Documents</a></li>
                    <li value="1" style="visibility: hidden"><a href="#_page_7">Emails:</a></li>
                </ul>
                <div class="frames">
                    <div class="frame" id="_page_1" style="display: block;">
                        <div style="width: 100%; height: 390px;">
                            <div style="width: 100%; padding-left: 2%;">
                                <div class="inline-block">
                                    <label>
                                        Stages
                                    </label>
                                    <asp:DropDownList ID="ddlStages" Width="255px" onChange="javascript:onStageChange()"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="inline-block">
                                    <label>
                                        Start Date</label>
                                    <asp:TextBox runat="server" ID="txtStartDate" Enabled="false" />
                                    <asp:ImageButton runat="Server" ID="ImageButton2" ImageUrl="Styles/images/Calendar_scheduleHS.png"
                                        AlternateText="Click to show calendar" />
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtStartDate"
                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                </div>
                                <div class="inline-block">
                                    <label>
                                        Close Date</label>
                                    <asp:TextBox runat="server" ID="txtCloseDate" Enabled="false" />
                                    <asp:ImageButton runat="Server" ID="ImageButton3" ImageUrl="Styles/images/Calendar_scheduleHS.png"
                                        AlternateText="Click to show calendar" />
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtCloseDate"
                                        PopupButtonID="ImageButton3" Format="dd/MM/yyyy" />
                                </div>
                            </div>
                            <div style="width: 100%;" class="inline-block" id="divPreLit">
                                <div style="padding-left: 2%;" class="inline-block">
                                    <label>
                                        Case Name
                                    </label>
                                    <input id="txtCaseNAme" type="text" maxlength="80" /></div>
                                <div class="inline-block">
                                    <label id="lblType">
                                        Suit No.
                                    </label>
                                    <select id="ddlType" style="width: 155px" onchange="javascript:onTypeChange()">
                                        <option class="info">Summary Suit No.</option>
                                        <option class="info">Suit No.</option>
                                        <option>Complaint No.</option>
                                        <option>Writ Petition No.</option>
                                        <option>Company Petition No.</option>
                                        <option>Application No.</option>
                                    </select>
                                    <input id="txtSuitNo" type="text" maxlength="60" /></div>
                                <div class="inline-block ">
                                    <label>
                                        Forum
                                    </label>
                                    <input id="txtForum" type="text" maxlength="100" /></div>
                            </div>
                            <div style="width: 100%" class="inline-block">
                                <div style="padding-left: 2%;" class="inline-block">
                                    <label>
                                        Nature of Case
                                    </label>
                                    <%--<input id="txtNature" type="text" style="width: 150px" />--%>
                                    <asp:DropDownList ID="txtNature" Width="155px" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="inline-block">
                                    <div id="divAdv">
                                        <label>
                                            Advocate
                                        </label>
                                        <input id="txtAdvId" type="text" class="info " disabled="disabled" style="width: 130px;
                                            display: none" value="0" />
                                        <input id="txtFirmId" type="text" class="info " disabled="disabled" style="width: 130px;
                                            display: none" value="0" />
                                        <input id="txtAdvDesc" type="text" disabled="disabled" style="width: 360px" />
                                        <input id="btnAdvcate" type="button" class="button info" value="..." style="width: 40px"
                                            onclick="OpenDialog(this)" /></div>
                                </div>
                            </div>
                            <div class="inline-block" style="width: 100%; padding-left: 2%">
                                <div class="inline-block" style="width: 57%;">
                                    <div style="display: none">
                                        <label>
                                            Vertical
                                        </label>
                                        <%--<input id="txtVertical" type="text" style="width: 150px" />--%>
                                        <select id="txtVertical" style="width: 155px">
                                            <option class="info">IFS</option>
                                            <option>SDB</option>
                                            <option>MPIL</option>
                                            <option>Support </option>
                                            <option>Innovative</option>
                                        </select>
                                    </div>
                                    <div class="input-control switch inline-block" data-role="input-control" style="padding-right: 3%;
                                        width: 170px;">
                                        <%--<label>
                                            Financial Provisioning:
                                        </label>--%>
                                        <label class="inline-block" style="margin-right: 20px; white-space: nowrap">
                                            Financial Provisioning:
                                            <input id="txtfinProv" onchange="DisableAccnt(this);" type="checkbox" />
                                            <span class="check"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="inline-block">
                                    <div id="divReason">
                                        <div>
                                            <label>
                                                Reason:
                                            </label>
                                        </div>
                                        <div>
                                            <input id="txtReason" type="text" maxlength="200" style="width: 150px" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                                <div class="inline-block">
                                    <label>
                                        Law/Acts/Rules</label>
                                    <asp:HiddenField runat="server" ID="hdnActId" Value="none" />
                                    <input id="txtLawName" type="text" maxlength="100" style="width: 360px" /></div>
                                <div class="inline-block">
                                    <label>
                                        Year</label>
                                    <input id="txtLawYear" type="text" maxlength="15" style="width: 100px" /></div>
                            </div>
                            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                                <div class="inline-block">
                                    <label>
                                        Authorized Person</label>
                                    <input id="txtAutPerson" type="text" disabled="disabled" style="width: 360px" /></div>
                                <div class="inline-block">
                                    <label>
                                        Email</label>
                                    <input id="txtAutEmail" disabled="disabled" type="text" />
                                    <input id="txtAuthId" type="text" value="0" style="display: none" />
                                    <input id="btnAutPrsn" type="button" class="button info" value="..." style="width: 40px"
                                        onclick="OpenDialog(this)" />
                                </div>
                            </div>
                            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                                <div id="div1" class="inline-block">
                                    <div id="div2" class="inline-block">
                                        <div>
                                            <label>
                                                Advocate Fees agreed:
                                            </label>
                                        </div>
                                        <div>
                                            <input id="txtAdvFees" type="text" style="width: 150px" />
                                        </div>
                                    </div>
                                    <div id="div3" class="inline-block" style="padding-left: 15px">
                                        <div>
                                            <label>
                                                Claim Amount :
                                            </label>
                                        </div>
                                        <div>
                                            <input id="txtClaim" type="text" style="width: 150px" />
                                        </div>
                                    </div>
                                </div>
                                <div class="inline-block">
                                    <div id="divAmountPR" style="display: none">
                                        <div id="divAmountP" class="inline-block">
                                            <div>
                                                <label>
                                                    Amount Payable:
                                                </label>
                                            </div>
                                            <div>
                                                <input id="txtAmountPay" type="text" style="width: 150px" />
                                            </div>
                                        </div>
                                        <div id="divAmountR" class="inline-block" style="padding-left: 47px">
                                            <div>
                                                <label>
                                                    Provision Amount:
                                                </label>
                                            </div>
                                            <div>
                                                <input id="txtAmtRecv" type="text" style="width: 150px" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%; padding-left: 2%;" class="inline-block">
                            </div>
                        </div>
                    </div>
                    <div class="frame" id="_page_2">
                        <div style="width: 100%; height: 390px;">
                            <label>
                                Brief Facts:</label>
                            <div style="width: 100%; height: 350px;">
                                <HTMLEditor:Editor ID="EdtBrf" Style="height: 340px;" runat="server" onkeypress="return checkQuote();" />
                            </div>
                        </div>
                    </div>
                    <div class="frame" id="_page_3" style="display: none;">
                        <div style="width: 100%; height: 390px;">
                            <div style="width: 100%; ">
                                <div class="inline-block">
                                    <label>
                                        Hearing Date</label>
                                    <asp:TextBox runat="server" ID="txtHDate" Enabled="false" />
                                    <asp:ImageButton runat="Server" ID="Image1" ImageUrl="Styles/images/Calendar_scheduleHS.png"
                                        AlternateText="Click to show calendar" />
                                    <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="txtHDate"
                                        PopupButtonID="Image1" Format="dd/MM/yyyy" />
                                </div>
                                <div class="inline-block">
                                    <label>
                                        Description</label>
                                    <textarea id="EdtStatus" cols="50" rows="6" runat="server" />
                                </div>
                                <div class="inline-block">
                                    <input id="btnAddHDetails" type="button" style="margin-top: 2%" class="button success"
                                        value="Add Hearing Details" onclick="AddHDetails()" />
                                </div>
                                <div style="width: 100%; ">
                                    <label>
                                        All Details</label>
                                    <table id="grdHDetails" class="table">
                                    </table>
                                    <div id="HPager">
                                    </div>
                                    <input id="btnHDelete" type="button" style="margin-top: 2%" class="button success"
                                        value="Delete Hearing Details" onclick="DeleteHDetails()" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="frame" id="_page_4">
                        <div class="inline-block ">
                            <div style="width: 50%; height: 390px; float: left;">
                                <label style="color: #60a917 !important">
                                    Favorable:</label>
                                <div style="width: 100%; height: 350px;">
                                    <HTMLEditor:Editor ID="EditRiskFav" Style="height: 340px;" runat="server" onkeypress="return checkQuote();" />
                                </div>
                            </div>
                            <div style="width: 50%; height: 390px; float: right;">
                                <label style="color: Red">
                                    Worst:</label>
                                <div style="width: 100%; height: 350px;">
                                    <HTMLEditor:Editor ID="EdtRisk" CssClass="error" Style="height: 340px;" runat="server"
                                        onkeypress="return checkQuote();" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="frame" id="_page_5">
                        <div style="width: 100%; height: 390px;">
                            <%-- <div class="inline-block" style="width: 100%;">
                                <div class="inline-block">
                                    <label>
                                        Law/Acts/Rules</label>
                                    <input id="txtLawName" type="text" style="width: 270px" /></div>
                                <div class="inline-block">
                                    <label>
                                        Year</label>
                                    <input id="txtLawYear" type="text" style="width: 100px" /></div>
                            </div>--%>
                            <%-- <div style="width: 100%; height: 250px;">
                                <label>
                                    Desc</label>
                                <HTMLEditor:Editor ID="EditLawItem" Height="250px" runat="server" />
                                <asp:HiddenField runat="server" ID="hdnActId" Value="none" />
                            </div>--%>
                            <label>
                                Favorable:</label>
                            <%--<div style="width: 100%; height: 250px;">
                                <HTMLEditor:Editor ID="EditRiskFav" Style="height: 260px;" runat="server" />
                            </div>--%>
                        </div>
                    </div>
                    <div class="frame" id="_page_6" style="display: block;">
                        <div style="width: 100%; height: 390px;">
                            <div style="width: 100%; height: 335px;">
                                <label>
                                    All Documents</label>
                                <table id="grdDocs" class="table">
                                </table>
                                <div id="pagerDocs">
                                </div>
                            </div>
                            <input id="btnAddDocs" type="button" style="margin-top: 2%" class="button success"
                                value="Add Documents" onclick="OpenDocs()" />
                            <input id="btnDownload" type="button" style="margin-top: 2%" class="button success"
                                value="Download" onclick="Download()" />
                            <input id="btnDeleteDoc" type="button" style="margin-top: 2%" class="button success"
                                value="Delete" onclick="DeleteDoc()" />
                            <input id="btnUpdateDoc" type="button" style="margin-top: 2%; display: none" class="button success"
                                value="Download" onclick="UpdateDocs()" />
                        </div>
                    </div>
                    <div class="frame" id="_page_7" style="display: block;">
                        <div style="width: 100%; height: 390px;">
                            <div style="width: 100%; height: 335px;">
                                <label>
                                    All Emails</label>
                                <table id="grdEmails" class="table">
                                </table>
                                <div id="pager">
                                </div>
                            </div>
                            <input id="btnAddMail" type="button" style="margin-top: 2%" class="button success"
                                value="New Mail" onclick="OpenMail()" />
                        </div>
                    </div>
                    <div class="frame" id="_page_8" style="display: block;">
                        <div style="width: 100%;" class="inline-block">
                            <label>
                                Client Category
                            </label>
                            <input id="txtClientCatg" type="text" class="info " value="" maxlength="80" />
                        </div>
                        <div style="width: 100%;" class="inline-block">
                            <label>
                                Client
                            </label>
                            <select id="ddlClient" style="width: 155px" onchange="javascript:onClientChange()">
                                <option value="1">Client1</option>
                                <option value="2">Client2</option>
                            </select>
                            <asp:DropDownList ID="ddlClientType" Width="155px" onChange="javascript:onClientChange()"
                                runat="server">
                            </asp:DropDownList>
                            <input id="txtClientId2" type="text" class="info " style="display: none" value="" />
                            <input id="txtClient2" type="text" disabled="disabled" style="width: 270px" />
                            <input id="txtcVertical" type="text" style="display: none" />
                            <input id="btnClient2" type="button" class="button info" value="..." style="width: 40px"
                                onclick="OpenDialog(this)" />
                            <input id="btnAddClient" type="button" class="button info" value="Add Client" onclick="AddClient();" />
                        </div>
                        <div style="width: 100%; margin-top: 10px;">
                            <div style="width: 100%;">
                                <table id="grdClients" class="table">
                                </table>
                                <div id="ClientPager">
                                </div>
                            </div>
                            <input id="btnDelete" type="button" style="margin-top: 2%" class="button info" value="Delete"
                                onclick="DeleteClient()" />
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top: 2%">
                <input id="btnOk" type="button" class="button success" value="Save" onclick="SaveClient()" />
                <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
                <asp:HiddenField runat="server" ID="hdnId" Value="0" />
                <label id="lblSave" style="color: Red; float: right">
                </label>
            </div>
        </fieldset>
    </div>
    </form>
</body>
</html>
