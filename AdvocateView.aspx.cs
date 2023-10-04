using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class Styles_AdvocateView : System.Web.UI.Page
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
    public void loadGrid()
    {
        //cAdvocate oAdvocate = new cAdvocate(m_oWebInterface.oWebInterface);
        //oAdvocate.LoadValues();
        //grdAdvocate.DataSource = oAdvocate.dtAdvocate;
        //grdAdvocate.DataBind();
    }
    [System.Web.Services.WebMethod]
    public static List<cAdvocate> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAdvocate oAdvocate = new cAdvocate(m_oWebInterface.oWebInterface);
       
        return oAdvocate.Get();
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAdvocate Adv = new cAdvocate(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "" && id != "undefined")
            {
                Adv.AdvocateId = Convert.ToInt16(id);
                Adv.DeleteAdvocate(Convert.ToInt16(id));
            }
        }
    }
}