//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 08/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Initialisation
    var chatMan = ChatManager()
    
    // IBAction
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let errorWhileCreatingUser=error {print(errorWhileCreatingUser); return}
                else {self.performSegue(withIdentifier: "RegisterToChatScene", sender: self)}
            }
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareForSegue(segue)
    }
}


extension UIViewController {
    //MARK:- Navigation
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "RegisterToChatScene": print("registered new user and performing segue with identifier 'RegisterToChatScene'")
        case "LoginToChatScene": print("logged in and performing segue with identifier 'LoginToChatScene'")
        default:
            print("unidentified segue identifier found!")
        }
    }
}
