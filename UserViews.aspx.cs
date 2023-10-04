using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;
public partial class UserViews : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod]
    public static string GetList()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cUser oUser = m_oWebInterface.oWebInterface.User;
        return oUser.Get(m_oWebInterface.oWebInterface);
    }

    [System.Web.Services.WebMethod]
    public static string DeleteData(string cIds)
    {
        try
        {
            LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
            string sSql;
            sSql = "Delete from UserLogin Where wUserId in (" + cIds + ")";
            m_oWebInterface.oWebInterface.oDatabase.Execute(sSql);
            //m_oWebInterface.oWebInterface.Users.ReloadValues();
            return "Done";
        }
        catch (Exception ex)
        {
            throw;
        }

    }
}