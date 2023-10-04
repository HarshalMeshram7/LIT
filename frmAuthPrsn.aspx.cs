using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using LitigationMaster;

public partial class frmAuthPrsn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static void SaveAdvocateDetails(string cPerson)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cAdv = obj.Deserialize<IDictionary<string, object>>(cPerson);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAuthPerson oAPerson = new LitigationMaster.cAuthPerson(m_oWebInterface.oWebInterface);
        //m_oWebInterface.oWebInterface.Advocate oAdv = new LitigationMaster.cAdvocate(m_oWebInterface);
        oAPerson.Name = cAdv["Fname"].ToString();
        //oAdvocate.LastName = cAdv["Lname"].ToString();
        oAPerson.PhoneNumber = cAdv["MobNo"].ToString();
        oAPerson.Address = cAdv["Addr"].ToString();
        oAPerson.EmailId = cAdv["EmailId"].ToString();
        oAPerson.SaveValues();

    }

    [System.Web.Services.WebMethod]
    public static List<cAuthPerson> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAuthPerson oAdvocate = new LitigationMaster.cAuthPerson(m_oWebInterface.oWebInterface);
        return oAdvocate.Get(Convert.ToInt16(Id));
    }

    [System.Web.Services.WebMethod]
    public static void UpdateAdvocateDetails(string cPerson)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cAdv = obj.Deserialize<IDictionary<string, object>>(cPerson);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAuthPerson oAPerson = new LitigationMaster.cAuthPerson(m_oWebInterface.oWebInterface);
        //m_oWebInterface.oWebInterface.Advocate oAdv = new LitigationMaster.cAdvocate(m_oWebInterface);
        oAPerson.Name = cAdv["Fname"].ToString();
        
        oAPerson.Address = cAdv["Addr"].ToString();
        oAPerson.PhoneNumber = cAdv["MobNo"].ToString();
        oAPerson.EmailId = cAdv["EmailId"].ToString();
        oAPerson.PersonId = Convert.ToInt16(cAdv["Id"].ToString());
        oAPerson.UpdateValues();

    }

}