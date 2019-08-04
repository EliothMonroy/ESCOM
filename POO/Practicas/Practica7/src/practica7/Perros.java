/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica7;

import bd.cConexion;
import javax.swing.JOptionPane;

/**
 *
 * @author ELITH
 */
public class Perros extends javax.swing.JFrame {

    /**
     * Creates new form Perros
     */
    public Perros() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        titulo = new javax.swing.JLabel();
        labelNombre = new javax.swing.JLabel();
        nombre = new javax.swing.JTextField();
        labelRaza = new javax.swing.JLabel();
        raza = new javax.swing.JTextField();
        labelEdad = new javax.swing.JLabel();
        edad = new javax.swing.JSpinner();
        labelGenero = new javax.swing.JLabel();
        genero = new javax.swing.JComboBox<>();
        enviar = new javax.swing.JButton();
        labelError = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Insertar Perro");

        titulo.setFont(new java.awt.Font("Sylfaen", 1, 18)); // NOI18N
        titulo.setText("Insertar");

        labelNombre.setText("Nombre:");

        nombre.setToolTipText("Panchito");
        nombre.setNextFocusableComponent(raza);

        labelRaza.setText("Raza:");

        raza.setToolTipText("Chihuahua");

        labelEdad.setText("Edad:");

        edad.setModel(new javax.swing.SpinnerNumberModel(2, 1, 15, 1));
        edad.setToolTipText("8");
        edad.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        labelGenero.setText("Genero:");

        genero.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Macho", "Hembra" }));
        genero.setToolTipText("Macho/Hembra");

        enviar.setBackground(new java.awt.Color(255, 255, 255));
        enviar.setText("Guardar");
        enviar.setToolTipText("Guardarlo en la bd");
        enviar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                enviarActionPerformed(evt);
            }
        });

        labelError.setFont(new java.awt.Font("Tahoma", 1, 11)); // NOI18N
        labelError.setForeground(new java.awt.Color(255, 51, 51));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(labelNombre)
                            .addComponent(labelRaza)
                            .addComponent(labelEdad))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(nombre)
                            .addComponent(raza)
                            .addComponent(edad)))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(labelGenero)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(genero, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(175, 175, 175)
                                .addComponent(titulo))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(181, 181, 181)
                                .addComponent(enviar))
                            .addGroup(layout.createSequentialGroup()
                                .addContainerGap()
                                .addComponent(labelError)))
                        .addGap(0, 182, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(titulo)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelNombre)
                    .addComponent(nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelRaza)
                    .addComponent(raza, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelEdad)
                    .addComponent(edad, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelGenero)
                    .addComponent(genero, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(30, 30, 30)
                .addComponent(labelError)
                .addGap(20, 20, 20)
                .addComponent(enviar)
                .addContainerGap(77, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void enviarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_enviarActionPerformed
        if(nombre.getText().equals("") || raza.getText().equals("")){
            labelError.setText("Tanto el campo nombre como raza deben de tener algún valor");
        }else{
            try{
                Integer a=5;
                cConexion con=new cConexion();
                con.conectar();
                con.insertar("insert into perro values('"+nombre.getText()+"','"+raza.getText()+"',"+(Integer)edad.getValue()+",'"+genero.getSelectedItem().toString()+"');");
                JOptionPane.showMessageDialog(null, "Perro registrado :).");
            }catch(Exception e){
                System.out.println("Error al insertar perro "+e);
            }
            
        }
        
    }//GEN-LAST:event_enviarActionPerformed

    /**
     * @param args the command line arguments
     */
    public void main() {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Perros.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Perros.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Perros.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Perros.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Perros().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JSpinner edad;
    private javax.swing.JButton enviar;
    private javax.swing.JComboBox<String> genero;
    private javax.swing.JLabel labelEdad;
    private javax.swing.JLabel labelError;
    private javax.swing.JLabel labelGenero;
    private javax.swing.JLabel labelNombre;
    private javax.swing.JLabel labelRaza;
    private javax.swing.JTextField nombre;
    private javax.swing.JTextField raza;
    private javax.swing.JLabel titulo;
    // End of variables declaration//GEN-END:variables
}
