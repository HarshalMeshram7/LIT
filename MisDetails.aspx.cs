using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using LitigationMaster;
using System.Data;
using System.IO;
using AjaxControlToolkit;
using System.Globalization;
public partial class MisDetails : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();
    protected void Page_Load(object sender, EventArgs e)
    {
        m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        //fileToUpload.Attributes.Add("onchange", "javascript:return ajaxFileUpload();");
        if (m_oWebInterface == null)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Seesion", "<script type='text/javascript'>sessionExpired();</script>");
            return;
        }
        if (!IsPostBack)
        {
            cStages stage = new cStages(m_oWebInterface.oWebInterface);
            stage.LoadValues();
            DataTable dt = stage.dtStages;
            ddlStages.DataSource = dt;
            ddlStages.DataTextField = "sStage";
            ddlStages.DataValueField = "wStageId";
            ddlStages.SelectedIndex = 0;
            ddlStages.DataBind();

            cClientType ctype = new cClientType(m_oWebInterface.oWebInterface);
            ctype.LoadValues();
            ddlClientType.DataSource = ctype.dtLitigation;
            ddlClientType.DataTextField = "sDesc";
            ddlClientType.DataValueField = "wTypeId";
            ddlClientType.SelectedIndex = 0;
            ddlClientType.DataBind();

            //ddlClient2.DataSource= ctype.dtLitigation;
            //ddlClient2.DataTextField = "sDesc";
            //ddlClient2.DataValueField = "wTypeId";
            //ddlClient2.SelectedIndex = 0;
            //ddlClient2.DataBind();

            cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
            txtNature.DataSource = cLitigation.GetCaseType();
            txtNature.DataTextField = "sCaseName";
            txtNature.DataValueField = "wCaseTypeId";
            txtNature.SelectedIndex = 0;
            txtNature.DataBind();
        }

    }
    [System.Web.Services.WebMethod]
    public static string SaveMISDetails(string cMIS, string sBriefFacts, string sStatus, string sRisk, string sRiskFav, string sCLients, string sSaveDoc)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (m_oWebInterface != null)
        {
            try
            {
                JavaScriptSerializer obj = new JavaScriptSerializer();
                var cLitMaster = obj.Deserialize<IDictionary<string, object>>(cMIS);

                //Get Hearing Details/Present status
                List<object> lHDetails = (List<object>)obj.Deserialize(sStatus, typeof(List<object>));
                List<cHearingDetail> lstHDetails = new List<cHearingDetail>();

                foreach (object objt in lHDetails)
                {
                    Dictionary<string, object> oHDetails = (Dictionary<string, object>)objt;

                    cHearingDetail cHDet = new cHearingDetail(m_oWebInterface.oWebInterface);
                    //cHDet.HearingDate = Convert.ToDateTime(oHDetails["HearingDate"].ToString());
                    //cHDet.HearingDate = DateTime.ParseExact(oHDetails["HearingDate"].ToString(), "yyyy-MM-dd", null);
                    DateTime dt = new DateTime();
                    DateTime.TryParseExact(oHDetails["HearingDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt);

                    cHDet.HearingDate = dt;
                    cHDet.Notes = oHDetails["Notes"].ToString().Replace("#11aqw", "'");
                    cHDet.PersonId = Convert.ToInt16(oHDetails["PersonId"].ToString());
                    lstHDetails.Add(cHDet);
                }
                //Get All Clients
                List<object> lstClients = (List<object>)obj.Deserialize(sCLients, typeof(List<object>));
                List<cClientDetail> lstClientDetails = new List<cClientDetail>();
                foreach (object objt in lstClients)
                {
                    Dictionary<string, object> oCDetails = (Dictionary<string, object>)objt;
                    cClientDetail cCDet = new cClientDetail(m_oWebInterface.oWebInterface);
                    cCDet.ClientId = Convert.ToInt16(oCDetails["ClientId"].ToString());
                    cCDet.ClientName = oCDetails["ClientName"].ToString();
                    cCDet.ClientTypeId = Convert.ToInt16(oCDetails["ClientTypeId"].ToString());
                    cCDet.ClientType = oCDetails["ClientType"].ToString();
                    cCDet.ClientVs = Convert.ToInt16(oCDetails["ClientVs"].ToString());
                    lstClientDetails.Add(cCDet);
                }
                //Dictionary<string, cClientDetail> EmpInfo = (Dictionary<string, cClientDetail>)lstClients[0];

                cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
                cLitigation.StageId = Convert.ToInt16(cLitMaster["Stages"].ToString());
                cLitigation.Forum = cLitMaster["Forum"].ToString();
                cLitigation.SuitNum = cLitMaster["SuitNo"].ToString();
                cLitigation.CaseTypeId = Convert.ToInt16(cLitMaster["Nature"].ToString());
                cLitigation.Vertical = cLitMaster["Vertical"].ToString();

                cLitigation.AdvocateId = Convert.ToInt16(cLitMaster["AdvId"].ToString());
                cLitigation.Advocate = cLitMaster["Adv"].ToString();

                cLitigation.FirmId = Convert.ToInt16(cLitMaster["FirmId"].ToString());
                cLitigation.FinProvision = Convert.ToBoolean(cLitMaster["FinanProv"].ToString());
                if (Convert.ToBoolean(cLitMaster["FinanProv"].ToString()))
                {
                    cLitigation.AmountPayable = Convert.ToDouble(cLitMaster["Amount"].ToString());
                    cLitigation.Amount = Convert.ToDouble(cLitMaster["AmountRecv"].ToString());
                }
                else
                {
                    cLitigation.Reason = cLitMaster["Reason"].ToString();
                }
                //if (string.IsNullOrEmpty(cLitMaster["AdvFees"].ToString()) == false)
                //{
                cLitigation.AdvFees = cLitMaster["AdvFees"].ToString();
                //}
                if (string.IsNullOrEmpty(cLitMaster["ClaimAmt"].ToString()) == false)
                {
                    cLitigation.ClaimAmount = Convert.ToDouble(cLitMaster["ClaimAmt"].ToString());
                }
                cLitigation.CaseName = cLitMaster["CaseName"].ToString();
                cLitigation.Notes = sBriefFacts.Replace("#11aqw", "'");
                //cLitigation.Status = sStatus;
                cLitigation.IsNewLaw = true;
                cLitigation.ActName = cLitMaster["LawName"].ToString();
                cLitigation.ActYear = cLitMaster["lawYear"].ToString();
                //Risk Favourable
                cLitigation.Favourable = sRiskFav.Replace("#11aqw", "'");
                cLitigation.RiskString = sRisk.Replace("#11aqw", "'");
                cLitigation.lstClientDetail = lstClientDetails;
                cLitigation.lstHearingDetail = lstHDetails;
                cLitigation.AuthPersonId = Convert.ToInt16(cLitMaster["AutPersonId"].ToString());
                cLitigation.AuthPerson = cLitMaster["AutPerson"].ToString();
                cLitigation.AuthPersonEmail = cLitMaster["AutEmail"].ToString();
                if (cLitMaster["StartDate"] != "")
                {
                    DateTime dtStart = new DateTime();
                    DateTime.TryParseExact(cLitMaster["StartDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dtStart);
                    cLitigation.StartDate = dtStart;
                }
                else
                {
                    DateTime dtStart = new DateTime();
                    DateTime.TryParseExact(DateTime.Now.ToShortDateString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dtStart);
                    cLitigation.StartDate = dtStart;
                }
                if (cLitMaster["CloseDate"] != "")
                {
                    DateTime dtClose = new DateTime();
                    DateTime.TryParseExact(cLitMaster["CloseDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dtClose);
                    cLitigation.CloseDate = dtClose;
                }
                cLitigation.ClientCtg = cLitMaster["ClientCtg"].ToString();
                cLitigation.Type = cLitMaster["sType"].ToString();
                cLitigation.MISId = cLitigation.SaveValues();
                if (sSaveDoc == "true")
                {
                    cLitigation.SaveToPDF(true);
                }
                return "Done";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        else
        {
            return "Session";
        }
    }

    [System.Web.Services.WebMethod]
    public static string UpdateMISDetails(string cMIS, string sBriefFacts, string sStatus, string sRisk, string sRiskFav, string sCLients, string sSaveDoc)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (m_oWebInterface != null)
        {
            try
            {
                JavaScriptSerializer obj = new JavaScriptSerializer();
                var cLitMaster = obj.Deserialize<IDictionary<string, object>>(cMIS);

                //Get Hearing Details/Present status
                List<object> lHDetails = (List<object>)obj.Deserialize(sStatus, typeof(List<object>));
                List<cHearingDetail> lstHDetails = new List<cHearingDetail>();

                foreach (object objt in lHDetails)
                {
                    Dictionary<string, object> oHDetails = (Dictionary<string, object>)objt;

                    cHearingDetail cHDet = new cHearingDetail(m_oWebInterface.oWebInterface);
                    //cHDet.HearingDate = Convert.ToDateTime(oHDetails["HearingDate"].ToString());
                    //cHDet.HearingDate = DateTime.ParseExact(oHDetails["HearingDate"].ToString(), "yyyy-MM-dd", null);
                    DateTime dt = new DateTime();
                    DateTime.TryParseExact(oHDetails["HearingDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt);

                    cHDet.HearingDate = dt;
                    cHDet.Notes = oHDetails["Notes"].ToString().Replace("#11aqw", "'");
                    cHDet.PersonId = Convert.ToInt16(oHDetails["PersonId"].ToString());
                    lstHDetails.Add(cHDet);
                }
                //Get All Clients
                List<object> lstClients = (List<object>)obj.Deserialize(sCLients, typeof(List<object>));
                List<cClientDetail> lstClientDetails = new List<cClientDetail>();
                foreach (object objt in lstClients)
                {
                    Dictionary<string, object> oCDetails = (Dictionary<string, object>)objt;
                    cClientDetail cCDet = new cClientDetail(m_oWebInterface.oWebInterface);
                    cCDet.ClientId = Convert.ToInt16(oCDetails["ClientId"].ToString());
                    cCDet.ClientName = oCDetails["ClientName"].ToString();
                    cCDet.ClientTypeId = Convert.ToInt16(oCDetails["ClientTypeId"].ToString());
                    cCDet.ClientType = oCDetails["ClientType"].ToString();
                    cCDet.ClientVs = Convert.ToInt16(oCDetails["ClientVs"].ToString());
                    lstClientDetails.Add(cCDet);
                }
                //Dictionary<string, cClientDetail> EmpInfo = (Dictionary<string, cClientDetail>)lstClients[0];

                cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
                cLitigation.StageId = Convert.ToInt16(cLitMaster["Stages"].ToString());
                cLitigation.Forum = cLitMaster["Forum"].ToString();
                cLitigation.SuitNum = cLitMaster["SuitNo"].ToString();
                cLitigation.CaseTypeId = Convert.ToInt16(cLitMaster["Nature"].ToString());
                cLitigation.Vertical = cLitMaster["Vertical"].ToString();
                if (string.IsNullOrEmpty(cLitMaster["AdvId"].ToString()) == false)
                {

                    cLitigation.AdvocateId = Convert.ToInt16(cLitMaster["AdvId"].ToString());
                    cLitigation.Advocate = cLitMaster["Adv"].ToString();
                    cLitigation.FirmId = Convert.ToInt16(cLitMaster["FirmId"].ToString());
                }

                cLitigation.FinProvision = Convert.ToBoolean(cLitMaster["FinanProv"].ToString());
                if (Convert.ToBoolean(cLitMaster["FinanProv"].ToString()))
                {
                    cLitigation.AmountPayable = Convert.ToDouble(cLitMaster["Amount"].ToString());
                    cLitigation.Amount = Convert.ToDouble(cLitMaster["AmountRecv"].ToString());
                }
                else
                {
                    cLitigation.Reason = cLitMaster["Reason"].ToString();
                }
                if (string.IsNullOrEmpty(cLitMaster["AdvFees"].ToString()) == false)
                {
                    cLitigation.AdvFees = cLitMaster["AdvFees"].ToString();
                }
                //11-01-15
                if (string.IsNullOrEmpty(cLitMaster["ClaimAmt"].ToString()) == false)
                {
                    cLitigation.ClaimAmount = Convert.ToDouble(cLitMaster["ClaimAmt"].ToString());
                }
                cLitigation.CaseName = cLitMaster["CaseName"].ToString();
                //To handle Single Quote
                cLitigation.Notes = sBriefFacts.Replace("#11aqw", "'");
                //cLitigation.Status = sStatus;
                cLitigation.IsNewLaw = true;
                cLitigation.ActId = Convert.ToInt16(cLitMaster["ActId"].ToString());
                cLitigation.ActName = cLitMaster["LawName"].ToString();
                cLitigation.ActYear = cLitMaster["lawYear"].ToString();
                //Risk Favourable
                cLitigation.Favourable = sRiskFav.Replace("#11aqw", "'");
                cLitigation.RiskString = sRisk.Replace("#11aqw", "'");
                cLitigation.lstClientDetail = lstClientDetails;
                cLitigation.lstHearingDetail = lstHDetails;
                cLitigation.AuthPersonId = Convert.ToInt16(cLitMaster["AutPersonId"].ToString());
                cLitigation.AuthPerson = cLitMaster["AutPerson"].ToString();
                cLitigation.AuthPersonEmail = cLitMaster["AutEmail"].ToString();
                if (cLitMaster["StartDate"] != "")
                {
                    DateTime dtStart = new DateTime();
                    DateTime.TryParseExact(cLitMaster["StartDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dtStart);
                    cLitigation.StartDate = dtStart;
                }
                if (cLitMaster["CloseDate"] != "")
                {
                    DateTime dtClose = new DateTime();
                    DateTime.TryParseExact(cLitMaster["CloseDate"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dtClose);
                    cLitigation.CloseDate = dtClose;
                }
                cLitigation.ClientCtg = cLitMaster["ClientCtg"].ToString();
                cLitigation.Type = cLitMaster["sType"].ToString();
                cLitigation.MISId = Convert.ToInt16(cLitMaster["ID"].ToString());
                cLitigation.UpdateValues();
                if (sSaveDoc == "true")
                {

                    cLitigation.SaveToPDF(false);
                }
                return "Done";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        else
        {
            return "Session";
        }
    }



    [System.Web.Services.WebMethod]
    public static List<litBindMis> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        List<litBindMis> clst = new List<litBindMis>();
        if (m_oWebInterface != null)
        {
            try
            {
                cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
                //cLitigation.LoadValues();
                //cLitigation.Get(Convert.ToInt16(Id));
                clstData = cLitigation.Get(Convert.ToInt16(Id));
                litBindMis obj = new litBindMis();
                obj.StageId = clstData[0].StageId;
                obj.Forum = clstData[0].Forum;
                obj.SuitNum = clstData[0].SuitNum;
                obj.CaseName = clstData[0].CaseName;

                obj.CaseTypeId = clstData[0].CaseTypeId;//Nature
                obj.Vertical = clstData[0].Vertical;
                //obj.ClientType1 = clstData[0].ClientType1;
                //obj.ClientId1 = clstData[0].ClientId1;
                obj.AdvocateId = clstData[0].AdvocateId;
                obj.Advocate = clstData[0].Advocate;
                obj.FirmId = clstData[0].FirmId;
                obj.AuthPersonId = clstData[0].AuthPersonId;
                //obj.ClientType2 = clstData[0].ClientType2;
                obj.AuthPerson = clstData[0].AuthPerson;
                obj.AuthPersonEmail = clstData[0].AuthPersonEmail;

                obj.FinProvision = clstData[0].FinProvision;
                obj.Amount = clstData[0].Amount;
                obj.AmountPay = clstData[0].AmountPayable;
                obj.Reason = clstData[0].Reason;
                obj.ActId = clstData[0].ActId;
                obj.ActName = clstData[0].ActName;
                obj.ActYear = clstData[0].ActYear;
                obj.AdvFeesAgr = clstData[0].AdvFees;
                if (clstData[0].StartDate.Year != 1)
                    obj.startDate = clstData[0].StartDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                if (clstData[0].CloseDate.Year != 1)
                    obj.CloseDate = clstData[0].CloseDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                obj.CltCtg = clstData[0].ClientCtg;
                obj.cType = clstData[0].Type;
                obj.ClaimAmount = clstData[0].ClaimAmount;
                obj.ErrorMsg = "Done";
                clst.Add(obj);
                return clst;
            }
            catch (Exception ex)
            {
                litBindMis obj = new litBindMis();
                obj.ErrorMsg = "Done";
                clst.Add(obj);
                return clst;
            }
        }
        else
        {
            litBindMis obj = new litBindMis();
            obj.ErrorMsg = "Session";
            clst.Add(obj);
            return clst;
        }
    }
    public static List<cLitigationMaster> clstData = new List<cLitigationMaster>();
    [System.Web.Services.WebMethod]
    public static string LoadStrings(string Id, string sMisId)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
        cLitigation.LoadValues();
        //cLitigation.Get(Convert.ToInt16(Id));
        if (clstData.Count == 0)
        {
            clstData = cLitigation.Get(Convert.ToInt16(sMisId));
        }
        if (Id == "Notes")
        {
            return clstData[0].Notes;
        }
        if (Id == "Status")
        {
            //return clstData[0].Status;
        }
        if (Id == "Risk")
        {
            return clstData[0].RiskString;
        }
        if (Id == "Favs")
        {
            return clstData[0].Favourable;
        }
        return null;
    }
    [System.Web.Services.WebMethod]
    public static List<cEmailOption> GetAllEmails(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cEmailOption cEmails = new cEmailOption(m_oWebInterface.oWebInterface);
        cEmails.LoadValues();
        //cEmails.Find(Convert.ToInt16(Id));
        return cEmails.Find(Convert.ToInt16(Id));
    }

    [System.Web.Services.WebMethod]
    public static List<Document> GetAllDocuments(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cDocument cEmails = new cDocument(m_oWebInterface.oWebInterface);
        //cEmails.LoadValues();  
        List<cDocument> lstDocs = new List<cDocument>();
        lstDocs = cEmails.Get(Convert.ToInt16(Id));
        List<Document> lstRetur = new List<Document>();
        foreach (cDocument oDoc in lstDocs)
        {
            Document cDoc = new Document();
            cDoc.MISId = oDoc.MISId;
            cDoc.DocId = oDoc.DocId;
            cDoc.DocumentName = oDoc.DocumentName;
            cDoc.UploadedOn = oDoc.Uploaded.ToString("dd/MM/yyyy  H:mm:ss", CultureInfo.InvariantCulture);
            lstRetur.Add(cDoc);
        }
        return lstRetur;
    }

    [System.Web.Services.WebMethod]
    public static List<cClientDtl> GetAllClients(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cClientDetail cEmails = new cClientDetail(m_oWebInterface.oWebInterface);
        List<cClientDetail> cList = new List<cClientDetail>();
        List<cClientDtl> cListReturn = new List<cClientDtl>();
        cList = cEmails.Find(Convert.ToInt16(Id));
        foreach (cClientDetail oCd in cList)
        {
            cClientDtl oCObj = new cClientDtl();
            oCObj.ClientId = oCd.ClientId;
            oCObj.ClientName = oCd.ClientName;
            oCObj.ClientType = oCd.ClientType;
            oCObj.ClientTypeId = oCd.ClientTypeId;
            oCObj.ClientVs = oCd.ClientVs;
            oCObj.MISId = oCd.MISId;
            if (oCd.ClientVs == 1)
            {
                oCObj.Client = "Client1";
            }
            else
            {
                oCObj.Client = "Client2";
            }
            oCObj.Vertical = oCd.Vertical;
            cListReturn.Add(oCObj);
        }
        return cListReturn;
    }
    [System.Web.Services.WebMethod]
    public static List<cHDetails> GetAllHDetails(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cHearingDetail cEmails = new cHearingDetail(m_oWebInterface.oWebInterface);
        List<cHearingDetail> lstData = cEmails.Find(Convert.ToInt16(Id));
        List<cHDetails> lstReturn = new List<cHDetails>();
        foreach (cHearingDetail oHd in lstData)
        {
            cHDetails cHd = new cHDetails();
            cHd.HearingDate = oHd.HearingDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
            cHd.Notes = oHd.Notes;
            cHd.PersonId = oHd.PersonId;
            cHd.HrdId = oHd.HrdId;
            lstReturn.Add(cHd);
        }
        return lstReturn;
    }
    [System.Web.Services.WebMethod]
    public static String SaveDoc(string filePath, string MisId)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (m_oWebInterface != null)
        {
            try
            {
                // Read the file and convert it to Byte Array                
                string filename = Path.GetFileName(filePath);
                string ext = Path.GetExtension(filename);
                string contenttype = String.Empty;
                HttpFileCollection fileCollection = HttpContext.Current.Request.Files;
                var postedFile = fileCollection[0];
                //Set the contenttype based on File Extension
                switch (ext)
                {
                    case ".doc":
                        contenttype = "application/vnd.ms-word";
                        break;
                    case ".docx":
                        contenttype = "application/vnd.ms-word";
                        break;
                    case ".xls":
                        contenttype = "application/vnd.ms-excel";
                        break;
                    case ".xlsx":
                        contenttype = "application/vnd.ms-excel";
                        break;
                    case ".jpg":
                        contenttype = "image/jpg";
                        break;
                    case ".png":
                        contenttype = "image/png";
                        break;
                    case ".gif":
                        contenttype = "image/gif";
                        break;
                    case ".pdf":
                        contenttype = "application/pdf";
                        break;
                }
                if (contenttype != String.Empty)
                {
                    //Stream fs = postedFile.InputStream;
                    //BinaryReader br = new BinaryReader(fs);
                    //Byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    //cDocument cDocs = new cDocument(m_oWebInterface.oWebInterface);
                    //cDocs.DocumentName = filename;
                    //cDocs.Content = bytes;
                    //cDocs.MISId =Convert.ToInt16( MisId);
                    //cDocs.SaveValues();
                }
                else
                {

                }
                return "Done";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        else
        {
            return "Session";
        }

        //return cLitigation.lstData;
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds, string Lit)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cDocument Adv = new cDocument(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "")
            {

                Adv.DeleteDocuments(Convert.ToInt16(Lit), Convert.ToInt16(id));
            }
        }
    }

}

public class litBindMis
{
    public string ErrorMsg { get; set; }
    public int MISId { get; set; }
    public string CaseName { get; set; }
    public string SuitNum { get; set; }
    public string Forum { get; set; }
    public string Vertical { get; set; }
    public int CaseTypeId { get; set; }
    public int FirmId { get; set; }
    public int AuthPersonId { get; set; }
    public string AuthEmail { get; set; }
    public int StageId { get; set; }

    public int ClientId2 { get; set; }
    public string sClient2 { get; set; }
    public int ClientType2 { get; set; }
    public bool FinProvision { get; set; }
    public double Amount { get; set; }
    public double AmountPay { get; set; }
    public string AdvFeesAgr { get; set; }
    public double ClaimAmount { get; set; }
    public string Reason { get; set; }
    public string ActName { get; set; }
    public string ActYear { get; set; }
    public int AdvocateId { get; set; }
    public int ActId { get; set; }

    public string AuthPerson { get; set; }
    public string AuthPersonEmail { get; set; }
    public string Advocate { get; set; }
    public string AdvEmail { get; set; }
    public string startDate { get; set; }
    public string CloseDate { get; set; }
    public string CltCtg { get; set; }
    public string cType { get; set; }
}
public class Document
{
    public string DocumentName { get; set; }
    public int MISId { get; set; }
    public int DocId { get; set; }
    public string UploadedOn { get; set; }
}
public class cClientDtl
{
    public string ClientName { get; set; }
    public string ClientType { get; set; }
    public string Client { get; set; }
    public int ClientVs { get; set; }
    public int ClientId { get; set; }
    public int ClientTypeId { get; set; }
    public int MISId { get; set; }
    public string Vertical { get; set; }
}
public class cHDetails
{
    public string HearingDate { get; set; }
    public string Notes { get; set; }
    public int PersonId { get; set; }
    public int HrdId { get; set; }
}