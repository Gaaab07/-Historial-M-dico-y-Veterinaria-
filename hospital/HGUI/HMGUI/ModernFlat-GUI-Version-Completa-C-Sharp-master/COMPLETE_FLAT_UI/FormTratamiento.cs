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

        private void FormTratamiento_Load(object sender, EventArgs e)
        {
            GenerarNuevoIDTratamiento(); // Generar automáticamente el ID de tratamiento al cargar el formulario
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Generar el ID automáticamente
                string idTratamiento = GenerarNuevoIDTratamiento();

                // Validar que todos los campos estén completos
                if (string.IsNullOrWhiteSpace(comboNOMBREMEDICINA.Text) ||
                    string.IsNullOrWhiteSpace(comboNOMBRETR.Text) ||
                    string.IsNullOrWhiteSpace(txtDESCTRA.Text) ||
                    string.IsNullOrWhiteSpace(txtSUJETOTRA.Text))
                {
                    MessageBox.Show("Por favor, llena todos los campos obligatorios.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // Validar que la fecha de fin no sea anterior a la fecha de inicio
                DateTime fechaInicio = dtfechaIn.Value;
                DateTime fechaFin = dtfechaFin.Value;

                if (fechaFin < fechaInicio)
                {
                    MessageBox.Show("La fecha de fin no puede ser anterior a la fecha de inicio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para insertar tratamiento
                    string query = "INSERT INTO TRATAMIENTO (IDTRATAMIENTO, NOMBREMED, NOMBRETR, FECHAINI, FECHAFIN, DESCTRA, SUJETOTRA, ESTADO) " +
                                   "VALUES (@IDTRATAMIENTO, @NOMBREMED, @NOMBRETR, @FECHAINI, @FECHAFIN, @DESCTRA, @SUJETOTRA, @ESTADO)";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros
                        cmd.Parameters.AddWithValue("@IDTRATAMIENTO", idTratamiento);
                        cmd.Parameters.AddWithValue("@NOMBREMED", comboNOMBREMEDICINA.Text);
                        cmd.Parameters.AddWithValue("@NOMBRETR", comboNOMBRETR.Text);
                        cmd.Parameters.AddWithValue("@FECHAINI", fechaInicio);
                        cmd.Parameters.AddWithValue("@FECHAFIN", fechaFin);
                        cmd.Parameters.AddWithValue("@DESCTRA", txtDESCTRA.Text);
                        cmd.Parameters.AddWithValue("@SUJETOTRA", txtSUJETOTRA.Text);
                        cmd.Parameters.AddWithValue("@ESTADO", 1); // Activo por defecto

                        cmd.ExecuteNonQuery();

                        // Mensaje de éxito
                        MessageBox.Show("Tratamiento agregado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        LimpiarCampos();
                        GenerarNuevoIDTratamiento(); // Generar el próximo ID automáticamente
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show($"Ocurrió un error: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string GenerarNuevoIDTratamiento()
        {
            string nuevoID = "T0000001"; // ID inicial predeterminado
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para obtener el último ID
                    string query = "SELECT TOP 1 IDTRATAMIENTO FROM TRATAMIENTO ORDER BY IDTRATAMIENTO DESC";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        object resultado = cmd.ExecuteScalar();

                        if (resultado != null)
                        {
                            // Incrementar el ID existente
                            string ultimoID = resultado.ToString(); // Ejemplo: T0000014
                            int numero = int.Parse(ultimoID.Substring(1)) + 1; // Extraer "0000014" y convertir a número
                            nuevoID = $"T{numero:D7}"; // Generar nuevo ID con formato "T0000015"
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al generar el nuevo ID: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            return nuevoID; // Retornar el nuevo ID para usarlo en las consultas
        }

        private void LimpiarCampos()
        {
            comboNOMBREMEDICINA.SelectedIndex = -1;
            comboNOMBRETR.SelectedIndex = -1;
            txtDESCTRA.Clear();
            txtSUJETOTRA.Clear();
            dtfechaIn.Value = DateTime.Now;
            dtfechaFin.Value = DateTime.Now;
        }

        private void comboNOMBREMEDICINA_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboNOMBRETR_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dtfechaIn_ValueChanged(object sender, EventArgs e)
        {

        }

        private void dtfechaFin_ValueChanged(object sender, EventArgs e)
        {

        }

        private void txtDESCTRA_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtSUJETOTRA_TextChanged(object sender, EventArgs e)
        {

        }
    }
}