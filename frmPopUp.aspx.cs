using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LitigationMaster;
using System.Data;

public partial class frmPopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]

    public static IQueryable GetData(string BindId)
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        if (BindId == "Client")
        {
            cLITClient Client = new cLITClient(m_oWebInterface.oWebInterface);
            List<cLITClient> lstClient = new List<cLITClient>();
            Client.LoadValues();
            DataTable DtClient = Client.dtClient;
            foreach (DataRow dr in DtClient.Rows)
            {
                cLITClient oClient = new cLITClient(m_oWebInterface.oWebInterface);
                oClient.ClientName = dr["sClientName"].ToString();
                oClient.Address = dr["sAddress"].ToString();
                oClient.City = dr["sCity"].ToString();
                oClient.State = dr["sState"].ToString();
                oClient.ClientId = Convert.ToInt16(dr["wClientId"].ToString());
                oClient.Mobile = dr["sMobile"].ToString();
                oClient.Vertical = dr["sVertical"].ToString();
                lstClient.Add(oClient);
            }
            return lstClient.AsQueryable();

        }
        else if (BindId == "Advocate")
        {
            cAdvocate oAdvocate = new cAdvocate(m_oWebInterface.oWebInterface);
            //oAdvocate.LoadValues();
            //DataTable DtAdvocate = oAdvocate.dtAdvocate;
            //List<cAdvocate> lstAdv = new List<cAdvocate>();
            //foreach (DataRow dr in DtAdvocate.Rows)
            //{
            //    cAdvocate oAdv = new cAdvocate(m_oWebInterface.oWebInterface);
            //    oAdv.AdvName = dr["sAdvName"].ToString();
            //    oAdv.AdvocateId = Convert.ToInt16(dr["wAdvId"].ToString());
            //    oAdv.EmailId = dr["sEmail"].ToString();
            //    oAdv.mobile = dr["sMobile"].ToString();
            //    lstAdv.Add(oAdv);

            //}
            //return lstAdv.AsQueryable();
            return oAdvocate.Get(0).AsQueryable();

        }
        else if (BindId == "Firm")
        {
            cFirmDetail oFirm = new cFirmDetail(m_oWebInterface.oWebInterface);
            //oAdvocate.LoadValues();
            //DataTable DtAdvocate = oAdvocate.dtAdvocate;
            //List<cAdvocate> lstAdv = new List<cAdvocate>();
            //foreach (DataRow dr in DtAdvocate.Rows)
            //{
            //    cAdvocate oAdv = new cAdvocate(m_oWebInterface.oWebInterface);
            //    oAdv.AdvName = dr["sAdvFName"].ToString();

            //    //oAdv.LastName = dr["sAdvLName"].ToString();
            //    oAdv.City = dr["sCity"].ToString();
            //    oAdv.State = dr["sState"].ToString();
            //    oAdv.AdvocateId = Convert.ToInt16(dr["wAdvId"].ToString());
            //    oAdv.mobile = dr["sMobile"].ToString();
            //    lstAdv.Add(oAdv);

            //}
            return oFirm.Get(0).AsQueryable();

        }
        else if (BindId == "AuthPer")
        {
            cAuthPerson oFirm = new cAuthPerson(m_oWebInterface.oWebInterface);
            //oAdvocate.LoadValues();
            //DataTable DtAdvocate = oAdvocate.dtAdvocate;
            //List<cAdvocate> lstAdv = new List<cAdvocate>();
            //foreach (DataRow dr in DtAdvocate.Rows)
            //{
            //    cAdvocate oAdv = new cAdvocate(m_oWebInterface.oWebInterface);
            //    oAdv.AdvName = dr["sAdvFName"].ToString();

            //    //oAdv.LastName = dr["sAdvLName"].ToString();
            //    oAdv.City = dr["sCity"].ToString();
            //    oAdv.State = dr["sState"].ToString();
            //    oAdv.AdvocateId = Convert.ToInt16(dr["wAdvId"].ToString());
            //    oAdv.mobile = dr["sMobile"].ToString();
            //    lstAdv.Add(oAdv);

            //}
            return oFirm.Get(0).AsQueryable();

        }
        else
        {
            cAddressBook oConctLst = new cAddressBook(m_oWebInterface.oWebInterface);
            return oConctLst.GetAllIDs().AsQueryable();  
        }

        return null;
    }
}
