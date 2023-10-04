using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;

public partial class AuthView : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();

    protected void Page_Load(object sender, EventArgs e)
    {
        m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (!IsPostBack)
        {
            //loadGrid();
        }
    }


    [System.Web.Services.WebMethod]
    public static List<cAuthPerson> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAuthPerson Firm = new cAuthPerson(m_oWebInterface.oWebInterface);
        List<cAuthPerson> lstFirm = new List<cAuthPerson>();
        lstFirm = Firm.Get();
        return lstFirm;
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAuthPerson Firm = new cAuthPerson(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "" && id != "undefined")
            {
                Firm.PersonId = Convert.ToInt16(id);
                Firm.DeletePerson(Convert.ToInt16(id));
            }
        }
    }
}