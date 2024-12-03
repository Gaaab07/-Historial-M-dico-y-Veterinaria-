using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace COMPLETE_FLAT_UI
{
    public partial class FormListaClientes : Form
    {
        public DataTable DataSource { get; internal set; }

        public FormListaClientes()
        {
            InitializeComponent();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FormListaClientes_Load(object sender, EventArgs e)
        {
            CargarClientes();
        }

        public void SetDataSource(DataTable dataTable)
        {
            dataGridView1.DataSource = dataTable; // Asignar el DataTable al DataGridView
        }

        private void CargarClientes()
        {
            try
            {
                // Conexión a la base de datos
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=VeterinariaDB;Data Source=DESKTOP-HTCT9FE"))
                {
                    // Consulta SQL corregida (con espacio entre SELECT y *)
                    string query = "SELECT * FROM dbo.Cliente";  // Asegúrate de que 'CLIENTE' sea el nombre correcto de la tabla
                    SqlDataAdapter adapter = new SqlDataAdapter(query, conexion);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);  // Llenar el DataTable con los datos de la consulta
                    dataGridView1.DataSource = dataTable;  // Asigna los datos al DataGridView
                }
            }
            catch (Exception ex)
            {
                // Muestra un mensaje de error si ocurre algún problema al cargar los datos
                MessageBox.Show($"Error al cargar los clientes: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void BtnCerrar_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            // Aquí va la lógica para editar un cliente (si es necesario)
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            // Aquí va la lógica para agregar un nuevo cliente
            FormMantCliente frm = new FormMantCliente();
            frm.ShowDialog();
        }

        private void dataGridView1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            // Aquí puedes agregar código para manejar el doble clic en una celda (para editar o ver detalles)
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Aquí puedes manejar el clic en una celda si es necesario
        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            // Otro manejador de eventos de clic en el DataGridView (puedes eliminarlo si no lo necesitas)
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // Aquí puedes agregar la funcionalidad de este botón si es necesario
        }
    }
}
