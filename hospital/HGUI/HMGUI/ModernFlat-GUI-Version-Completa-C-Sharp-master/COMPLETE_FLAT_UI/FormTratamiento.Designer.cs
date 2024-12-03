namespace COMPLETE_FLAT_UI
{
    partial class FormTratamiento
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
            this.BarraTitulo = new System.Windows.Forms.Panel();
            this.label6 = new System.Windows.Forms.Label();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.comboNOMBRETR = new System.Windows.Forms.ComboBox();
            this.comboNOMBREMEDICINA = new System.Windows.Forms.ComboBox();
            this.dtfechaFin = new System.Windows.Forms.DateTimePicker();
            this.dtfechaIn = new System.Windows.Forms.DateTimePicker();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.Sujeto = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtSUJETOTRA = new System.Windows.Forms.TextBox();
            this.txtDESCTRA = new System.Windows.Forms.TextBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.BarraTitulo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // BarraTitulo
            // 
            this.BarraTitulo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(38)))), ((int)(((byte)(45)))), ((int)(((byte)(53)))));
            this.BarraTitulo.Controls.Add(this.label6);
            this.BarraTitulo.Dock = System.Windows.Forms.DockStyle.Top;
            this.BarraTitulo.Location = new System.Drawing.Point(0, 0);
            this.BarraTitulo.Name = "BarraTitulo";
            this.BarraTitulo.Size = new System.Drawing.Size(800, 38);
            this.BarraTitulo.TabIndex = 29;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.White;
            this.label6.Location = new System.Drawing.Point(348, 9);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(113, 16);
            this.label6.TabIndex = 40;
            this.label6.Text = "Form Tratamiento";
            // 
            // btnCancelar
            // 
            this.btnCancelar.BackColor = System.Drawing.Color.CadetBlue;
            this.btnCancelar.FlatAppearance.BorderSize = 0;
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelar.ForeColor = System.Drawing.Color.White;
            this.btnCancelar.Location = new System.Drawing.Point(252, 291);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(100, 35);
            this.btnCancelar.TabIndex = 37;
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
            this.button1.Location = new System.Drawing.Point(121, 291);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(100, 35);
            this.button1.TabIndex = 36;
            this.button1.Text = "Guardar";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label7.Location = new System.Drawing.Point(42, 116);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(84, 17);
            this.label7.TabIndex = 55;
            this.label7.Text = "Tratamiento";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label4.Location = new System.Drawing.Point(42, 89);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(64, 17);
            this.label4.TabIndex = 56;
            this.label4.Text = "Medicina";
            // 
            // comboNOMBRETR
            // 
            this.comboNOMBRETR.FormattingEnabled = true;
            this.comboNOMBRETR.Items.AddRange(new object[] {
            "Tratamiento para fiebre",
            "Tratamiento para dolor",
            "Tratamiento antibiótico",
            "Tratamiento para alergias",
            "Tratamiento para acidez",
            "Tratamiento para diabetes",
            "Tratamiento para inflamación",
            "Tratamiento para colesterol",
            "Tratamiento antibiótico",
            "Tratamiento para asma",
            "Tratamiento antiinflamatorio",
            "Tratamiento diurético",
            "Tratamiento antidepresivo",
            "Tratamiento antidepresivo"});
            this.comboNOMBRETR.Location = new System.Drawing.Point(181, 116);
            this.comboNOMBRETR.Name = "comboNOMBRETR";
            this.comboNOMBRETR.Size = new System.Drawing.Size(244, 21);
            this.comboNOMBRETR.TabIndex = 53;
            // 
            // comboNOMBREMEDICINA
            // 
            this.comboNOMBREMEDICINA.FormattingEnabled = true;
            this.comboNOMBREMEDICINA.Items.AddRange(new object[] {
            "Paracetamol",
            "Ibuprofeno",
            "Amoxicilina",
            "Loratadina",
            "Omeprazol",
            "Metformina",
            "Aspirina",
            "Simvastatina",
            "Ciprofloxacino",
            "Salbutamol",
            "Prednisona",
            "Furosemida",
            "Sertralina",
            "Citalopram"});
            this.comboNOMBREMEDICINA.Location = new System.Drawing.Point(181, 89);
            this.comboNOMBREMEDICINA.Name = "comboNOMBREMEDICINA";
            this.comboNOMBREMEDICINA.Size = new System.Drawing.Size(244, 21);
            this.comboNOMBREMEDICINA.TabIndex = 54;
            // 
            // dtfechaFin
            // 
            this.dtfechaFin.Location = new System.Drawing.Point(181, 176);
            this.dtfechaFin.Name = "dtfechaFin";
            this.dtfechaFin.Size = new System.Drawing.Size(244, 20);
            this.dtfechaFin.TabIndex = 52;
            // 
            // dtfechaIn
            // 
            this.dtfechaIn.Location = new System.Drawing.Point(181, 147);
            this.dtfechaIn.Name = "dtfechaIn";
            this.dtfechaIn.Size = new System.Drawing.Size(244, 20);
            this.dtfechaIn.TabIndex = 51;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label3.Location = new System.Drawing.Point(42, 179);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(90, 17);
            this.label3.TabIndex = 50;
            this.label3.Text = "Fecha de fin:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label1.Location = new System.Drawing.Point(42, 147);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(107, 17);
            this.label1.TabIndex = 49;
            this.label1.Text = "Fecha de inicio:";
            // 
            // Sujeto
            // 
            this.Sujeto.AutoSize = true;
            this.Sujeto.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Sujeto.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.Sujeto.Location = new System.Drawing.Point(42, 234);
            this.Sujeto.Name = "Sujeto";
            this.Sujeto.Size = new System.Drawing.Size(48, 17);
            this.Sujeto.TabIndex = 47;
            this.Sujeto.Text = "Sujeto";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label2.Location = new System.Drawing.Point(42, 205);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 17);
            this.label2.TabIndex = 48;
            this.label2.Text = "Descripción";
            // 
            // txtSUJETOTRA
            // 
            this.txtSUJETOTRA.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtSUJETOTRA.Location = new System.Drawing.Point(181, 231);
            this.txtSUJETOTRA.Name = "txtSUJETOTRA";
            this.txtSUJETOTRA.Size = new System.Drawing.Size(244, 23);
            this.txtSUJETOTRA.TabIndex = 45;
            // 
            // txtDESCTRA
            // 
            this.txtDESCTRA.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtDESCTRA.Location = new System.Drawing.Point(181, 202);
            this.txtDESCTRA.Name = "txtDESCTRA";
            this.txtDESCTRA.Size = new System.Drawing.Size(244, 23);
            this.txtDESCTRA.TabIndex = 46;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::COMPLETE_FLAT_UI.Properties.Resources.tratamiento;
            this.pictureBox1.Location = new System.Drawing.Point(548, 80);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(186, 196);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 57;
            this.pictureBox1.TabStop = false;
            // 
            // FormTratamiento
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.BarraTitulo);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.comboNOMBRETR);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.comboNOMBREMEDICINA);
            this.Controls.Add(this.dtfechaFin);
            this.Controls.Add(this.txtDESCTRA);
            this.Controls.Add(this.dtfechaIn);
            this.Controls.Add(this.txtSUJETOTRA);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Sujeto);
            this.Name = "FormTratamiento";
            this.Text = "FormTratamiento";
            this.BarraTitulo.ResumeLayout(false);
            this.BarraTitulo.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel BarraTitulo;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox comboNOMBRETR;
        private System.Windows.Forms.ComboBox comboNOMBREMEDICINA;
        private System.Windows.Forms.DateTimePicker dtfechaFin;
        private System.Windows.Forms.DateTimePicker dtfechaIn;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label Sujeto;
        private System.Windows.Forms.Label label2;
        public System.Windows.Forms.TextBox txtSUJETOTRA;
        public System.Windows.Forms.TextBox txtDESCTRA;
        private System.Windows.Forms.PictureBox pictureBox1;
    }
}