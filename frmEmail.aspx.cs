using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Net.Mail;

public partial class frmEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static string SendMail(string cMail,string MisId)
    {
         JavaScriptSerializer obj = new JavaScriptSerializer();
        var cMaIl = obj.Deserialize<IDictionary<string, object>>(cMail);
        string result="";
        //Send Mail
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        LitigationMaster.cEmailOption oEmail = new LitigationMaster.cEmailOption(m_oWebInterface.oWebInterface);
        oEmail.EmailTo = cMaIl["To"].ToString();
        oEmail.EmailBCC = cMaIl["Bcc"].ToString();
        oEmail.EmailCC = cMaIl["Cc"].ToString();
        oEmail.Subject = cMaIl["Subject"].ToString();
        oEmail.Text = cMaIl["Body"].ToString();


        if (oEmail.SendMessageDetail(ref result))
        {
            return result;
        }
        return result;
        //System.Net.Mail.MailMessage oMail = new MailMessage();

        //smtp = m_oWebInterface.oWebInterface.GetPreferences("smtp");
        //suser = m_oWebInterface.oWebInterface.GetPreferences("EmailUser");
        //port = m_oWebInterface.oWebInterface.GetPreferences("port");
        //spassword = m_oWebInterface.oWebInterface.GetPreferences("Password");

        //SmtpClient sClient = new SmtpClient(smtp);
        //oMail.From =new MailAddress(suser);
        //oMail.CC.Add( cMaIl["Cc"].ToString());
        //oMail.To.Add(cMaIl["To"].ToString());
        //oMail.Body = cMaIl["Body"].ToString();
        //oMail.Subject = cMaIl["Subject"].ToString();
        //sClient.Port = Convert.ToInt16(port);
        //sClient.EnableSsl = false;
        //sClient.Credentials = new System.Net.NetworkCredential(suser, spassword);
        //sClient.Send(oMail);

        ////Save send email
        
        //oEmail.FromName = suser;
        //oEmail.EmailFrom = suser;
        //oEmail.EmailTo = cMaIl["To"].ToString();
        //oEmail.ToName = cMaIl["To"].ToString();
        //oEmail.EmailCC = cMaIl["Cc"].ToString();
        //oEmail.EmailBCC = null;
        //oEmail.Subject = cMaIl["Subject"].ToString();
        //oEmail.Text = cMaIl["Body"].ToString();

        //oEmail.MISId =Convert.ToInt16( MisId);
        //oEmail.SaveValues();

    }
}