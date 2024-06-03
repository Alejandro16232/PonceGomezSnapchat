import UIKit
import Firebase

class RegistrarseViewController: UIViewController {

    @IBOutlet weak var txtCorreoRegistro: UITextField!
    
    @IBOutlet weak var txtContrasenaRegistro: UITextField!
    
    @IBOutlet weak var botonRegistrar: UIButton!

    @IBAction func RegistrarTapped(_ sender: Any) {
        guard let email = txtCorreoRegistro.text, !email.isEmpty,
              let password = txtContrasenaRegistro.text, !password.isEmpty else {
            let alerta = UIAlertController(title: "Error", message: "Por favor, ingrese un correo y una contraseña válidos.", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(btnOk)
            self.present(alerta, animated: true, completion: nil)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Se presentó un error al intentar crear un usuario: \(error.localizedDescription)")
                let alerta = UIAlertController(title: "Error", message: "No se pudo crear el usuario. \(error.localizedDescription)", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alerta.addAction(btnOk)
                self.present(alerta, animated: true, completion: nil)
                return
            }

            print("El usuario fue creado exitosamente")
            if let user = user {
                Database.database().reference().child("usuarios").child(user.user.uid).child("email").setValue(user.user.email)
                let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario \(email) se creó correctamente", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Aceptar", style: .default) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                alerta.addAction(btnOk)
                self.present(alerta, animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

