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
    public partial class FormDiagnostico : Form
    {
        public FormDiagnostico()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
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
                    string checkDNIQuery = "SELECT COUNT(*) FROM DIAGNOSTICO WHERE ID_Mascota = @ID_Mascota";
                    conexion.Open();

                    using (SqlCommand checkCmd = new SqlCommand(checkDNIQuery, conexion))
                    {
                        checkCmd.Parameters.AddWithValue("@ID_Mascota", txtidMas.Text);

                        int idExistente = (int)checkCmd.ExecuteScalar();
                        if (idExistente == 0)
                        {
                            // Mostrar mensaje si el DNI ya existe
                            MessageBox.Show("El ID de la mascota ingresada no existe.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            string query = "INSERT INTO DIAGNOSTICO (ID_Mascota, Fecha_Diagnostico, Sintoma, Observaciones)" +
                                "VALUES(@ID_Mascota, @Fecha_Diagnostico, @Sintoma, @Observaciones)";
                            using (SqlCommand diag = new SqlCommand(query, conexion))
                            {
                                string fechaIngreso = dtfechaDiag.Value.ToString("yyyy-MM-dd");

                                // Agregar parámetros
                                // 
                                diag.Parameters.AddWithValue("@ID_Mascota", txtidMas.Text);
                                    diag.Parameters.AddWithValue("@Fecha_Diagnostico", fechaIngreso);
                                    diag.Parameters.AddWithValue("@Sintoma", txtsintoma.Text);
                                    diag.Parameters.AddWithValue("@Observaciones", txtobservaciones.Text);

                                    // Abrir conexión                                    
                                    diag.ExecuteNonQuery();

                                    // Mensaje de éxito
                                    MessageBox.Show("Diagnóstico registrado exitosamente.");
                                
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
    }
}
