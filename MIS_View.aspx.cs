using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class Styles_MIS_View : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();
    protected void Page_Load(object sender, EventArgs e)
    {
        m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (!IsPostBack)
        {
            //loadGrid();
            cStages stage = new cStages(m_oWebInterface.oWebInterface);
            stage.LoadValues();
            DataTable dt = stage.dtStages;
            HttpContext.Current.Session["dtStages"] = dt;
            cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
            HttpContext.Current.Session["dtNature"] = cLitigation.GetCaseType();
        }
    }

    public void loadGrid()
    {
        //cLitigationMaster oLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
        //oLitigation.LoadValues();
        //grdMis.DataSource = oLitigation.dtLitigation;
        //grdMis.DataBind();       
    }

    [System.Web.Services.WebMethod]
    public static List<litBind> LoadData(string Nature, string Vertical)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
        cLitigation.LoadValues();
         DataTable dtLitigation=cLitigation.LoadValuesParameter(Convert.ToInt16(Nature), Vertical);
        //DataTable dtLitigation = cLitigation.dtLitigation;
        List<litBind> lstLitigation = new List<litBind>();
        //DataTable dtStages = (DataTable)HttpContext.Current.Session["dtStages"];
        //DataTable dtNature = (DataTable)HttpContext.Current.Session["dtNature"];
        foreach (DataRow dr in dtLitigation.Rows)
        {
            litBind oClient = new litBind();
            oClient.MISId = Convert.ToInt16(dr["wLITID"].ToString());
            oClient.CaseName = dr["sCaseName"].ToString();
            oClient.SuitNum = dr["sSuitNum"].ToString();
            oClient.Forum = dr["sForum"].ToString();
            oClient.Vertical = dr["sVertical"].ToString();
            oClient.Stage = dr["sStage"].ToString();
            oClient.Nature = dr["Nature"].ToString();

            lstLitigation.Add(oClient);
        }
        return lstLitigation;
    }

    [System.Web.Services.WebMethod]
    public static List<litBind> SearchData()
    {
        List<cLitigationMaster> clist = new List<cLitigationMaster>();
        clist = (List<cLitigationMaster>)HttpContext.Current.Session["listData"];
        List<litBind> cBind=new List<litBind> ();
        foreach (cLitigationMaster cData in clist)
        {
            litBind oBind=new litBind ();
            oBind.MISId = cData.MISId;
            oBind.CaseName = cData.CaseName;
            oBind.SuitNum = cData.SuitNum;
            oBind.Forum = cData.Forum;
            oBind.Vertical = cData.Vertical;
            cBind.Add(oBind);
        }
        return cBind;
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string liitId)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
        string[] ids = liitId.Split('@');
        foreach (string id in ids)
        {
            if (id != "" && id != "undefined")
            {

                cLitigation.DeleteLitigation(Convert.ToInt16(id));

            }
        }
    }
}

public class litBind
{
    public int MISId { get; set; }
    public string CaseName { get; set; }
    public string SuitNum { get; set; }
    public string Forum { get; set; }
    public string Vertical { get; set; }
    public string Nature { get; set; }
    public string Stage { get; set; }
    public string HDate { get; set; }

}