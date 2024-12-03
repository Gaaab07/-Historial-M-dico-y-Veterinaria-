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
    public partial class FormMedico : Form
    {
        public FormMedico()
        {
            InitializeComponent();
        }

        private void FormMedico_Load(object sender, EventArgs e)
        {
            GenerarNuevoIDMedico(); // Genera el ID automáticamente al cargar el formulario
            //txtIDMedico.Enabled = false; // Deshabilitar el campo para evitar edición manual
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Generar el ID automáticamente
                string idMedico = GenerarNuevoIDMedico();

                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Validar campos obligatorios
                    if (string.IsNullOrWhiteSpace(txtnombre.Text) ||
                        string.IsNullOrWhiteSpace(txttelefono.Text) ||
                        string.IsNullOrWhiteSpace(txtEmail.Text) ||

                        string.IsNullOrWhiteSpace(txtexperiencia.Text))
                    {
                        MessageBox.Show("Por favor, llena todos los campos obligatorios.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    // Validar formato de correo electrónico
                    if (!txtEmail.Text.Contains("@") || !txtEmail.Text.Contains("."))
                    {
                        MessageBox.Show("Por favor, ingresa un correo electrónico válido.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    // Consulta para insertar al médico
                    string query = "INSERT INTO MEDICO (IDMEDICO, NOMBREM, APELLIDOM, TELEFONOM, EMAILM, DIRECCIONM, ESPECIALIDADM, EXPERIENCIAM, ESTADO) " +
                                   "VALUES (@IDMEDICO, @NOMBREM, @APELLIDOM, @TELEFONOM, @EMAILM, @DIRECCIONM, @ESPECIALIDADM, @EXPERIENCIAM, @ESTADO)";

                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros
                        cmd.Parameters.AddWithValue("@IDMEDICO", txtDNIDoctor.Text);
                        cmd.Parameters.AddWithValue("@NOMBREM", txtnombre.Text);
                        cmd.Parameters.AddWithValue("@APELLIDOM", txtapellido.Text);
                        cmd.Parameters.AddWithValue("@TELEFONOM", txttelefono.Text);
                        cmd.Parameters.AddWithValue("@EMAILM", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@DIRECCIONM", txtdireccion.Text);
                        cmd.Parameters.AddWithValue("@ESPECIALIDADM", comboEspe.SelectedItem?.ToString());
                        cmd.Parameters.AddWithValue("@EXPERIENCIAM", txtexperiencia.Text + " años");
                        cmd.Parameters.AddWithValue("@ESTADO", 1); // Activo por defecto

                        cmd.ExecuteNonQuery();

                        MessageBox.Show("Médico registrado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        LimpiarCampos();
                        GenerarNuevoIDMedico(); // Generar el próximo ID automáticamente
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show($"Ocurrió un error: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string GenerarNuevoIDMedico()
        {
            string nuevoID = "M0000001"; // ID inicial predeterminado
            try
            {
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para obtener el último ID
                    string query = "SELECT TOP 1 IDMEDICO FROM MEDICO ORDER BY IDMEDICO DESC";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        object resultado = cmd.ExecuteScalar();

                        if (resultado != null)
                        {
                            // Incrementar el ID existente
                            string ultimoID = resultado.ToString(); // Ejemplo: M0000050
                            int numero = int.Parse(ultimoID.Substring(1)) + 1; // Extraer "0000050" y convertir a número
                            nuevoID = $"M{numero:D7}"; // Generar nuevo ID con formato "M0000051"
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al generar el nuevo ID: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            //txtIDMedico.Text = nuevoID; // Mostrar el nuevo ID en el campo (si está presente)
            return nuevoID; // Retornar el nuevo ID para usarlo en las consultas
        }

        private void LimpiarCampos()
        {
            txtnombre.Clear();
            txtapellido.Clear();
            txttelefono.Clear();
            comboEspe.SelectedIndex = -1; // Reinicia el comboBox
            txtEmail.Clear();
            txtdireccion.Clear();
            txtexperiencia.Clear();
            txtnombre.Focus();
            txtDNIDoctor.Clear();
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

        private void txtIDMedico_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtnombre_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtapellido_TextChanged(object sender, EventArgs e)
        {

        }

        private void txttelefono_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtdireccion_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtEspecialidad_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtexperiencia_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
