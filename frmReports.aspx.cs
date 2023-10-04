using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using LitigationMaster;
using System.Data;
using System.ComponentModel;
public partial class frmReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //ddlSelectReports.Items.Add(new ListItem("Nature of cases", "1"));
        //ddlSelectReports.Items.Add(new ListItem("Amount", "2"));
        //ddlSelectReports.Items.Add(new ListItem("Vertical", "3"));
        //ddlSelectReports.Items.Add(new ListItem("CASES ADDED/CLOSED", "4"));
        //ddlSelectReports.Items.Add(new ListItem("MIS", "5"));
        if (!IsPostBack)
        {
            //ddlSelectReports.SelectedValue = Request.QueryString["ReportId"].ToString();
            //GetReport();
            LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
            cPreferences oPreff = new cPreferences(m_oWebInterface.oWebInterface);
            DataTable dtYears = oPreff.LoadYears();
            for (int i = Convert.ToInt16(dtYears.Rows[0][0].ToString()); i <= Convert.ToInt16(dtYears.Rows[0][1].ToString()); i++)
            {
                ddlYears.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            ddlQuaters.Items.Add(new ListItem("<All>", "-1"));
            for (int i = 1; i <= 4; i++)
            {
                ddlQuaters.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            switch (Request.QueryString["ReportId"].ToString())
            {
                case "1"://Nature of Cases
                    lblReport.InnerText = "Nature of cases :";
                    break;
                case "2"://Pay & REcv
                    lblReport.InnerText = "Amount :";
                    break;
                case "3"://Vertical
                    lblReport.InnerText = "Vertical :";
                    break;

                case "4"://CASES ADDED/CLOSED 
                    lblReport.InnerText = "CASES ADDED/CLOSED :";
                    break;
            }
        }
    }
    protected void btnReports_Click(object sender, EventArgs e)
    {
        GetReport();
        //Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
        //Chart1.SaveImage();
    }

    private DataTable GroupTable(DataTable odt)
    {
        foreach (DataRow dr in odt.Rows)
        {
            if (dr["wTypeId"].ToString() == "1" || dr["wTypeId"].ToString() == "2" || dr["wTypeId"].ToString() == "3" || dr["wTypeId"].ToString() == "7")
            {
                dr["wTypeId"] = "0";
            }
            else
            {
                dr["wTypeId"] = "1";
            }
        }
        odt.AcceptChanges();
        return odt;
    }

    private DataTable FormatTable(DataTable odt)
    {
        DataTable ofdt = odt.Clone();
        List<DataTable> tables = odt.AsEnumerable().GroupBy(row => new
        {
            wCaseTypeId = row.Field<Int32>("wCaseTypeId"),
            //sVertical = row.Field<string>("sVertical"),
            wStageId = row.Field<Int32>("wStageId"),
            FieldBy = row.Field<Int32>("FieldBy")
        }).Select(g => g.CopyToDataTable()).ToList();
        foreach (DataTable obj in tables)
        {
            int icount = 0;
            DataRow dr1 = ofdt.NewRow();
            foreach (DataRow dr in obj.Rows)
            {
                icount = icount + Convert.ToInt16(dr["wCount"]);
                dr1 = dr;
            }
            dr1["wCount"] = icount;
            ofdt.ImportRow(dr1);
        }
        ofdt.AcceptChanges();
        return ofdt;
    }
    public DataTable ConvertToDataTable<T>(IList<T> data)
    {
        PropertyDescriptorCollection properties =
           TypeDescriptor.GetProperties(typeof(T));
        DataTable table = new DataTable();
        foreach (PropertyDescriptor prop in properties)
            table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        foreach (T item in data)
        {
            DataRow row = table.NewRow();
            foreach (PropertyDescriptor prop in properties)
                row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
            table.Rows.Add(row);
        }
        return table;

    }

    private void GetReport()
    {
        LitigationMaster.cWebInterfaces m_oWebInterface = (LitigationMaster.cWebInterfaces)HttpContext.Current.Session["oWebInterface"];
        cLitigationMaster cLitigation = new cLitigationMaster(m_oWebInterface.oWebInterface);
        DataTable dt = new DataTable();
        divReport.Attributes.Add("Style", "visibility:visible");
        Image chartImg = new Image();
        chartImg.ImageUrl = "~/Styles/images/ChartImg.png";
        Series sCivil = new Series();
        Series sCrimnal = new Series();
        Series sLabour = new Series();
        Series sTax = new Series();
        Series sEmployment = new Series();
        Series sOthers = new Series();
        Series sSecretarial = new Series();
        sCivil.Name = "Civil";
        sCrimnal.Name = "Criminal";
        sLabour.Name = "Labour";
        sTax.Name = "Tax";
        sEmployment.Name = "Employment";
        sOthers.Name = "Others";
        sSecretarial.Name = "Secretarial";

        //For reports 3 and 4
        string sIfs = "IFS";
        string sSdb = "SDB";
        string sMpil = "MPIL";
        int yVal = 0;
        switch (Request.QueryString["ReportId"].ToString())
        {
            case "1"://Nature of Cases
                // dt = FormatTable(GroupTable(cLitigation.GetReport(1)));
                dt = cLitigation.GetReport(1, Convert.ToInt16(ddlYears.SelectedValue), Convert.ToInt16(ddlQuaters.SelectedValue));
                Chart1.DataSource = dt;
                sSecretarial.Points.AddXY("Filed by ISS", 0);
                sSecretarial.Points.AddXY("Filed Against ISS", 0);
                sSecretarial.Points.AddXY("Legal Notice by ISS", 0);
                sSecretarial.Points.AddXY("Legal Notice Against ISS ", 0);
                DataView viewNature = new DataView(dt);
                DataTable distinctValuesNAture = viewNature.ToTable(true, "sCaseName");
                foreach (DataRow odr in distinctValuesNAture.Rows)
                {
                    DataRow[] dr = dt.Select("sCaseName='" + odr[0].ToString() + "'");
                    //Series series = new Series();
                    //series.Name = odr[0].ToString();
                    foreach (DataRow odrPt in dr)
                    {
                        int y = (int)odrPt[1];
                        int y1 = (int)odrPt[2];
                        string sFBy = "Filed by ISS";
                        string sFAgns = "Filed Against ISS";

                        switch (odr[0].ToString())
                        {
                            case "Civil":
                                sCivil.Points.AddXY(sFBy, y);
                                sCivil.Points.AddXY(sFAgns, y1);
                                break;
                            case "Criminal":
                                sCrimnal.Points.AddXY(sFBy, y);
                                sCrimnal.Points.AddXY(sFAgns, y1);
                                break;
                            case "Labour":
                                sLabour.Points.AddXY(sFBy, y);
                                sCivil.Points.AddXY(sFAgns, y1);
                                break;
                            case "Tax":
                                sTax.Points.AddXY(sFBy, y);
                                sTax.Points.AddXY(sFAgns, y1);
                                break;
                            case "Employment":
                                sEmployment.Points.AddXY(sFBy, y);
                                sEmployment.Points.AddXY(sFAgns, y1);
                                break;
                            case "Others":
                                sOthers.Points.AddXY(sFBy, y);
                                sOthers.Points.AddXY(sFAgns, y1);
                                break;
                            case "Secretarial":
                                sSecretarial.Points.AddXY(sFBy, y);
                                sSecretarial.Points.AddXY(sFAgns, y1);
                                break;

                        }
                    }

                    //series.ChartType = SeriesChartType.Column;
                    //series.IsValueShownAsLabel = true;
                    //Chart1.Series.Add(series);
                }
                Chart1.Series.Add(sCivil);
                sCivil.IsValueShownAsLabel = true;
                Chart1.Series.Add(sCrimnal);
                sCrimnal.IsValueShownAsLabel = true;
                Chart1.Series.Add(sTax);
                sTax.IsValueShownAsLabel = true;
                Chart1.Series.Add(sSecretarial);
                sSecretarial.IsValueShownAsLabel = true;
                Chart1.Series.Add(sOthers);
                sOthers.IsValueShownAsLabel = true;
                Chart1.Series.Add(sLabour);
                sLabour.IsValueShownAsLabel = true;
                Chart1.Series.Add(sEmployment);
                sEmployment.IsValueShownAsLabel = true;

                Chart1.Legends[0].Enabled = true;
                break;
            case "2"://Pay & REcv
                Label1.InnerText = "In INR";
                int iType = 2;
                string sVal = Request.Form["rbtnOption"];
                if (sVal == "Vertical")
                    iType = 6;
                dt = cLitigation.GetReport(iType, Convert.ToInt16(ddlYears.SelectedValue), Convert.ToInt16(ddlQuaters.SelectedValue));

                DataTable dtCaseType = cLitigation.GetCaseType();
                DataTable dtVertical = cLitigation.GetVerticals();
                Series seriesPay = new Series();
                Series seriesRecv = new Series();
                seriesPay.Name = "Amount Claimed";
                seriesRecv.Name = "Amount to be recovered";
                if (sVal == "Vertical")
                {
                    foreach (DataRow odr in dtVertical.Rows)
                    {
                        DataRow[] dr = dt.Select("sVertical='" + odr["sVertical"].ToString() + "'");
                        int y = 0;
                        int y1 = 0;
                        foreach (DataRow odr1 in dr)
                        {
                            y = y + Convert.ToInt32(odr1[2] == DBNull.Value ? 0 : odr1[2]);
                            y1 = y1 + Convert.ToInt32(odr1[3] == DBNull.Value ? 0 : odr1[3]);
                        }
                        seriesPay.Points.AddXY(odr["sVertical"].ToString(), y);
                        seriesRecv.Points.AddXY(odr["sVertical"].ToString(), y1);

                    }
                }
                else
                {
                    foreach (DataRow odr in dtCaseType.Rows)
                    {
                        DataRow[] dr = dt.Select("sCaseName='" + odr["sCaseName"].ToString() + "'");
                        int y = 0;
                        int y1 = 0;
                        foreach (DataRow odr1 in dr)
                        {
                            y = y + Convert.ToInt32(odr1[1]);
                            y1 = y1 + Convert.ToInt32(odr1[2]);
                        }
                        seriesPay.Points.AddXY(odr["sCaseName"].ToString(), y);
                        seriesRecv.Points.AddXY(odr["sCaseName"].ToString(), y1);

                    }
                }
                seriesPay.ChartType = SeriesChartType.Column;
                seriesPay.IsValueShownAsLabel = true;
                seriesRecv.ChartType = SeriesChartType.Column;
                seriesRecv.IsValueShownAsLabel = true;

                Chart1.Series.Add(seriesPay);
                Chart1.Series.Add(seriesRecv);
                Chart1.Legends[0].Enabled = true;
                Chart1.ChartAreas["ChartArea1"].AxisY.Title = "In INR";
                Chart1.ChartAreas["ChartArea1"].AxisY.TitleForeColor = System.Drawing.Color.DarkBlue; 
               break;
            case "3"://Vertical
                dt = cLitigation.GetReport(3, Convert.ToInt16(ddlYears.SelectedValue), Convert.ToInt16(ddlQuaters.SelectedValue));

                sCivil.ChartType = SeriesChartType.Column;
                DataRow[] dr1 = dt.Select("sCaseName='" + sCivil.Name + "' and sVertical='" + sIfs + "'");
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sCivil.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sCivil.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sCivil.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sCivil.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sCivil.Points.AddXY(sMpil, yVal);



                sCrimnal.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sCrimnal.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sCrimnal.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sCrimnal.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sCrimnal.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sCrimnal.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][3];

                sCrimnal.Points.AddXY(sMpil, yVal);


                sTax.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sTax.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sTax.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sTax.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sTax.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sTax.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sTax.Points.AddXY(sMpil, yVal);


                sEmployment.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sEmployment.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][3];

                sEmployment.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sEmployment.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][3];

                sEmployment.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sEmployment.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sEmployment.Points.AddXY(sMpil, yVal);


                sSecretarial.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sSecretarial.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sSecretarial.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sSecretarial.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sSecretarial.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sSecretarial.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sSecretarial.Points.AddXY(sMpil, yVal);


                sOthers.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sOthers.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sOthers.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sOthers.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sOthers.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sOthers.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sOthers.Points.AddXY(sMpil, yVal);


                sLabour.ChartType = SeriesChartType.Column;
                dr1 = dt.Select("sCaseName='" + sLabour.Name + "' and sVertical='" + sIfs + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sLabour.Points.AddXY(sIfs, yVal);
                dr1 = dt.Select("sCaseName='" + sLabour.Name + "' and sVertical='" + sSdb + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sLabour.Points.AddXY(sSdb, yVal);
                dr1 = dt.Select("sCaseName='" + sLabour.Name + "' and sVertical='" + sMpil + "'");
                yVal = 0;
                if (dr1.Length == 0)
                {
                    yVal = 0;
                }
                else
                    yVal = (int)dr1[0][2];

                sLabour.Points.AddXY(sMpil, yVal);

                Chart1.Series.Add(sCivil);
                sCivil.IsValueShownAsLabel = true;
                Chart1.Series.Add(sCrimnal);
                sCrimnal.IsValueShownAsLabel = true;
                Chart1.Series.Add(sTax);
                sTax.IsValueShownAsLabel = true;
                Chart1.Series.Add(sSecretarial);
                sSecretarial.IsValueShownAsLabel = true;
                Chart1.Series.Add(sOthers);
                sOthers.IsValueShownAsLabel = true;
                Chart1.Series.Add(sLabour);
                sLabour.IsValueShownAsLabel = true;
                Chart1.Series.Add(sEmployment);
                sEmployment.IsValueShownAsLabel = true;


                Chart1.Legends[0].Enabled = true;
                break;
            case "4"://CASES ADDED/CLOSED 
                dt = cLitigation.GetReport(4, Convert.ToInt16(ddlYears.SelectedValue), Convert.ToInt16(ddlQuaters.SelectedValue));


                //DataView viewAdd = new DataView(dt);
                //DataTable distinctValuesAdd = viewAdd.ToTable(true, "sCaseName");
                foreach (DataRow odr in dt.Rows)
                {
                    DataRow[] dr = dt.Select("sCaseName='" + odr[0].ToString() + "'");
                    Series series = new Series();
                    series.Name = odr[0].ToString();
                    foreach (DataRow odrPt in dr)
                    {
                        int y = (int)odrPt[1];
                        series.Points.AddXY("New", y);
                        int y1 = (int)odrPt[2];
                        series.Points.AddXY("Closed", y1);
                    }
                    series.ChartType = SeriesChartType.Column;
                    series.IsValueShownAsLabel = true;
                    Chart1.Series.Add(series);
                }
                // Chart1.Series.Add(sCivil);
                //sCivil.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sCrimnal);
                //sCrimnal.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sTax);
                //sTax.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sSecretarial);
                //sSecretarial.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sOthers);
                //sOthers.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sLabour);
                //sLabour.IsValueShownAsLabel = true;
                //Chart1.Series.Add(sEmployment);
                //sEmployment.IsValueShownAsLabel = true;


                Chart1.Legends[0].Enabled = true;
                break;
        }
    }
}