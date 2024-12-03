namespace COMPLETE_FLAT_UI
{
    partial class FormConsulta
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnCancelar = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.BarraTitulo = new System.Windows.Forms.Panel();
            this.labNombreMedico = new System.Windows.Forms.Label();
            this.labNombrePaciente = new System.Windows.Forms.Label();
            this.comboIDMEDICO = new System.Windows.Forms.ComboBox();
            this.comboIDPACIENTE = new System.Windows.Forms.ComboBox();
            this.comboTIPO_CONSULTA = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.txtOBSERVACIONES = new System.Windows.Forms.TextBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.BarraTitulo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnCancelar
            // 
            this.btnCancelar.BackColor = System.Drawing.Color.CadetBlue;
            this.btnCancelar.FlatAppearance.BorderSize = 0;
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelar.ForeColor = System.Drawing.Color.White;
            this.btnCancelar.Location = new System.Drawing.Point(351, 247);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(100, 35);
            this.btnCancelar.TabIndex = 45;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = false;
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.CadetBlue;
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.ForeColor = System.Drawing.Color.White;
            this.button1.Location = new System.Drawing.Point(216, 247);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(100, 35);
            this.button1.TabIndex = 44;
            this.button1.Text = "Guardar";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.White;
            this.label6.Location = new System.Drawing.Point(296, 9);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(93, 16);
            this.label6.TabIndex = 0;
            this.label6.Text = "Form Consulta";
            this.label6.Click += new System.EventHandler(this.label6_Click);
            // 
            // BarraTitulo
            // 
            this.BarraTitulo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(38)))), ((int)(((byte)(45)))), ((int)(((byte)(53)))));
            this.BarraTitulo.Controls.Add(this.label6);
            this.BarraTitulo.Dock = System.Windows.Forms.DockStyle.Top;
            this.BarraTitulo.Location = new System.Drawing.Point(0, 0);
            this.BarraTitulo.Name = "BarraTitulo";
            this.BarraTitulo.Size = new System.Drawing.Size(676, 38);
            this.BarraTitulo.TabIndex = 55;
            // 
            // labNombreMedico
            // 
            this.labNombreMedico.AutoSize = true;
            this.labNombreMedico.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labNombreMedico.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.labNombreMedico.Location = new System.Drawing.Point(181, 140);
            this.labNombreMedico.Name = "labNombreMedico";
            this.labNombreMedico.Size = new System.Drawing.Size(0, 17);
            this.labNombreMedico.TabIndex = 74;
            this.labNombreMedico.Click += new System.EventHandler(this.labNombreMedico_Click_1);
            // 
            // labNombrePaciente
            // 
            this.labNombrePaciente.AutoSize = true;
            this.labNombrePaciente.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labNombrePaciente.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.labNombrePaciente.Location = new System.Drawing.Point(181, 84);
            this.labNombrePaciente.Name = "labNombrePaciente";
            this.labNombrePaciente.Size = new System.Drawing.Size(0, 17);
            this.labNombrePaciente.TabIndex = 73;
            this.labNombrePaciente.Click += new System.EventHandler(this.labNombrePaciente_Click_1);
            // 
            // comboIDMEDICO
            // 
            this.comboIDMEDICO.FormattingEnabled = true;
            this.comboIDMEDICO.Location = new System.Drawing.Point(184, 116);
            this.comboIDMEDICO.Name = "comboIDMEDICO";
            this.comboIDMEDICO.Size = new System.Drawing.Size(244, 21);
            this.comboIDMEDICO.TabIndex = 72;
            this.comboIDMEDICO.SelectedIndexChanged += new System.EventHandler(this.comboIDMEDICO_SelectedIndexChanged_1);
            // 
            // comboIDPACIENTE
            // 
            this.comboIDPACIENTE.FormattingEnabled = true;
            this.comboIDPACIENTE.Location = new System.Drawing.Point(184, 60);
            this.comboIDPACIENTE.Name = "comboIDPACIENTE";
            this.comboIDPACIENTE.Size = new System.Drawing.Size(244, 21);
            this.comboIDPACIENTE.TabIndex = 71;
            this.comboIDPACIENTE.SelectedIndexChanged += new System.EventHandler(this.comboIDPACIENTE_SelectedIndexChanged_1);
            // 
            // comboTIPO_CONSULTA
            // 
            this.comboTIPO_CONSULTA.FormattingEnabled = true;
            this.comboTIPO_CONSULTA.Items.AddRange(new object[] {
            "Chequeo cardiológico",
            "Consulta pediátrica",
            "Consulta dermatológica",
            "Chequeo gastrointestinal",
            "Consulta neurológica",
            "Consulta de oncología",
            "Consulta psiquiátrica",
            "Consulta ginecológica",
            "Chequeo ortopédico",
            "Chequeo oftalmológico"});
            this.comboTIPO_CONSULTA.Location = new System.Drawing.Point(184, 173);
            this.comboTIPO_CONSULTA.Name = "comboTIPO_CONSULTA";
            this.comboTIPO_CONSULTA.Size = new System.Drawing.Size(244, 21);
            this.comboTIPO_CONSULTA.TabIndex = 70;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label4.Location = new System.Drawing.Point(71, 175);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(95, 17);
            this.label4.TabIndex = 69;
            this.label4.Text = "Tipo Consulta";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label9.Location = new System.Drawing.Point(71, 209);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(88, 17);
            this.label9.TabIndex = 68;
            this.label9.Text = "Observación";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label5.Location = new System.Drawing.Point(71, 61);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(90, 17);
            this.label5.TabIndex = 67;
            this.label5.Text = "DNI Paciente";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label1.Location = new System.Drawing.Point(71, 121);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 17);
            this.label1.TabIndex = 66;
            this.label1.Text = "DNI Médico";
            // 
            // txtOBSERVACIONES
            // 
            this.txtOBSERVACIONES.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtOBSERVACIONES.Location = new System.Drawing.Point(184, 205);
            this.txtOBSERVACIONES.Name = "txtOBSERVACIONES";
            this.txtOBSERVACIONES.Size = new System.Drawing.Size(244, 23);
            this.txtOBSERVACIONES.TabIndex = 65;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::COMPLETE_FLAT_UI.Properties.Resources.consulta;
            this.pictureBox1.Location = new System.Drawing.Point(511, 67);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(138, 153);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 48;
            this.pictureBox1.TabStop = false;
            // 
            // FormConsulta
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(676, 394);
            this.Controls.Add(this.labNombreMedico);
            this.Controls.Add(this.BarraTitulo);
            this.Controls.Add(this.labNombrePaciente);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.comboIDMEDICO);
            this.Controls.Add(this.comboIDPACIENTE);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.comboTIPO_CONSULTA);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtOBSERVACIONES);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label5);
            this.Name = "FormConsulta";
            this.Text = "FormConsulta";
            this.Load += new System.EventHandler(this.FormConsulta_Load);
            this.BarraTitulo.ResumeLayout(false);
            this.BarraTitulo.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Panel BarraTitulo;
        private System.Windows.Forms.Label labNombreMedico;
        private System.Windows.Forms.Label labNombrePaciente;
        private System.Windows.Forms.ComboBox comboIDMEDICO;
        private System.Windows.Forms.ComboBox comboIDPACIENTE;
        private System.Windows.Forms.ComboBox comboTIPO_CONSULTA;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.TextBox txtOBSERVACIONES;
    }
}