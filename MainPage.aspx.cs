using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class MainPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (m_oWebInterface == null)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ReLogIn", "<script type='text/javascript'>$(window).attr('location', 'LogIn.aspx');</script>");
        }
        else
        {
            hdnAdminLevel.Value = m_oWebInterface.oWebInterface.User.AdminLevel.ToString();
            A3.InnerHtml = A3.InnerHtml.Replace("User","Hi "+ m_oWebInterface.oWebInterface.User.UserName);
            cPreferences oPreff = new cPreferences(m_oWebInterface.oWebInterface);
            DataTable dtPreff = oPreff.LoadValues();
            if (dtPreff.Rows.Count > 0)
            {
                DataRow[] dr = dtPreff.Select("sPrefID = 'smtp'");
                if (dr.Length > 0)
                    hdnPreff.Value = "true";
            }
        }
    }
}