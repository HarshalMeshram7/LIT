using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class ContactView : System.Web.UI.Page
{
    LitigationMaster.cWebInterfaces m_oWebInterface = new LitigationMaster.cWebInterfaces();
    protected void Page_Load(object sender, EventArgs e)
    {
        m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (!IsPostBack)
        {
            //loadGrid();
        }
    }
    [System.Web.Services.WebMethod]
    public static List<cAddressBook> LoadData()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAddressBook oConctLst = new cAddressBook(m_oWebInterface.oWebInterface);
        return oConctLst.Get(0);    
       
    }

    [System.Web.Services.WebMethod]
    public static void DeleteData(string cIds)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cAddressBook oConct = new cAddressBook(m_oWebInterface.oWebInterface);
        string[] ids = cIds.Split('@');
        foreach (string id in ids)
        {
            if (id != "") 
            {
                if (id != "undefined")
                {
                    oConct.ConId = Convert.ToInt16(id);
                    oConct.DeleteContacts();
                }
            }
        }
    }
}