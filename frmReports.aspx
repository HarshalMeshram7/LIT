<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmReports.aspx.cs" Inherits="frmReports" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/metro-bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Js/pdfmake.min.js" type="text/javascript"></script>
    <script src="Js/vfs_fonts.js" type="text/javascript"></script>
</head>
<body class="metro">
    <form id="frmRept" runat="server" class="PPForm">
    <asp:ScriptManager ID="ScriptManager2" EnablePageMethods="true" runat="server" EnablePartialRendering="true">
    </asp:ScriptManager>
    <div>
        <fieldset class="PPFieldset">
            <legend class="PPLegend">MIS Report</legend>
            <div>
                <div id="divCntr" class="inline-block">
                    <label class="PPLegend" runat="server" id="lblReport" style="float: left; padding-right: 20px">
                        Select Report :</label>
                    <label class="PPLegend" runat="server" id="Label2" style="float: left; padding-right: 20px">
                        Quaters </label>
                    <asp:DropDownList ID="ddlQuaters" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlYears" runat="server">
                    </asp:DropDownList>
                    <input type="radio" checked="checked" name="rbtnOption" id="rVertical" value="Nature" /><span>By
                        Nature</span>
                    <input type="radio" id="rNature" name="rbtnOption" value="Vertical" /><span>By Vertical</span>
                    <%--<asp:RadioButton runat="server" Checked="true" GroupName="rbtnOption" ID="rVertical" Text="By Vertical"/>
                    <asp:RadioButton runat="server" Checked="true" GroupName="rbtnOption" ID="rNature" Text="By Nature" />--%>
                    <asp:Button ID="btnReports" runat="server" Text="Select Report" CssClass="button info"
                        OnClick="btnReports_Click" />
                    <label class="PPLegend" runat="server" id="Label1">
                    </label>
                </div>
            </div>
            <div style="margin-top: 2%;" runat="server">
                <asp:UpdatePanel ID="UpdateReportsPanel" runat="server" UpdateMode="Conditional">
                    <%-- OnLoad="UpdateHomeEntityPanel_Load">--%>
                    <ContentTemplate>
                        <div id="divReport" style="visibility: hidden" runat="server">
                            <asp:Chart ID="Chart1" runat="server" Height="430px" Width="700px" BorderlineDashStyle="Solid"
                                BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" BackColor="#D3DFF0"
                                BorderColor="26, 59, 105">
                                <Titles>
                                    <asp:Title ShadowOffset="3" Name="Items" />
                                </Titles>
                                <Legends>
                                    <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Default"
                                        LegendStyle="Row" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" />
                                </Legends>
                                <Series>
                                    <%-- <asp:Series  Name="No of Cases">
                                    </asp:Series>--%>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                        BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                        <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                            <MajorGrid LineColor="64, 64, 64, 64" />
                                        </AxisY>
                                        <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                            <MajorGrid LineColor="64, 64, 64, 64" />
                                        </AxisX>
                                    </asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnReports" EventName="Click"></asp:AsyncPostBackTrigger>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div>
                <input id="btnDownload" type="button" class="button success" value="Download" onclick="Download()" />
                <input id="btnPrint" type="button" class="button success" value="Print" onclick="PrintPdf()" />
                <input id="btnCancel" type="button" class="button success" value="Cancel" onclick="Closethis()" />
            </div>
        </fieldset>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
    
         var reportType=GetQueryStringParams('ReportId');
         if (reportType!="2"){
           $(":radio").css("display","none");
           $("#divCntr").find('span').css("display","none");
           }
        });
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
        function PrintPdf() {
            var canvas=document.createElement('canvas');
            var data=$("#Chart1")[0];
            canvas.width=700;
            canvas.height=400;
            var ctx=canvas.getContext('2d');
            ctx.drawImage(data,0,0);
            var ImgData=canvas.toDataURL("png");
 var docDefinition = {
//            header: 'ISS Reports',
            pageOrientation: 'landscape',
            content: [
                {
                    stack: ['ISS Reports',
				{ text: "Bar Diagram - "+ $('#ddlSelectReports option:selected').text(), margin: [0, 20], style: 'subheader' },
                
                ], 
                style: 'header'    
                },   
				{
				image: ImgData,				
}
                ]
        };
            //            pdfMake.createPdf(docDefinition).open();
            pdfMake.createPdf(docDefinition).print();
        }
        function Download(){
         var canvas=document.createElement('canvas');
            var data=$("#Chart1")[0];
            canvas.width=700;
            canvas.height=400;
            var ctx=canvas.getContext('2d');
            ctx.drawImage(data,0,0);
            var ImgData=canvas.toDataURL("png");
        var docDefinition = {
//            header: 'ISS Reports',
            pageOrientation: 'landscape',
            content: [
                {
                    stack: ['ISS Reports',
				{ text: "Bar Diagram - "+ $('#ddlSelectReports option:selected').text(), margin: [0, 20], style: 'subheader' },
                
                ], 
                style: 'header'    
                },   
				{
				image: ImgData			
}
                ]
        };
            pdfMake.createPdf(docDefinition).download();
        }
    </script>
</body>
</html>
