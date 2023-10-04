using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;

public partial class frmDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
            if (Request.QueryString["sPage"].ToString() == "MIS")
            {
                cDocument cDocs = new cDocument(m_oWebInterface.oWebInterface);
                List<cDocument> lstDocs = new List<cDocument>();
                lstDocs = cDocs.Get(Convert.ToInt16(Request.QueryString["Data"].ToString().Split('@')[1]), Convert.ToInt16(Request.QueryString["Data"].ToString().Split('@')[0]));
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + lstDocs[0].DocumentName);     // to open file prompt Box open or Save file         
                Response.BinaryWrite(lstDocs[0].Content);
            }
            else
            {
                cStanderdDraft oStandard = new cStanderdDraft(m_oWebInterface.oWebInterface);
                List<cStanderdDraft> oList = new List<cStanderdDraft>();
                oList = oStandard.GetDocs(Convert.ToInt16(Request.QueryString["Data"].ToString()));
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + oList[0].DocumentName);     // to open file prompt Box open or Save file         
                Response.BinaryWrite(oList[0].Content);
            }
            Response.Charset = "";
            Response.ContentType = "pdf";
            Response.Buffer = true;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);          
            Response.End();
            ////Page.ClientScript.RegisterOnSubmitStatement(typeof(Page), "closePage", "window.onunload = CloseWindow();");
            ClientScript.RegisterStartupScript(this.GetType(), "Payroll", "<script type='text/javascript'>CloseWindow();</script>");

        }
    }
}