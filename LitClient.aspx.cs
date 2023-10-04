using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using LitigationMaster;

public partial class LitClient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
            cVertical oVer = new cVertical(m_oWebInterface.oWebInterface);
            ddlVertical.DataSource = oVer.LoadValues();
            ddlVertical.DataTextField = "sVertical";
            ddlVertical.DataValueField = "wVerticalId";
            ddlVertical.DataBind();
            //ddlVertical.Items.Add(new ListItem("None", "-1"));
            //ddlVertical.SelectedValue = "-1";
        }
    }
    [System.Web.Services.WebMethod]
    public static void SaveClientDetails(string cClient, string Addrrs)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cLitClient = obj.Deserialize<IDictionary<string, object>>(cClient);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cLITClient cClnt = new LitigationMaster.cLITClient(m_oWebInterface.oWebInterface);
        //cClnt.Address = cLitClient["Addr"].ToString();
        cClnt.Address = Addrrs;
        cClnt.ClientName = cLitClient["Name"].ToString();
        cClnt.City = cLitClient["City"].ToString();
        cClnt.State = cLitClient["State"].ToString();
        cClnt.Mobile = cLitClient["MobNo"].ToString();
        cClnt.Phone = cLitClient["PhoneNo"].ToString();
        cClnt.Email = cLitClient["EmailId"].ToString();
        cClnt.VerticalId = Convert.ToInt16(cLitClient["Vertical"].ToString());
        cClnt.SaveValues();

    }


    [System.Web.Services.WebMethod]
    public static void UpdateClientDetails(string cClient, string Addrrs)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cLitClient = obj.Deserialize<IDictionary<string, object>>(cClient);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cLITClient cClnt = new LitigationMaster.cLITClient(m_oWebInterface.oWebInterface);
        //cClnt.Address = cLitClient["Addr"].ToString();
        cClnt.Address = Addrrs;
        cClnt.ClientName = cLitClient["Name"].ToString();
        cClnt.City = cLitClient["City"].ToString();
        cClnt.State = cLitClient["State"].ToString();
        cClnt.Mobile = cLitClient["MobNo"].ToString();
        cClnt.Phone = cLitClient["PhoneNo"].ToString();
        cClnt.Email = cLitClient["EmailId"].ToString();
        cClnt.ClientId = Convert.ToInt16(cLitClient["ID"].ToString());
        cClnt.VerticalId = Convert.ToInt16(cLitClient["Vertical"].ToString());
        cClnt.UpdateValues();

    }


    [System.Web.Services.WebMethod]
    public static List<LitigationMaster.cLITClient> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cLITClient Client = new LitigationMaster.cLITClient(m_oWebInterface.oWebInterface);
        Client.LoadValues();

        DataRow[] DtClient = Client.dtClient.Select("wClientId =" + Id);
        List<cLITClient> lstClient = new List<cLITClient>();
        foreach (DataRow dr in DtClient)
        {
            cLITClient oClient = new cLITClient(m_oWebInterface.oWebInterface);
            oClient.ClientName = dr["sClientName"].ToString();
            oClient.Address = dr["sAddress"].ToString();
            oClient.City = dr["sCity"].ToString();
            oClient.State = dr["sState"].ToString();
            oClient.ClientId = Convert.ToInt16(dr["wClientId"].ToString());
            oClient.Mobile = dr["sMobile"].ToString();
            oClient.Phone = dr["sPhone"].ToString();
            oClient.Email = dr["sEmail"].ToString();
            oClient.VerticalId = Convert.ToInt16(dr["wVerticalId"].ToString());
            lstClient.Add(oClient);
        }
        return lstClient;       
    }
}