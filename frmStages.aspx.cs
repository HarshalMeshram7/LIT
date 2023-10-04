using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class frmStages : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();

    protected void Page_Load(object sender, EventArgs e)
    {
        m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (!IsPostBack)
        {
            cStages stage = new cStages(m_oWebInterface.oWebInterface);
            stage.LoadValues();
            DataTable dt = stage.dtStages;
            ddlStages.DataSource = dt;
            ddlStages.DataTextField = "sStage";
            ddlStages.DataValueField = "wStageId";
            ddlStages.SelectedIndex = 0;
            ddlStages.DataBind();
        }
    }

    [System.Web.Services.WebMethod]
    public static bool SaveStages(string sStage)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cStages cStage = new cStages(m_oWebInterface.oWebInterface);
        cStage.Stage = sStage;
        cStage.SaveValues();
        return true;
    }
}