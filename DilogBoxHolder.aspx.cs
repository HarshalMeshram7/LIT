using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DilogBoxHolder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Pg"] != null)
        {
            int iWidth = Convert.ToInt32(Request.QueryString["Pw"])-15;
            int iHight = Convert.ToInt32(Request.QueryString["Ph"])-48;
            string sUrl = Request.QueryString["Pg"].ToString();
            if (sUrl.IndexOf("|") > 0)
            {
                sUrl = sUrl.Replace("|", "&");
            }
            iHold.Attributes.Add("src", sUrl);
            iHold.Attributes.Add("width", iWidth.ToString() + "px;");//-15
            iHold.Attributes.Add("height", iHight.ToString() + "px;");//-48
        }
    }
}