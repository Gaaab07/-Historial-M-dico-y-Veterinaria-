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
    public partial class FormTrabajador : Form
    {
        public FormTrabajador()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=VeterinariaDB;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para verificar si el DNI ya existe
                    string checkDNIQuery = "SELECT COUNT(*) FROM TRABAJADOR WHERE DNI = @DNI";
                    conexion.Open();

                    using (SqlCommand checkCmd = new SqlCommand(checkDNIQuery, conexion))
                    {
                        checkCmd.Parameters.AddWithValue("@DNI", txtDNITra.Text);

                        int dniExistente = (int)checkCmd.ExecuteScalar();
                        if (dniExistente > 0)
                        {
                            // Mostrar mensaje si el DNI ya existe
                            MessageBox.Show("El número de DNI ingresado ya existe.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            string query = "INSERT INTO TRABAJADOR (DNI, Nombres, Apellidos, Telefono, Direccion, Cargo, Sueldo, Fecha_Ingreso)" +
                                   "VALUES(@DNI, @Nombres, @Apellidos, @Telefono, @Direccion, @Cargo, @Sueldo, @Fecha_Ingreso)";
                            using (SqlCommand tra = new SqlCommand(query, conexion))
                            {
                                // Convertir la fecha del DateTimePicker a string
                                string fechaIngreso = dtfechaIn.Value.ToString("yyyy-MM-dd");

                                // Agregar parámetros
                                // 
                                tra.Parameters.AddWithValue("@DNI", txtDNITra.Text);
                                tra.Parameters.AddWithValue("@Nombres", txtnombre.Text);
                                tra.Parameters.AddWithValue("@Apellidos", txtapellido.Text);
                                tra.Parameters.AddWithValue("@Telefono", txttelefono.Text);
                                tra.Parameters.AddWithValue("@Direccion", txtdireccion.Text);
                                tra.Parameters.AddWithValue("@Cargo", txtcargo.Text);
                                tra.Parameters.AddWithValue("@Sueldo", txtsueldo.Text);
                                tra.Parameters.AddWithValue("@Fecha_Ingreso", fechaIngreso);

                                tra.ExecuteNonQuery();

                                // Mensaje de éxito
                                MessageBox.Show("Trabajador agregado exitosamente.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show("Ocurrió un error: " + ex.Message);
            }
        }

        private void txtid_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void dtfechaIn_ValueChanged(object sender, EventArgs e)
        {

        }
    }
}
