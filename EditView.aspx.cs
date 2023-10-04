using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using LitigationMaster;

public partial class EditView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static string Search(string cSearch)
    {
        int MISId = 0;
        int ClientId = 0;
        int advId = 0;
        string forum = null;
        string caseName = null;
        string vertical = null;
        bool IsData = false;
        JavaScriptSerializer obj = new JavaScriptSerializer();
        var cCriteria = obj.Deserialize<IDictionary<string, object>>(cSearch);
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cLitigationMaster cClnt = new LitigationMaster.cLitigationMaster(m_oWebInterface.oWebInterface);
        List<cLitigationMaster> clist = new List<cLitigationMaster>();

        if (cCriteria["AdvID"].ToString().Trim() != "")
        {
            advId = Convert.ToInt16(cCriteria["AdvID"].ToString().Trim());
            IsData = true;
        }
        if (cCriteria["ClientID"].ToString().Trim() != "")
        {
            ClientId = Convert.ToInt16(cCriteria["ClientID"].ToString().Trim());
            IsData = true;

        }
        if (cCriteria["Forum"].ToString().Trim() != "")
        {
            forum = cCriteria["Forum"].ToString().Trim();
            IsData = true;

        }
        if (cCriteria["Case"].ToString().Trim() != "")
        {
            caseName = cCriteria["Case"].ToString().Trim();
            IsData = true;

        }
        if (cCriteria["verticals"].ToString().Trim() != "None")
        {
            vertical = cCriteria["verticals"].ToString().Trim();
            IsData = true;

        }
        clist = cClnt.Get(MISId, forum, caseName, vertical, advId, -1);
        HttpContext.Current.Session["listData"] = clist;
        return IsData.ToString().ToLower();
    }

}