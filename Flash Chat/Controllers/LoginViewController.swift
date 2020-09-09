//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 08/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    // IBOutlets
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    // Override View Method
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    // IBAction
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email=emailTextField.text, let password=passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let authenticationError = error {print(authenticationError.localizedDescription); return}
                else {self.performSegue(withIdentifier: "LoginToChatScene", sender: self)}
            }
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {prepareForSegue(segue)}
}
