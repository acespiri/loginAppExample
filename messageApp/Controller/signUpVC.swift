//
//  signUpVC.swift
//  messageApp
//
//  Created by Ace on 2017-10-25.
//  Copyright © 2017 HiiamL0ki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class signUpVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    var userID: String!
    var emailField: String!
    var passwordField: String!
    var username: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            self.performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }

    @IBAction func createAccount(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField, password: passwordField, completion: { (user, error) in
            if error != nil {
                print("unable to create user")
            } else {
                if let user = user {
                    self.userID = user.uid
                    print("account created")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
