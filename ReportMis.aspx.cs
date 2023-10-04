using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class Styles_ReportMis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    [System.Web.Services.WebMethod]
    public static List<Document> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLitigationMaster oLit = new cLitigationMaster(m_oWebInterface.oWebInterface);
        DataTable odtMis = oLit.GetReport(5,-1,-1);
        List<Document> lstRetur = new List<Document>();
        foreach (DataRow oDoc in odtMis.Rows)
        {
            Document cDoc = new Document();
            cDoc.MISId = oDoc[0].ToString();
            cDoc.DocId = oDoc[1].ToString();
            cDoc.DocumentName = oDoc[2].ToString();
            lstRetur.Add(cDoc);
        }
        return lstRetur;
    }
    public class Document
    {
        public string DocumentName { get; set; }
        public string MISId { get; set; }
        public string DocId { get; set; }
    }
}

