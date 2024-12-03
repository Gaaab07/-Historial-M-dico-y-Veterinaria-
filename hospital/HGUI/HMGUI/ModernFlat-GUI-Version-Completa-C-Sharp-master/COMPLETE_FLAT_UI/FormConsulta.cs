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
            GenerarNuevoIDConsulta(); // Generar automáticamente el ID de consulta
            CargarIDPacientes(); // Cargar IDs de pacientes en el ComboBox
            CargarIDMedicos(); // Cargar IDs de médicos en el ComboBox
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Generar el ID de consulta automáticamente
                string idConsulta = GenerarNuevoIDConsulta();

                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Validar campos obligatorios
                    if (string.IsNullOrWhiteSpace(comboIDPACIENTE.Text) ||
                        string.IsNullOrWhiteSpace(comboIDMEDICO.Text) ||
                        string.IsNullOrWhiteSpace(comboTIPO_CONSULTA.Text))
                    {
                        MessageBox.Show("Por favor, llena todos los campos obligatorios.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    // Consulta para insertar en la tabla CONSULTA
                    string query = "INSERT INTO CONSULTA (IDCONSULTA, IDPACIENTE, IDMEDICO, TIPO_CONSULTA, FECHA_HORA_CONSULTA, OBSERVACIONES, ESTADO) " +
                                   "VALUES (@IDCONSULTA, @IDPACIENTE, @IDMEDICO, @TIPO_CONSULTA, @FECHA_HORA_CONSULTA, @OBSERVACIONES, @ESTADO)";

                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros
                        cmd.Parameters.AddWithValue("@IDCONSULTA", idConsulta);
                        cmd.Parameters.AddWithValue("@IDPACIENTE", comboIDPACIENTE.Text);
                        cmd.Parameters.AddWithValue("@IDMEDICO", comboIDMEDICO.Text);
                        cmd.Parameters.AddWithValue("@TIPO_CONSULTA", comboTIPO_CONSULTA.Text);
                        cmd.Parameters.AddWithValue("@FECHA_HORA_CONSULTA", DateTime.Now);
                        cmd.Parameters.AddWithValue("@OBSERVACIONES", txtOBSERVACIONES.Text);
                        cmd.Parameters.AddWithValue("@ESTADO", 1); // Activo por defecto

                        cmd.ExecuteNonQuery();

                        MessageBox.Show("Consulta registrada exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        LimpiarCampos();
                        GenerarNuevoIDConsulta(); // Generar el próximo ID automáticamente
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show($"Ocurrió un error: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string GenerarNuevoIDConsulta()
        {
            string nuevoID = "C0000001"; // ID inicial predeterminado
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para obtener el último ID
                    string query = "SELECT TOP 1 IDCONSULTA FROM CONSULTA ORDER BY IDCONSULTA DESC";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        object resultado = cmd.ExecuteScalar();

                        if (resultado != null)
                        {
                            // Incrementar el ID existente
                            string ultimoID = resultado.ToString(); // Ejemplo: C0000050
                            int numero = int.Parse(ultimoID.Substring(1)) + 1; // Extraer "0000050" y convertir a número
                            nuevoID = $"C{numero:D7}"; // Generar nuevo ID con formato "C0000051"
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

        private void CargarIDPacientes()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    string query = "SELECT IDPACIENTE FROM PACIENTE";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            comboIDPACIENTE.Items.Add(reader["IDPACIENTE"].ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al cargar los IDs de pacientes: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void CargarIDMedicos()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    string query = "SELECT IDMEDICO FROM MEDICO";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            comboIDMEDICO.Items.Add(reader["IDMEDICO"].ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al cargar los IDs de médicos: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void comboIDPACIENTE_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    string query = "SELECT NOMBREP + ' ' + APELLIDOP AS NombreCompleto FROM PACIENTE WHERE IDPACIENTE = @IDPACIENTE";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        cmd.Parameters.AddWithValue("@IDPACIENTE", comboIDPACIENTE.Text);

                        // Obtener el nombre completo
                        
                        labNombrePaciente.Text = cmd.ExecuteScalar()?.ToString() ?? "No encontrado";
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al obtener el nombre del paciente: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }




        private void comboIDMEDICO_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    string query = "SELECT NOMBREM + ' ' + APELLIDOM AS NombreCompleto FROM MEDICO WHERE IDMEDICO = @IDMEDICO";
                    conexion.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        cmd.Parameters.AddWithValue("@IDMEDICO", comboIDMEDICO.Text);

                        // Obtener el nombre completo
                        labNombreMedico.Text = cmd.ExecuteScalar()?.ToString() ?? "No encontrado";
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al obtener el nombre del médico: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        

        private void LimpiarCampos()
        {
            comboIDPACIENTE.SelectedIndex = -1;
            comboIDMEDICO.SelectedIndex = -1;
            comboTIPO_CONSULTA.SelectedIndex = -1;
            txtOBSERVACIONES.Clear();
            labNombrePaciente.Text = string.Empty;
            labNombreMedico.Text = string.Empty;
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }



        private void comboTIPO_CONSULTA_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void txtOBSERVACIONES_TextChanged(object sender, EventArgs e)
        {

        }

        private void labNombrePaciente_Click(object sender, EventArgs e)
        {

        }

        private void labNombreMedico_Click(object sender, EventArgs e)
        {

        }

        private void labNombrePaciente_Click_1(object sender, EventArgs e)
        {

        }

        private void labNombreMedico_Click_1(object sender, EventArgs e)
        {

        }

        
    }
}
