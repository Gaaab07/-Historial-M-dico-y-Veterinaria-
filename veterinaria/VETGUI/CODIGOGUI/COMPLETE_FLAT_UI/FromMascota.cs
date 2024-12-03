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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace COMPLETE_FLAT_UI
{
    public partial class FromMascota : Form
    {
        public FromMascota()
        {
            InitializeComponent();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=VeterinariaDB;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para verificar si el DNI ya existe
                    string checkDNIQuery = "SELECT COUNT(*) FROM CLIENTE WHERE ID_Cliente= @ID_Cliente";
                    conexion.Open();

                    using (SqlCommand checkCmd = new SqlCommand(checkDNIQuery, conexion))
                    {
                        checkCmd.Parameters.AddWithValue("@ID_Cliente", txtidMas.Text);

                        int idExistente = (int)checkCmd.ExecuteScalar();
                        if (idExistente == 0)
                        {
                            // Mostrar mensaje si el DNI ya existe
                            MessageBox.Show("El ID del cliente ingresado no existe.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            string query = "INSERT INTO MASCOTA (ID_Cliente, Nombre, Especie, Raza, Edad, Peso, Sexo, Fecha_Nacimiento)" +
                                "VALUES(@ID_Cliente, @Nombre, @Especie, @Raza, @Edad, @Peso, @Sexo, @Fecha_Nacimiento)";
                            using (SqlCommand mas = new SqlCommand(query, conexion))
                            {
                                string fechaIngreso = dtfechaNac.Value.ToString("yyyy-MM-dd");

                                // Agregar parámetros
                                // 
                                mas.Parameters.AddWithValue("@ID_Cliente", txtidMas.Text);
                                mas.Parameters.AddWithValue("@Nombre", txtnombre.Text);
                                mas.Parameters.AddWithValue("@Especie", txtespecie.Text);
                                mas.Parameters.AddWithValue("@Raza", txtraza.Text);
                                mas.Parameters.AddWithValue("@Edad", txtedad.Text);
                                mas.Parameters.AddWithValue("@Peso", txtedad.Text);
                                mas.Parameters.AddWithValue("@Sexo", cboSexo.Text);
                                mas.Parameters.AddWithValue("@Fecha_Nacimiento", fechaIngreso);

                                mas.ExecuteNonQuery();

                                // Mensaje de éxito
                                MessageBox.Show("Mascota agregado exitosamente.");
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

        private void txtfechaNam_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
