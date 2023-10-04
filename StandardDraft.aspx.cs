using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class StandardDraft : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static List<Document> LoadData(string cType)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cStanderdDraft oStandard = new cStanderdDraft(m_oWebInterface.oWebInterface);
        List<cStanderdDraft> oList = new List<cStanderdDraft>();
        oList = oStandard.Get(Convert.ToInt16(cType));
        //DataTable oDtType = oStandard.LoadServiceType();
        List<Document> lstRetur = new List<Document>();
        foreach (cStanderdDraft oDoc in oList)
        {
            Document cDoc = new Document();
            cDoc.ServiceId = oDoc.ServiceId.ToString();
            cDoc.DocId = oDoc.DocId.ToString();
            //cDoc.ServiceType = oDtType.Select("wServiceId =" + oDoc.ServiceId.ToString())[0][1].ToString();
            cDoc.DocumentName = oDoc.DocumentName;
            lstRetur.Add(cDoc);
        }

        return lstRetur;
    }
    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds, string Lit)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cStanderdDraft oDocs = new cStanderdDraft(m_oWebInterface.oWebInterface);

        oDocs.DeleteDocuments(cIds.Replace('@', ','));

    }
    public class Document
    {
        public string DocumentName { get; set; }
        public string ServiceType { get; set; }
        public string ServiceId { get; set; }
        public string DocId { get; set; }
    }
}