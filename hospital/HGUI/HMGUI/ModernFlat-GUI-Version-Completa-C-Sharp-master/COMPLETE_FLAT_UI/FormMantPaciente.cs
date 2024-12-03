using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.VisualStyles;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace COMPLETE_FLAT_UI
{

    public partial class FormMantPaciente : Form
    {

        public System.Windows.Forms.ComboBox comboBox1;

        public string IdPaciente { get; set; } // Para almacenar el ID del paciente en edición
        public bool EsEdicion { get; set; } = false; // Indica si estamos editando

        public FormMantPaciente()
        {
            InitializeComponent();

            
            
        }
        public string idpac;
        public DateTime dateNac;
        public string comboGene;


        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hWnd, int wMsg, int wParam, int lParam);

        private void BarraTitulo_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }

        private void BtnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FormMantCliente_Load(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void BarraTitulo_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtid_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtnombre_TextChanged(object sender, EventArgs e)
        {

        }

        private void txttelefono_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtdireccion_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Calcular la edad
                txtedad.Text = CalcularEdad(dateNacimiento.Value).ToString();

                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    conexion.Open();

                    if (EsEdicion)
                    {
                        // Modo edición: Actualizar el registro existente
                        string query = "UPDATE PACIENTE SET NOMBREP = @NOMBREP, APELLIDOP = @APELLIDOP, DIRECCIONP = @DIRECCIONP, " +
                                       "NUMTELEFONICOP = @NUMTELEFONICOP, EDAD = @EDAD, GENEROP = @GENEROP, FECHANACIMP = @FECHANACIMP " +
                                       "WHERE IDPACIENTE = @IDPACIENTE";

                        using (SqlCommand cmd = new SqlCommand(query, conexion))
                        {
                            cmd.Parameters.AddWithValue("@IDPACIENTE", IdPaciente);
                            cmd.Parameters.AddWithValue("@NOMBREP", txtnombre.Text);
                            cmd.Parameters.AddWithValue("@APELLIDOP", txtapellido.Text);
                            cmd.Parameters.AddWithValue("@DIRECCIONP", txtdireccion.Text);
                            cmd.Parameters.AddWithValue("@NUMTELEFONICOP", txttelefono.Text);
                            cmd.Parameters.AddWithValue("@EDAD", txtedad.Text);
                            cmd.Parameters.AddWithValue("@GENEROP", comboBoxGenero.SelectedItem?.ToString() == "Masculino" ? "M" : "F");
                            cmd.Parameters.AddWithValue("@FECHANACIMP", dateNacimiento.Value.Date);
                            
                            cmd.ExecuteNonQuery();
                        }

                        MessageBox.Show("Paciente actualizado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.Close(); // Cerrar el formulario después de guardar
                    }
                    else
                    {
                        // Modo creación: Insertar un nuevo registro
                        string query = "INSERT INTO PACIENTE (IDPACIENTE, NOMBREP, APELLIDOP, DIRECCIONP, NUMTELEFONICOP, EDAD, GENEROP, FECHANACIMP) " +
                                       "VALUES (@IDPACIENTE, @NOMBREP, @APELLIDOP, @DIRECCIONP, @NUMTELEFONICOP, @EDAD, @GENEROP, @FECHANACIMP)";

                        using (SqlCommand cmd = new SqlCommand(query, conexion))
                        {
                            string idPaciente = Guid.NewGuid().ToString("N").Substring(0, 8).ToUpper();
                            cmd.Parameters.AddWithValue("@IDPACIENTE", idPaciente);
                            cmd.Parameters.AddWithValue("@NOMBREP", txtnombre.Text);
                            cmd.Parameters.AddWithValue("@APELLIDOP", txtapellido.Text);
                            cmd.Parameters.AddWithValue("@DIRECCIONP", txtdireccion.Text);
                            cmd.Parameters.AddWithValue("@NUMTELEFONICOP", txttelefono.Text);
                            cmd.Parameters.AddWithValue("@EDAD", txtedad.Text);
                            cmd.Parameters.AddWithValue("@GENEROP", comboBoxGenero.SelectedItem?.ToString() == "Masculino" ? "M" : "F");
                            cmd.Parameters.AddWithValue("@FECHANACIMP", dateNacimiento.Value.Date);

                            dateNac=dateNacimiento.Value.Date;
                            cmd.ExecuteNonQuery();
                        }

                        MessageBox.Show("Paciente agregado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }

                LimpiarCampos();
                
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ocurrió un error: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            
        }

        // Método para limpiar los campos después de la inserción
        private void LimpiarCampos()
        {
            txtnombre.Clear();
            txtapellido.Clear();
            txtdireccion.Clear();
            txttelefono.Clear();
            txtedad.Clear();
            comboBoxGenero.SelectedIndex = -1; // Reinicia el comboBox
            dateNacimiento.Value = DateTime.Now; // Restablece al valor actual
            txtDNIPaciente.Focus();
            txtDNIPaciente.Clear();
            txtedad.Text = "";
        }


        private void comboBoxGenero_SelectedIndexChanged(object sender, EventArgs e)
        {
            //comboBoxGenero.Items.AddRange(new string[] { "M", "F" });
            //comboBoxGenero.SelectedIndex = -1; // Sin selección inicial

        }

        private void txtedad_TextChanged(object sender, EventArgs e)
        {

        }
        private int CalcularEdad(DateTime fechaNacimiento)
        {
            DateTime fechaActual = DateTime.Now;
            int edad = fechaActual.Year - fechaNacimiento.Year;

            // Ajustar si el cumpleaños aún no ha ocurrido este año
            if (fechaNacimiento.Date > fechaActual.AddYears(-edad).Date)
            {
                edad--;
            }

            return edad;
        }

        

        private void dateNacimiento_ValueChanged(object sender, EventArgs e)
        {
 int edadCalculada = CalcularEdad(dateNacimiento.Value);
            txtedad.Text = edadCalculada.ToString();
        }

        private void label9_Click(object sender, EventArgs e)
        {

        }
    }
}