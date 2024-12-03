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
    public partial class FormProducto : Form
    {
        public FormProducto()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Cadena de conexión
                using (SqlConnection conexion = new SqlConnection("Data Source=DESKTOP-SI9JHBE;Initial Catalog=VeterinariaDB;Integrated Security=True;Encrypt=False"))
                {
                    string query = "INSERT INTO PRODUCTO (Descripcion, PrecioVenta, Categoria)" +
                                   "VALUES(@Descripcion, @PrecioVenta, @Categoria)";

                    using (SqlCommand pro = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros
                        // 
                        pro.Parameters.AddWithValue("@Descripcion", txtdesc.Text);
                        pro.Parameters.AddWithValue("@PrecioVenta", txtprecio.Text);                        
                        pro.Parameters.AddWithValue("@Categoria", txtcategoria.Text);

                        // Abrir conexión
                        conexion.Open();
                        pro.ExecuteNonQuery();

                        // Mensaje de éxito
                        MessageBox.Show("Producto agregado exitosamente.");
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
