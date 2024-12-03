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
    public partial class FormConsulta : Form
    {
        public FormConsulta()
        {
            InitializeComponent();
        }

        private void FormConsulta_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=VeterinariaDB;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Abrir conexión
                    conexion.Open();

                    // Validar existencia de ID_Trabajador
                    if (!ExisteID(conexion, "TRABAJADOR", "ID_Trabajador", txtidTra.Text))
                    {
                        MessageBox.Show("El ID del trabajador no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Validar existencia de ID_Mascota
                    if (!ExisteID(conexion, "MASCOTA", "ID_Mascota", txtidMas.Text))
                    {
                        MessageBox.Show("El ID de la mascota no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Validar existencia de ID_Diagnostico
                    if (!ExisteID(conexion, "DIAGNOSTICO", "ID_Diagnostico", txtidDiag.Text))
                    {
                        MessageBox.Show("El ID del diagnóstico no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Insertar consulta
                    string query = "INSERT INTO CONSULTA (ID_Trabajador, ID_Mascota, ID_Diagnostico, Fecha_Hora, Estado) " +
                                   "VALUES(@ID_Trabajador, @ID_Mascota, @ID_Diagnostico, @Fecha_Hora, @Estado)";

                    using (SqlCommand cons = new SqlCommand(query, conexion))
                    {
                        DateTime fechaIngreso = dtfechaAte.Value;

                        // Agregar parámetros
                        cons.Parameters.AddWithValue("@ID_Trabajador", txtidTra.Text);
                        cons.Parameters.AddWithValue("@ID_Mascota", txtidMas.Text);
                        cons.Parameters.AddWithValue("@ID_Diagnostico", txtidDiag.Text);
                        cons.Parameters.AddWithValue("@Fecha_Hora", fechaIngreso);
                        cons.Parameters.AddWithValue("@Estado", cboestado.Text);

                        cons.ExecuteNonQuery();

                        // Mensaje de éxito
                        MessageBox.Show("Consulta agregada exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show("Ocurrió un error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private bool ExisteID(SqlConnection conexion, string tabla, string columna, string id)
        {
            string query = $"SELECT COUNT(*) FROM {tabla} WHERE {columna} = @ID";
            using (SqlCommand cmd = new SqlCommand(query, conexion))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }
    }
}
