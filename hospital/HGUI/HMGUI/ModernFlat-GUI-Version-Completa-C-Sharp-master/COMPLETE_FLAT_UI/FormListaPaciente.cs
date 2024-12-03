using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace COMPLETE_FLAT_UI
{
    public partial class FormListaPaciente : Form
    {
        public FormListaPaciente()
        {
            InitializeComponent();
        }

        // Cargar datos al cargar el formulario
        private void FormListaClientes_Load(object sender, EventArgs e)
        {
            CargarPacientes();
        }

        // Método para asignar el DataSource al DataGridView
        public void SetDataSource(DataTable dataTable)
        {
            dataGridView1.DataSource = dataTable; // Asignar el DataTable
        }

        // Método para cargar la lista de pacientes en el DataGridView
        private void CargarPacientes()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                {
                    string query = "SELECT IDPACIENTE, NOMBREP, APELLIDOP, FECHANACIMP, GENEROP, DIRECCIONP, NUMTELEFONICOP, EDAD FROM PACIENTE WHERE ESTADO = 1";
                    SqlDataAdapter adapter = new SqlDataAdapter(query, conexion);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    dataGridView1.DataSource = dataTable;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al cargar los pacientes: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // Botón Nuevo - Crear un nuevo paciente
        private void btnNuevo_Click(object sender, EventArgs e)
        {
            FormMantPaciente frm = new FormMantPaciente();
            frm.ShowDialog();
            CargarPacientes(); // Recargar la lista después de cerrar el formulario
        }


        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            // Deja vacío o añade lógica si es necesario.
        }

        private void dataGridView1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            // Deja vacío o añade lógica si es necesario.
        }

        // Botón Editar - Editar un paciente seleccionado
        private void btnEditar_Click(object sender, EventArgs e)
        {
            // Verificar si se ha seleccionado una fila
            if (dataGridView1.SelectedRows.Count == 1)
            {
                FormMantPaciente frm = new FormMantPaciente();

                // Pasar los datos al formulario de edición
                DataGridViewRow filaSeleccionada = dataGridView1.SelectedRows[0];
                frm.IdPaciente= filaSeleccionada.Cells["IDPACIENTE"].Value.ToString();
                frm.txtnombre.Text = filaSeleccionada.Cells["NOMBREP"].Value.ToString();
                frm.txtapellido.Text = filaSeleccionada.Cells["APELLIDOP"].Value.ToString();
                frm.txtdireccion.Text = filaSeleccionada.Cells["DIRECCIONP"].Value.ToString();
                frm.txttelefono.Text = filaSeleccionada.Cells["NUMTELEFONICOP"].Value.ToString();
                frm.txtedad.Text = filaSeleccionada.Cells["EDAD"].Value.ToString();
                frm.dateNac = Convert.ToDateTime(filaSeleccionada.Cells["FECHANACIMP"].Value);
                frm.comboGene = filaSeleccionada.Cells["GENEROP"].Value.ToString() == "M" ? "Masculino" : "Femenino";

                frm.EsEdicion = true; // Activar modo edición
                if (frm.EsEdicion == true)
                {
                    frm.txtDNIPaciente.Text = frm.IdPaciente;
                    frm.txtDNIPaciente.ReadOnly = true;

                }

                frm.ShowDialog();
                CargarPacientes(); // Recargar la lista después de cerrar el formulario
            }
            else
            {
                MessageBox.Show("Por favor, seleccione un paciente para editar.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }



        // Botón Eliminar - Eliminar un paciente seleccionado
        private void button2_Click_1(object sender, EventArgs e)
        {
            // Verificar si se ha seleccionado una fila
            if (dataGridView1.SelectedRows.Count == 1) // Asegura que solo se elimine una fila
            {
                string idPaciente = dataGridView1.SelectedRows[0].Cells["IDPACIENTE"].Value.ToString();

                DialogResult result = MessageBox.Show("¿Está seguro de que desea eliminar este paciente?",
                                                      "Confirmación", MessageBoxButtons.YesNo,MessageBoxIcon.Question);
                if (result == DialogResult.Yes)
                {
                    try
                    {
                        using (SqlConnection conexion = new SqlConnection("Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=BD_HM;Data Source=DESKTOP-HTCT9FE"))
                        {
                            string query = "UPDATE PACIENTE SET ESTADO = 0 WHERE IDPACIENTE = @IDPACIENTE";
                            conexion.Open();

                            using (SqlCommand cmd = new SqlCommand(query, conexion))
                            {
                                cmd.Parameters.AddWithValue("@IDPACIENTE", idPaciente);
                                cmd.ExecuteNonQuery();
                            }

                            MessageBox.Show("Paciente eliminado exitosamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            CargarPacientes(); // Recargar la lista después de eliminar
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Error al eliminar el paciente: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            else
            {
                MessageBox.Show("Por favor, seleccione un paciente para eliminar.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }


        // Botón Cerrar
        private void BtnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        
    }
}
