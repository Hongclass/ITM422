using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Oracle.DataAccess.Client; // ODP.NET Oracle managed provider
using Oracle.DataAccess.Types;
using System.Data.SqlClient; // ODP.NET SQL server managed provider

namespace Final_Project
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string oradb = "Data Source=rice-opd2-2w7;User Id=hr;Password=hr;";
            OracleConnection conn = new OracleConnection(oradb); // C#
            conn.Open();

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "select order_id, first_name, last_name"
                + " from tbl_orders o, tbl_customers c"
                + " where o.customer_id = c.customer_id";
            cmd.CommandType = CommandType.Text;

            OracleDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                listBox1.Items.Add("Order ID: " + dr.GetValue(0)
                    + "; Customer: " + dr.GetString(1) + " " + dr.GetString(2));
            }

            conn.Dispose();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string connetionString = null;
            SqlConnection connection;
            SqlCommand command;
            string sql = null;
            SqlDataReader dataReader;
            connetionString = "Server=216.47.157.180; Data Source=TCWXVUETIK55GIL; Initial Catalog=trouble_ticket; Integrated Security=True";
            sql = "Select * from employees";
            connection = new SqlConnection(connetionString);
            try
            {
                connection.Open();
                command = new SqlCommand(sql, connection);
                dataReader = command.ExecuteReader();
                while (dataReader.Read())
                {
                    listBox1.Items.Add("Employee ID: " + dataReader.GetValue(0)
                        + "; First name: " + dataReader.GetString(1));
                }
                dataReader.Close();
                command.Dispose();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Can not open connection ! ");
            }
       }
    }
}
