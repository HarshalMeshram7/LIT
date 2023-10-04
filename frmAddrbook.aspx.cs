using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Web.Script.Serialization;

public partial class frmAddrbook : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static void Save(string sName, string sEmail, string sJob, string sComp, string sPhone)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAddressBook oCon = new cAddressBook(m_oWebInterface.oWebInterface);

        oCon.Name = sName;
        oCon.Email = sEmail;
        oCon.Job = sJob;
        oCon.Company = sComp;
        oCon.Phone = sPhone;
        oCon.SaveValues();
    }
    [System.Web.Services.WebMethod]
    public static List<cAddressBook> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAddressBook oAdvocate = new LitigationMaster.cAddressBook(m_oWebInterface.oWebInterface);
        return oAdvocate.Get(Convert.ToInt16(Id));
    }

    [System.Web.Services.WebMethod]
    public static void UpdateDetails(string sName, string sEmail, string sJob, string sComp, string sPhone, string sId)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAddressBook oCon = new cAddressBook(m_oWebInterface.oWebInterface);

        oCon.Name = sName;
        oCon.Email = sEmail;
        oCon.Job = sJob;
        oCon.Company = sComp;
        oCon.Phone = sPhone;
        oCon.ConId = Convert.ToInt32(sId);
        oCon.UpdateValues();
    }

}