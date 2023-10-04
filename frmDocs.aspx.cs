using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using LitigationMaster;

public partial class frmDocs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        AsyncFileUpload1.UploadedComplete += new EventHandler<AsyncFileUploadEventArgs>(AsyncFileUpload1_UploadedComplete);
        AsyncFileUpload1.UploadedFileError += new EventHandler<AsyncFileUploadEventArgs>(AsyncFileUpload1_UploadedFileError);
    }

    void AsyncFileUpload1_UploadedComplete(object sender, AsyncFileUploadEventArgs e)
    {
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "size", "top.$get(\"" + uploadResult.ClientID + "\").innerHTML = 'Uploaded size: " + AsyncFileUpload1.FileBytes.Length.ToString() + "';", true);

        // Uncomment to save to AsyncFileUpload\Uploads folder.
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cDocument oDoc = new cDocument(m_oWebInterface.oWebInterface);
        oDoc.DocumentName = e.filename;
        oDoc.MISId = Convert.ToInt16(Request.QueryString["LitId"].ToString().Split('_')[2]);
        oDoc.Content = AsyncFileUpload1.FileBytes;
        oDoc.SaveValues();
    }

    void AsyncFileUpload1_UploadedFileError(object sender, AsyncFileUploadEventArgs e)
    {
        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error", "top.$get(\"" + uploadResult.ClientID + "\").innerHTML = 'Error: " + e.StatusMessage + "';", true);
    }
}