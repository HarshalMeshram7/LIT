using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class LogIn : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region "WebMethods"
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string CheckUserLogin(string sUserName, string sPassWord)
    {
        string sErrorMsg = string.Empty;
        string sBrowserversion = string.Empty;
        try
        {
            LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();

            string errmsg = null;
            m_oWebInterface.Login(sUserName, sPassWord, ref errmsg);
           
            System.Web.HttpBrowserCapabilities browser = HttpContext.Current.Request.Browser;
            sBrowserversion = browser.Browser + " " + browser.Version;
            HttpContext.Current.Session["oWebInterface"] = m_oWebInterface;     
            return errmsg;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string SendPass(string sUserName)
    {
        string sErrorMsg = string.Empty;
        string sBrowserversion = string.Empty;
        try
        {
            LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();

            string errmsg = null;            

            DatabaseAccess.net.cDatabaseDisconnect oDatabase = default(DatabaseAccess.net.cDatabaseDisconnect);
           
            //m_oWebInterface.Login(sUserName, ref errmsg);
            //LitigationMaster.cUsers oCuser = new LitigationMaster.cUsers();
            //DataTable dtEmail = oCuser.GetPassword(sUserName,ref m_oWebInterface);
            //if (dtEmail.Rows.Count > 0)
            //{
            //    string sMsg = "User Name :" + sUserName;
            //    sMsg = sMsg + "; Password:" + dtEmail.Rows[0][0].ToString();

            //    LitigationMaster.cEmailOption oEmailClient = new LitigationMaster.cEmailOption(m_oWebInterface.oWebInterface);
            //    oEmailClient.EmailTo = dtEmail.Rows[0][1].ToString();
            //    oEmailClient.Subject = "Authentication detail for Litigation Master.";
            //    oEmailClient.Text = sMsg;
            //    oEmailClient.SendMessageDetail(ref sMsg,false);
            //    errmsg = "Check your mail for Authentication details.";
            //}
            //else
            //{
            //    errmsg = "Invalid User name!";
            //}
            return errmsg;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    #endregion
}