//
//  SignUpController.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var preferenceArray: [String] = []
    var preferenceDictionary = [String: Any]()
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var showsBtn: UIButton!
    @IBOutlet weak var moviesBtn: UIButton!
    @IBOutlet weak var gamesBtn: UIButton!
    @IBAction func moveToLoginVC(_ sender: UIButton) {
        weak var presentingViewController = self.presentingViewController
        self.dismiss(animated: true, completion: {
            presentingViewController?.performSegue(withIdentifier: "toLogIn", sender: nil)
        })
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        for pref in preferenceArray {
            var genreDictionary = [String: Int]()
            if pref == "Games" {
        
            }else{
                genreDictionary = [
                    "28": 0,
                    "12": 0,
                    "16": 0,
                    "35": 0,
                    "80": 0,
                    "99": 0,
                    "18": 0,
                    "10751": 0,
                    "36": 0,
                    "27": 0,
                    "10402": 0,
                    "10749": 0,
                    "878": 0,
                    "53": 0,
                    "10752": 0,
                    "37": 0
                ]
            }
            preferenceDictionary[pref] = ["genres": genreDictionary, "seen": [0]]
        }
        if let email  = emailTF.text, let password  = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Can't register user", message: e.localizedDescription, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(e.localizedDescription)
                }else if let authData = authResult{
                    print(authData)
                    let dict: Dictionary <String, Any> = [
                        "uid" : authData.user.uid,
                        "email" : authData.user.email as Any,
                        "preferences" : self.preferenceDictionary
                    ]
                    
                    Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: {
                        (error, ref) in
                        if error == nil {
                            print("Done")
                        }
                    })
                    self.performSegue(withIdentifier: "toPref", sender: self)
                }
            }
        }
    }
    
    
    @IBAction func interestPicked(_ sender: UIButton) {
        if sender.backgroundColor == UIColor(red: 248/255, green: 174/255, blue: 52/255, alpha: 1){
            sender.setTitleColor(.black, for: .normal)
            sender.backgroundColor = .white
            preferenceArray.remove(object: sender.title(for: .normal)!)
        }else{
            sender.setTitleColor(UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1), for: .normal)
            sender.backgroundColor = UIColor(red: 248/255, green: 174/255, blue: 52/255, alpha: 1)
            preferenceArray.append(sender.title(for: .normal)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
