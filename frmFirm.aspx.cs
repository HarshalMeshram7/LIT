using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using LitigationMaster;
using System.Data;


public partial class frmFirm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
       
    [System.Web.Services.WebMethod]
    public static void SaveFirmDetails(string cFirm)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cfirm = obj.Deserialize<IDictionary<string, object>>(cFirm);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cFirmDetail oAdvocate = new LitigationMaster.cFirmDetail(m_oWebInterface.oWebInterface);
        //m_oWebInterface.oWebInterface.Advocate oAdv = new LitigationMaster.cAdvocate(m_oWebInterface);
       
        oAdvocate.FirmName = cfirm["Fname"].ToString();

        oAdvocate.Address = cfirm["Addr"].ToString();
        oAdvocate.City = cfirm["City"].ToString();
        oAdvocate.State = cfirm["State"].ToString();
        oAdvocate.mobile = cfirm["MobNo"].ToString();
        oAdvocate.PhoneNumber = cfirm["PhoneNo"].ToString();
        oAdvocate.EmailId = cfirm["EmailId"].ToString();
        oAdvocate.SaveValues();

    }

    [System.Web.Services.WebMethod]
    public static List<cFirmDetail> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cFirmDetail oAdvocate = new LitigationMaster.cFirmDetail(m_oWebInterface.oWebInterface);


        return oAdvocate.Get(Convert.ToInt16(Id));
    }

    [System.Web.Services.WebMethod]
    public static void UpdateFirmDetails(string cFirm)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cAdv = obj.Deserialize<IDictionary<string, object>>(cFirm);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cFirmDetail oAdvocate = new LitigationMaster.cFirmDetail(m_oWebInterface.oWebInterface);

        oAdvocate.FirmName = cAdv["Fname"].ToString();

        oAdvocate.Address = cAdv["Addr"].ToString();
        oAdvocate.City = cAdv["City"].ToString();
        oAdvocate.State = cAdv["State"].ToString();
        oAdvocate.mobile = cAdv["MobNo"].ToString();
        oAdvocate.PhoneNumber = cAdv["PhoneNo"].ToString();
        oAdvocate.EmailId = cAdv["EmailId"].ToString();
        oAdvocate.FirmId = Convert.ToInt16(cAdv["FirmId"].ToString());
        oAdvocate.UpdateValues();

    }

}