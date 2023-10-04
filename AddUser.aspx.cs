using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;

public partial class AddUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static void SaveUser(string sUserName, string sPassword, string sAccessRight, string wAdmin, string sEmail)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        //cUsers oUser = new cUsers(m_oWebInterface.oWebInterface);
        m_oWebInterface.oWebInterface.Users.UserName = sUserName;
        m_oWebInterface.oWebInterface.Users.UserPassword = sPassword;
        m_oWebInterface.oWebInterface.Users.UserAccessRights = sAccessRight;
        m_oWebInterface.oWebInterface.Users.AdminLevel = Convert.ToInt16(wAdmin);
        m_oWebInterface.oWebInterface.Users.UserEmail = sEmail;
        m_oWebInterface.oWebInterface.Users.SaveValues(m_oWebInterface);
    }
    [System.Web.Services.WebMethod]
    public static bool CheckUserExist(string sUserName)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        //cUsers oUser = new cUsers(m_oWebInterface.oWebInterface);
        return m_oWebInterface.oWebInterface.Users.Exists(sUserName, m_oWebInterface);
    }
}