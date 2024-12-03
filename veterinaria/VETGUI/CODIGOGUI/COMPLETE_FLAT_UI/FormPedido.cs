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
    public partial class FormPedido : Form
    {
        public FormPedido()
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
                    conexion.Open();

                    // Validar existencia de ID_Trabajador
                    if (!ExisteID(conexion, "TRABAJADOR", "ID_Trabajador", txtidTra.Text))
                    {
                        MessageBox.Show("El ID del trabajador no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Validar existencia de ID_Mascota
                    if (!ExisteID(conexion, "CLIENTE", "ID_Cliente", txtidCli.Text))
                    {
                        MessageBox.Show("El ID del cliente no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    // Validar existencia de ID_Diagnostico
                    if (!ExisteID(conexion, "PRODUCTO", "ID_Producto", txtidPro.Text))
                    {
                        MessageBox.Show("El ID del producto no existe.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    string query = "INSERT INTO PEDIDO (ID_Trabajador, ID_Cliente, ID_Producto, FechaHora, Descripcion, Cantidad, PrecioPedido, Estado, NroPago, Monto, TipoComprobante, MetodoPago)" +
                                   "VALUES(@ID_Trabajador, @ID_Cliente, @ID_Producto, @FechaHora, @Descripcion, @Cantidad, @PrecioPedido, @Estado, @NroPago, @Monto, @TipoComprobante, @MetodoPago)";

                    using (SqlCommand ped = new SqlCommand(query, conexion))
                    {
                        DateTime fechaIngreso = dtfecha.Value;

                        // Agregar parámetros
                        // 
                        ped.Parameters.AddWithValue("@ID_Trabajador", txtidTra.Text);
                        ped.Parameters.AddWithValue("@ID_Cliente", txtidCli.Text);
                        ped.Parameters.AddWithValue("@ID_Producto", txtidPro.Text);
                        ped.Parameters.AddWithValue("@FechaHora", dtfecha.Text);
                        ped.Parameters.AddWithValue("@Descripcion", txtdesc.Text);
                        ped.Parameters.AddWithValue("@Cantidad", txtcant.Text);
                        ped.Parameters.AddWithValue("@PrecioPedido", txtprecio.Text);
                        ped.Parameters.AddWithValue("@Estado", cboestado.Text);
                        ped.Parameters.AddWithValue("@NroPago", txtnropago.Text);
                        ped.Parameters.AddWithValue("@Monto", txtmonto.Text);
                        ped.Parameters.AddWithValue("@TipoComprobante", cbocomprobante.Text);
                        ped.Parameters.AddWithValue("@MetodoPago", cbometodoPago.Text);

                        // Abrir conexión
                        conexion.Open();
                        ped.ExecuteNonQuery();

                        // Mensaje de éxito
                        MessageBox.Show("Pedido agregado exitosamente.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones
                MessageBox.Show("Ocurrió un error: " + ex.Message);
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

        private void BtnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
