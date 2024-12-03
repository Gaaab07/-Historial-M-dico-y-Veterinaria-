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
    public partial class FromEnfermero : Form
    {
        public FromEnfermero()
        {
            InitializeComponent();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void FromEnfermero_Load(object sender, EventArgs e)
        {
            GenerarNuevoIDEnfermero(); // Generar automáticamente el ID al cargar el formulario
            //txtIDEnfermero.Enabled = false; // Deshabilitar el campo de ID
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Generar el ID automáticamente
                string idEnfermero = GenerarNuevoIDEnfermero();

                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Validar campos obligatorios
                    if (string.IsNullOrWhiteSpace(txtNOMBREENF.Text) ||
                        string.IsNullOrWhiteSpace(txtTELEFONOENF.Text) ||
                        string.IsNullOrWhiteSpace(txtEMAILM.Text) ||
                        string.IsNullOrWhiteSpace(comboESPECIALIDADENF.Text) ||
                        string.IsNullOrWhiteSpace(txtEXPERIENCIAENF.Text))
                    {
                        MessageBox.Show("Por favor, llena todos los campos obligatorios.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    // Validar formato del correo electrónico
                    if (!txtEMAILM.Text.Contains("@") || !txtEMAILM.Text.Contains("."))
                    {
                        MessageBox.Show("Por favor, ingresa un correo electrónico válido.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    // Consulta para insertar al enfermero
                    string query = "INSERT INTO ENFERMERO (IDENFERMERO, NOMBREENF, ESPECIALIDADENF, EXPERIENCIAENF, TELEFONOENF, EMAILM, ESTADO) " +
                                   "VALUES (@IDENFERMERO, @NOMBREENF, @ESPECIALIDADENF, @EXPERIENCIAENF, @TELEFONOENF, @EMAILM, @ESTADO)";

                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros
                        cmd.Parameters.AddWithValue("@IDENFERMERO", txtDNIEnf.Text);
                        cmd.Parameters.AddWithValue("@NOMBREENF", txtNOMBREENF.Text);
                        cmd.Parameters.AddWithValue("@ESPECIALIDADENF", comboESPECIALIDADENF.Text);
                        cmd.Parameters.AddWithValue("@EXPERIENCIAENF", txtEXPERIENCIAENF.Text + " años");
                        cmd.Parameters.AddWithValue("@TELEFONOENF", txtTELEFONOENF.Text);
                        cmd.Parameters.AddWithValue("@EMAILM", txtEMAILM.Text);
                        cmd.Parameters.AddWithValue("@ESTADO", 1); // Activo por defecto

                        cmd.ExecuteNonQuery();

                        MessageBox.Show("Enfermero registrado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        LimpiarCampos();
                        GenerarNuevoIDEnfermero(); // Generar el próximo ID automáticamente
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show($"Ocurrió un error: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string GenerarNuevoIDEnfermero()
        {
            string nuevoID = "E0000001"; // ID inicial predeterminado
            try
            {
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para obtener el último ID
                    string query = "SELECT TOP 1 IDENFERMERO FROM ENFERMERO ORDER BY IDENFERMERO DESC";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        object resultado = cmd.ExecuteScalar();

                        if (resultado != null)
                        {
                            // Incrementar el ID existente
                            string ultimoID = resultado.ToString(); // Ejemplo: E0000050
                            int numero = int.Parse(ultimoID.Substring(1)) + 1; // Extraer "0000050" y convertir a número
                            nuevoID = $"E{numero:D7}"; // Generar nuevo ID con formato "E0000051"
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al generar el nuevo ID: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            //txtIDEnfermero.Text = nuevoID; // Mostrar el nuevo ID en el campo (si está presente)
            return nuevoID; // Retornar el nuevo ID para usarlo en las consultas
        }

        private void LimpiarCampos()
        {
            txtNOMBREENF.Clear();
            txtAPELLIDO.Clear();
            txtTELEFONOENF.Clear();
            txtEMAILM.Clear();

            txtEXPERIENCIAENF.Clear();
            comboESPECIALIDADENF.SelectedIndex = -1; // Reiniciar el ComboBox
            txtNOMBREENF.Focus();
        }

        private void txtfechaNam_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtNOMBREENF_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAPELLIDO_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboESPECIALIDADENF_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void txtEXPERIENCIAENF_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtTELEFONOENF_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtEMAILM_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
