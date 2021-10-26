// RegisterViewController class is used to post user to firebase firestore cloud database

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // Email and Password  outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        // To unwrap email and password variables
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            
            // To create authorized user in firebase
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // To handle exceptions
                if let e = error{
                    
                    // To trigger popup window for showing error message
                    let alert = UIAlertController(title: "Error!", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    // To register user in firebase successfully
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
        
    }
    
}
