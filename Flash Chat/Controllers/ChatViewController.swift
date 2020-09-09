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
    // IBOutlet
    @IBOutlet var tableView: UITableView!
    
    // Variable
    let messages: [Message] = [
        Message(sender: "self", body: "Hello!"),
        Message(sender: "otherUser", body: "Hi, how are you?"),
        Message(sender: "self", body: "I'm fine, how you doing?"),
        Message(sender: "otherUser", body: "I'm GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT!")
    ]
    
    // Override View Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegates|DataSources
        tableView.delegate = self
        tableView.dataSource = self
        // Register Custom Message Cell
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
    }
    
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

//MARK:- TableView Delegate|DataSource
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! CustomTableViewCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.body
        cell.sender = message.sender
        return cell
    }
}
