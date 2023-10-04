using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using LitigationMaster;
using System.Data;
public partial class AdvocateDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static void SaveAdvocateDetails(string cAdvocate)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cAdv = obj.Deserialize<IDictionary<string, object>>(cAdvocate);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAdvocate oAdvocate = new LitigationMaster.cAdvocate(m_oWebInterface.oWebInterface);
        //m_oWebInterface.oWebInterface.Advocate oAdv = new LitigationMaster.cAdvocate(m_oWebInterface);
        oAdvocate.AdvName = cAdv["Fname"].ToString();
        //oAdvocate.LastName = cAdv["Lname"].ToString();
        oAdvocate.FirmId =Convert.ToInt16( cAdv["Forum"].ToString());       
        
        oAdvocate.mobile = cAdv["MobNo"].ToString();        
        oAdvocate.EmailId = cAdv["EmailId"].ToString();
        oAdvocate.AOfExperties = cAdv["AOExp"].ToString();
        oAdvocate.SaveValues();

    }

    [System.Web.Services.WebMethod]
    public static List<cAdvocate> LoadData(string Id)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAdvocate oAdvocate = new LitigationMaster.cAdvocate(m_oWebInterface.oWebInterface);
        return oAdvocate.Get(Convert.ToInt16(Id));
    }
    [System.Web.Services.WebMethod]
    public static string LoadAllData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAdvocate oAdvocate = new LitigationMaster.cAdvocate(m_oWebInterface.oWebInterface);
        oAdvocate.LoadValues();
        return ConvertToString(oAdvocate.dtAdvocate);
    }
    [System.Web.Services.WebMethod]
    public static void UpdateAdvocateDetails(string cAdvocate)
    {
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cAdv = obj.Deserialize<IDictionary<string, object>>(cAdvocate);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cAdvocate oAdvocate = new LitigationMaster.cAdvocate(m_oWebInterface.oWebInterface);
        //m_oWebInterface.oWebInterface.Advocate oAdv = new LitigationMaster.cAdvocate(m_oWebInterface);
        oAdvocate.AdvName = cAdv["Fname"].ToString();
        //oAdvocate.LastName = cAdv["Lname"].ToString();
        oAdvocate.FirmId = Convert.ToInt16(cAdv["Forum"].ToString());

        oAdvocate.mobile = cAdv["MobNo"].ToString();
        oAdvocate.EmailId = cAdv["EmailId"].ToString();
        oAdvocate.AOfExperties = cAdv["AOExp"].ToString();

        oAdvocate.AdvocateId = Convert.ToInt16(cAdv["AdvId"].ToString());
        oAdvocate.UpdateValues();

    }

    public static string ConvertToString(DataTable odt)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in odt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in odt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }
        return serializer.Serialize(rows);
    }
}