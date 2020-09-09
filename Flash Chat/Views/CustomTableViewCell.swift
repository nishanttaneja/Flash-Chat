//
//  CustomTableViewCell.swift
//  Flash Chat
//
//  Created by Nishant Taneja on 09/09/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // IBOutlet:- Label
    @IBOutlet weak var messageLabel: UILabel!
    // IBOutlet:- ImageViews
    @IBOutlet weak var otherUserProfilePhoto: UIImageView!
    @IBOutlet weak var selfProfilePhoto: UIImageView!
    // IBOutlet:- View
    @IBOutlet weak var messageView: UIView!
    
    var sender: String? {
        willSet {
            if newValue=="self" {
                otherUserProfilePhoto.isHidden = true
                messageLabel.textAlignment = .right
                selfProfilePhoto.isHidden = false
            }
            else if newValue=="otherUser" {
                selfProfilePhoto.isHidden = true
                messageLabel.textAlignment = .left
                otherUserProfilePhoto.isHidden = false
            }
            messageView.layer.cornerRadius = 5
        }
    }
}
