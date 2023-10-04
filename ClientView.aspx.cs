using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class ClientView : System.Web.UI.Page
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
    public static List<cLITClient> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLITClient Client = new cLITClient(m_oWebInterface.oWebInterface);
        Client.LoadValues();
        DataTable DtClient = Client.dtClient;
        List<cLITClient> lstClient = new List<cLITClient>();
        foreach (DataRow dr in DtClient.Rows)
        {
            cLITClient oClient = new cLITClient(m_oWebInterface.oWebInterface);
            oClient.ClientName = dr["sClientName"].ToString();
            oClient.Address = dr["sAddress"].ToString();           
            oClient.City = dr["sCity"].ToString();
            oClient.State = dr["sState"].ToString();
            oClient.ClientId = Convert.ToInt16(dr["wClientId"].ToString());
            oClient.Mobile = dr["sMobile"].ToString();
            oClient.Vertical = dr["sVertical"].ToString();
            lstClient.Add(oClient);
        }
        return lstClient;
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLITClient Client = new cLITClient(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "" && id != "undefined")
            {
                Client.ClientId = Convert.ToInt16(id);
                Client.DeleteClient(Convert.ToInt16(id));
            }
        }        
    }
}