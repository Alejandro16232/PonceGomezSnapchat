import UIKit
import Firebase
import GoogleSignIn

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presentó el siguiente error: \(error?.localizedDescription ?? "Error desconocido")")
                let alerta = UIAlertController(title: "Error de inicio de sesión", message: "El usuario no existe. ¿Deseas crear una cuenta?", preferredStyle: .alert)
                let btnCrear = UIAlertAction(title: "Crear", style: .default) { _ in
                    self.performSegue(withIdentifier: "mostrarregistro", sender: nil)
                }
                let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                alerta.addAction(btnCrear)
                alerta.addAction(btnCancelar)
                self.present(alerta, animated: true, completion: nil)
            } else {
                print("Inicio de sesión exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

