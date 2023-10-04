using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class frmPreff : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cUser oUser = m_oWebInterface.oWebInterface.User;
        string sql = "select * from UserLogin where wUserId='" + oUser.UserId + "' ";
        DataTable dtUser;
        if (Request.QueryString["UserId"].ToString() != "-1")
        {
            hdnUser.Value = Request.QueryString["UserId"].ToString();
            sql = "select * from UserLogin where wUserId='" + Request.QueryString["UserId"].ToString() + "' ";
        }
        //else
        //    hdnUser.Value = oUser.UserId.ToString();

        dtUser = m_oWebInterface.oWebInterface.oDatabase.Database.GetDataTable(sql);
        lgdUser.InnerText = lgdUser.InnerText + dtUser.Rows[0]["sUserName"].ToString();
        Session["dtUser"] = dtUser;
    }

    [System.Web.Services.WebMethod]
    public static List<Preff> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cUser oUser = m_oWebInterface.oWebInterface.User;
        DataTable dtUser = (DataTable)HttpContext.Current.Session["dtUser"];
        LitigationMaster.cUsers cUsers = new cUsers();
        List<Preff> olstPreff = new List<Preff>();
        Preff oPreffff = new Preff();
        if (dtUser.Rows.Count > 0)
        {
            oPreffff.UserName = oUser.UserName;
            oPreffff.UserPassword = dtUser.Rows[0]["sUserPassword"].ToString();
            oPreffff.UserEmail = dtUser.Rows[0]["sEmailId"].ToString();
            oPreffff.AdminLevel = dtUser.Rows[0]["wAdminLevel"].ToString();
            m_oWebInterface.oWebInterface.User.UserId = Convert.ToInt16(dtUser.Rows[0]["wUserId"].ToString());
        }
        cPreferences oPreff = new cPreferences(m_oWebInterface.oWebInterface);
        DataTable dtPreff = oPreff.LoadValues();
        if (dtPreff.Rows.Count > 0)
        {
            oPreffff.smtp = dtPreff.Select("sPrefID = 'smtp'")[0][1].ToString();
            oPreffff.preffEmail = dtPreff.Select("sPrefID = 'EmailUser'")[0][1].ToString();
            oPreffff.port = dtPreff.Select("sPrefID = 'port'")[0][1].ToString();
            oPreffff.password = dtPreff.Select("sPrefID = 'Password'")[0][1].ToString();
            oPreffff.isUpd = true;
        }
        else
            oPreffff.isUpd = false;
        olstPreff.Add(oPreffff);
        HttpContext.Current.Session["dtUser"] = null;
        return olstPreff;
    }


    [System.Web.Services.WebMethod]
    public static LitigationMaster.cUsers UpdateUser(string sPassword, string sEmail, string sLevel, string sAdminLevel)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cUsers cUsers = new cUsers();
        int iUserId = m_oWebInterface.oWebInterface.User.UserId;
        //string sql = "Update UserLogin set sUserPassword='" + sPassword + "' , sEmailId='" + sEmail;
        string sql = "Update UserLogin set  sEmailId='" + sEmail;
        sql = sql + "' , sUserAccessRights = '" + sAdminLevel + "' , wAdminLevel =" + sLevel + " where  wUserId='" + iUserId + "'";
        m_oWebInterface.oWebInterface.oDatabase.Execute(sql);
        cUsers.UserPassword = sPassword;
        cUsers.UserEmail = sEmail;
        m_oWebInterface.oWebInterface.User.UserPassword = sPassword;
        return cUsers;
    }

    [System.Web.Services.WebMethod]
    public static void UpdatePreff(string sSmtp, string sEmail, string sPort, string sPassword, string isUpdate)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cPreferences cPreffr = new cPreferences(m_oWebInterface.oWebInterface);
        cPreffr.PrefId = "smtp";
        cPreffr.PrefInfo = sSmtp;
        if (isUpdate == "false")
            cPreffr.SaveValues();
        else
            cPreffr.UpdateValues();

        cPreffr.PrefId = "EmailUser";
        cPreffr.PrefInfo = sEmail;
        if (isUpdate == "false")
            cPreffr.SaveValues();
        else
            cPreffr.UpdateValues();

        cPreffr.PrefId = "port";
        cPreffr.PrefInfo = sPort;
        if (isUpdate == "false")
            cPreffr.SaveValues();
        else
            cPreffr.UpdateValues();

        cPreffr.PrefId = "Password";
        cPreffr.PrefInfo = sPassword;
        if (isUpdate == "false")
            cPreffr.SaveValues();
        else
            cPreffr.UpdateValues();
    }
}
public class Preff
{
    //User Setting
    public string UserName { get; set; }
    public string UserEmail { get; set; }
    public string UserPassword { get; set; }
    public string AdminLevel { get; set; }

    //User Prefference
    public string EmailID { get; set; }
    public string CurrPassword { get; set; }
    public string smtp { get; set; }
    public string port { get; set; }
    public string password { get; set; }
    public string preffEmail { get; set; }
    public bool isUpd { get; set; }
}