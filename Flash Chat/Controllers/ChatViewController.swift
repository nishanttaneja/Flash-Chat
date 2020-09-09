//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 08/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    // IBAction
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut();
            performSegue(withIdentifier: "ChatToWelcomeScene", sender: self)
        }
        catch {print(error)}
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareForSegue(segue)
    }
}
