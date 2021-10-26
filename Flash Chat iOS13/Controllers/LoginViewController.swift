// LoginViewController class is used to authenticate user to log in sucessfully

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // Email and Password input fields
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        // To unwrap email and password variables
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            
            // To check authorized user in firebase
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    
                    // To trigger popup window for showing error message
                    let alert = UIAlertController(title: "Error!", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    // To access chat view successfully
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
                
            }
        }
        
    }
    
}
