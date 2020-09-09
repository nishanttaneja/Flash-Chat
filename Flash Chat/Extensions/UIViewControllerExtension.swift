//
//  UIViewControllerExtension.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 09/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit

extension UIViewController {
    //MARK:- Navigation
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "RegisterToChatScene": print("registered new user and performing segue with identifier 'RegisterToChatScene'")
        case "LoginToChatScene": print("logged in and performing segue with identifier 'LoginToChatScene'")
        case "ChatToWelcomeScene": print("signed out successfully, performing segue with identifier 'ChatToWelcomeScene'")
        default:
            print("unidentified segue identifier found!")
        }
    }
}
