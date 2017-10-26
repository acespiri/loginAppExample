//
//  ViewController.swift
//  messageApp
//
//  Created by Ace on 2017-10-25.
//  Copyright © 2017 HiiamL0ki. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            self.performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUP" {
            if let destination = segue.destination as? signUpVC {
                if self.userID != nil {
                    destination.userID = userID
                }
                if self.emailTextField.text != nil {
                    destination.emailField = emailTextField.text
                }
                
                if self.passwordTextField != nil {
                    destination.passwordField = passwordTextField.text
                }
            }
        }
    }
    
    //checks to see if the user has an account, create account if not
    @IBAction func signIn(_ sender: AnyObject) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
            if error == nil {
                self.userID = user?.uid
                self.performSegue(withIdentifier: "toMessages", sender: nil)
            } else {
               self.performSegue(withIdentifier: "signUP", sender: nil)
                }
        })
        }
    }
}
