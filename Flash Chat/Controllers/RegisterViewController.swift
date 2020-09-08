//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 08/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Initialisation
    var chatMan = ChatManager()
    
    // IBAction
    @IBAction func registerButtonPressed(_ sender: UIButton) {}
}
