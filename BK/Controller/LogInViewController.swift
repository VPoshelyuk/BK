//
//  LogInController.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}


//    @IBOutlet weak var emailTextfield: UITextField!
//    @IBOutlet weak var passwordTextfield: UITextField!
//    
//
//    @IBAction func loginPressed(_ sender: UIButton) {
//         if let email  = emailTextfield.text, let password  = passwordTextfield.text {
//            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                if let e = error {
//                    let alert = UIAlertController(title: "Can't Log In!", message: e.localizedDescription, preferredStyle: .actionSheet)
//                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    print(e.localizedDescription)
//                }else{
//                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
//                }
//            }
//        }
//    }
