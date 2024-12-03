using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace COMPLETE_FLAT_UI
{
    public partial class FormEditarCliente : Form
    {
        public string ClienteID { get; set; }
        public FormEditarCliente(string idCliente)
        {
            InitializeComponent();
            ClienteID = idCliente;
            CargarDatosCliente();
        }
        private void CargarDatosCliente()
        {
            using (SqlConnection conexion = new SqlConnection("Data Source=DESKTOP-HTCT9FE;Initial Catalog=VeterinariaDB;Integrated Security=True;Encrypt=False"))
            {
                string query = "SELECT Nombres, Apellidos, DNI, Direccion, Telefono FROM CLIENTE WHERE ID_Cliente = @ID_Cliente";
                conexion.Open();
                using (SqlCommand cmd = new SqlCommand(query, conexion))
                {
                    cmd.Parameters.AddWithValue("@ID_Cliente", ClienteID);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtnombre.Text = reader["Nombres"].ToString();
                            txtapellido.Text = reader["Apellidos"].ToString();
                            txtDNI.Text = reader["DNI"].ToString();
                            txtdireccion.Text = reader["Direccion"].ToString();
                            txttelefono.Text = reader["Telefono"].ToString();
                        }
                    }
                }
            }
        }

        private void btnActualizarCli_Click(object sender, EventArgs e)
        {
            


            using (SqlConnection conexion = new SqlConnection("Data Source=DESKTOP-SI9JHBE;Initial Catalog=VeterinariaDB;Integrated Security=True;Encrypt=False"))
            {
                string query = "UPDATE CLIENTE SET Nombres = @Nombres, Apellidos = @Apellidos, DNI = @DNI, Direccion = @Direccion, Telefono = @Telefono WHERE ID_Cliente = @ID_Cliente";
                conexion.Open();
                using (SqlCommand cmd = new SqlCommand(query, conexion))
                {
                    cmd.Parameters.AddWithValue("@Nombres", txtnombre.Text);
                    cmd.Parameters.AddWithValue("@Apellidos", txtapellido.Text);
                    cmd.Parameters.AddWithValue("@DNI", txtDNI.Text);
                    cmd.Parameters.AddWithValue("@Direccion", txtdireccion.Text);
                    cmd.Parameters.AddWithValue("@Telefono", txttelefono.Text);
                    cmd.Parameters.AddWithValue("@ID_Cliente", ClienteID);

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Cliente actualizado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.Close();
                }
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
