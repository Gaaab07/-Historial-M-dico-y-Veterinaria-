using System;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace COMPLETE_FLAT_UI
{
    public partial class FormMantCliente : Form
    {
        public FormMantCliente()
        {
            InitializeComponent();
        }

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
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=VeterinariaDB;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta para verificar si el DNI ya existe
                    string checkDNIQuery = "SELECT COUNT(*) FROM CLIENTE WHERE DNI = @DNI";
                    conexion.Open();

                    using (SqlCommand checkCmd = new SqlCommand(checkDNIQuery, conexion))
                    {
                        checkCmd.Parameters.AddWithValue("@DNI", txtDNI.Text);

                        int dniExistente = (int)checkCmd.ExecuteScalar();
                        if (dniExistente > 0)
                        {
                            // Mostrar mensaje si el DNI ya existe
                            MessageBox.Show("El número de DNI ingresado ya existe.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        else
                        {
                            // Consulta para insertar el nuevo cliente
                            string query = "INSERT INTO CLIENTE (Nombres, Apellidos, DNI, Direccion, Telefono) " +
                                           "VALUES(@Nombres, @Apellidos, @DNI, @Direccion, @Telefono);" +
                                           "SELECT SCOPE_IDENTITY();"; // Obtiene el ID generado por el auto-incremento

                            using (SqlCommand cli = new SqlCommand(query, conexion))
                            {
                                cli.Parameters.AddWithValue("@Nombres", txtnombre.Text);
                                cli.Parameters.AddWithValue("@Apellidos", txtapellido.Text);
                                cli.Parameters.AddWithValue("@DNI", txtDNI.Text);
                                cli.Parameters.AddWithValue("@Direccion", txtdireccion.Text);
                                cli.Parameters.AddWithValue("@Telefono", txttelefono.Text);

                                // Ejecutar la consulta e insertar el nuevo cliente
                                object result = cli.ExecuteScalar(); // Esto devuelve el ID del nuevo cliente

                                // Si la consulta fue exitosa, result no debe ser null
                                if (result != null)
                                {
                                    int idCliente = Convert.ToInt32(result);  // Convertir el ID a entero
                                    MessageBox.Show($"Cliente agregado exitosamente. ID del cliente: {idCliente}");

                                    // Limpiar los campos después de la inserción
                                    txtnombre.Clear();
                                    txtapellido.Clear();
                                    txtDNI.Clear();
                                    txtdireccion.Clear();
                                    txttelefono.Clear();
                                    txtnombre.Focus();  // Volver a enfocar en el campo de nombre
                                }
                                else
                                {
                                    MessageBox.Show("Error al obtener el ID del cliente.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                }
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
