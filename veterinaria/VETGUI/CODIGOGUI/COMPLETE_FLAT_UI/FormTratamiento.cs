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
    public partial class FormTratamiento : Form
    {
        public FormTratamiento()
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
                    // Consulta para verificar si el ID del diagnóstico existe
                    string checkIDDiagQuery = "SELECT COUNT(*) FROM TRATAMIENTO WHERE ID_Diagnostico = @ID_Diagnostico";
                    conexion.Open();

                    using (SqlCommand checkCmd = new SqlCommand(checkIDDiagQuery, conexion))
                    {
                        checkCmd.Parameters.AddWithValue("@ID_Diagnostico", txtidDiag.Text);

                        int idExistente = (int)checkCmd.ExecuteScalar();
                        if (idExistente == 0)
                        {
                            // Mostrar mensaje si el ID del diagnóstico no existe
                            MessageBox.Show("El ID del diagnóstico ingresado no existe.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                    }

                    // Validar que la fecha de fin no sea anterior a la fecha de inicio
                    DateTime fechaInicio = dtfechaIn.Value;
                    DateTime fechaFin = dtfechaFin.Value;

                    if (fechaFin < fechaInicio)
                    {
                        MessageBox.Show("La fecha de fin no puede ser anterior a la fecha de inicio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Insertar tratamiento si las fechas son válidas
                    string query = "INSERT INTO TRATAMIENTO (ID_Diagnostico, Duracion, Fecha_Inicio, Fecha_Fin) " +
                                   "VALUES(@ID_Diagnostico, @Duracion, @Fecha_Inicio, @Fecha_Fin)";
                    using (SqlCommand trat = new SqlCommand(query, conexion))
                    {
                        trat.Parameters.AddWithValue("@ID_Diagnostico", txtidDiag.Text);
                        trat.Parameters.AddWithValue("@Duracion", txtduracion.Text);
                        trat.Parameters.AddWithValue("@Fecha_Inicio", fechaInicio); // Usa DateTime directamente
                        trat.Parameters.AddWithValue("@Fecha_Fin", fechaFin);     // Usa DateTime directamente

                        trat.ExecuteNonQuery();

                        // Mensaje de éxito
                        MessageBox.Show("Tratamiento agregado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show("Ocurrió un error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}