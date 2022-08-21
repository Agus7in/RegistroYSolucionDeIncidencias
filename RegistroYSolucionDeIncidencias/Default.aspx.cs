using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegistroYSolucionDeIncidencias
{
    public partial class _Default : Page
    {
        public string state;
        public static int ident;
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["IncidenciasConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ident = int.Parse(this.GridView1.Rows[this.GridView1.SelectedIndex].Cells[1].Text);
            this.TextBox1.Text = this.GridView1.Rows[this.GridView1.SelectedIndex].Cells[2].Text;
            this.TextBox2.Text = this.GridView1.Rows[this.GridView1.SelectedIndex].Cells[3].Text;
            this.DropDownList1.SelectedValue = this.GridView1.Rows[this.GridView1.SelectedIndex].Cells[4].Text;
            state = this.GridView1.Rows[this.GridView1.SelectedIndex].Cells[6].Text;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            this.SqlDataSource1.InsertParameters["titulo"].DefaultValue = TextBox1.Text.ToString();
            this.SqlDataSource1.InsertParameters["descripcion"].DefaultValue = TextBox2.Text.ToString();
            this.SqlDataSource1.InsertParameters["prioridad"].DefaultValue = DropDownList1.SelectedValue;
            this.SqlDataSource1.InsertParameters["estado"].DefaultValue = "Iniciada";
            this.SqlDataSource1.Insert();
            this.SqlDataSource1.DataBind();
            Label5.Text = "se agrego una incidencia. ";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Label5.Text = TextBox1.Text;
            Con.Open();
            SqlCommand comando = new SqlCommand("update incidencias set titulo=@titulo, descripcion=@descripcion, prioridad=@prioridad, estado='Iniciada' where id=@id", Con);
            comando.Parameters.Add("@titulo", SqlDbType.VarChar).Value = TextBox1.Text;
            comando.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = TextBox2.Text;
            comando.Parameters.Add("@prioridad", SqlDbType.VarChar).Value = DropDownList1.SelectedValue;
            comando.Parameters.Add("@id", SqlDbType.Int).Value = ident;
            int cant = comando.ExecuteNonQuery();
            if (cant > 0)
            {
                Label5.Text = "Se actualizo "+cant+" incidencia.";
            }
            else
            {
                Label5.Text = "No se actualizo ninguna incidencia. ";
            }
            Con.Close();
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            Refresh(); 
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Refresh();
        }
        
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                string prioridad, estado;
                prioridad = (string)DataBinder.Eval(e.Row.DataItem, "prioridad");
                estado = (string)DataBinder.Eval(e.Row.DataItem, "estado");
                if (estado.Equals("Solucionada"))
                {
                    e.Row.BackColor = System.Drawing.Color.FromArgb(150, 255, 150);
                }
                else
                {
                    if (prioridad.Equals("Alta"))
                    { 
                        e.Row.BackColor = System.Drawing.Color.FromArgb(245, 198, 203);
                    }
                    if (prioridad.Equals("Media"))
                    {
                        e.Row.BackColor = System.Drawing.Color.FromArgb(255, 238, 186);
                    }
                    if (prioridad.Equals("Baja"))
                    {
                        e.Row.BackColor = System.Drawing.Color.FromArgb(190, 229, 235);
                    }
                }
                
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.CompareTo("Resolver") == 0)
            {
                SqlDataSourceSolucionar.UpdateParameters["id"].DefaultValue = this.GridView1.Rows[int.Parse((e.CommandArgument).ToString())].Cells[1].Text;
                if (SqlDataSourceSolucionar.Update() > 0)
                {
                    Label5.Text = "Se actualizo 1 registro desde el grid view";
                    GridView1.Rows[int.Parse((e.CommandArgument).ToString())].BackColor = System.Drawing.Color.FromArgb(195, 230, 203);
                    Refresh();
                }
            }
        }

        void Refresh()
        {
            this.GridView1.DataBind();
            this.SqlDataSourceCantidad.DataSourceMode = SqlDataSourceMode.DataReader;
            SqlDataReader registro;
            registro = (SqlDataReader)SqlDataSourceCantidad.Select(DataSourceSelectArguments.Empty);

            if (registro.Read())
            {
                Label3.Text = "Incidencias(" + registro["cantidad"] + ")";
            }

            this.SqlDataSourceResueltas.DataSourceMode = SqlDataSourceMode.DataReader;
            SqlDataReader registro2;
            registro2 = (SqlDataReader)SqlDataSourceResueltas.Select(DataSourceSelectArguments.Empty);

            if (registro2.Read())
            {
                Label6.Text = "Resueltas(" + registro2["Resueltas"] + ")";
            }

        }
    }
}