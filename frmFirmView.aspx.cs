using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class frmFirmView : System.Web.UI.Page
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
    public static List<cFirmDetail> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cFirmDetail Firm = new cFirmDetail(m_oWebInterface.oWebInterface);       
        List<cFirmDetail> lstFirm = new List<cFirmDetail>();
        lstFirm = Firm.Get();
        return lstFirm;
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cFirmDetail Firm = new cFirmDetail(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "" && id != "undefined")
            {
                Firm.FirmId = Convert.ToInt16(id);
                Firm.DeleteFirm(Convert.ToInt16(id));
            }
        }
    }
}