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
    @IBOutlet weak var messageTextField: UITextField!
    
    // Variables
    private let db = Firestore.firestore()
    private let messages: [Message] = [
        Message(senderEmail: "abc@abc.com", body: "Hello!", date: Date().timeIntervalSince1970),
        Message(senderEmail: "otherUser", body: "Hi, how are you?", date: Date().timeIntervalSince1970),
        Message(senderEmail: "abc@abc.com", body: "I'm fine, how you doing?", date: Date().timeIntervalSince1970),
        Message(senderEmail: "otherUser", body: "I'm GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT! GREAT!", date: Date().timeIntervalSince1970)
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
    
    // IBActions
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut();
            performSegue(withIdentifier: "ChatToWelcomeScene", sender: self)
        }
        catch {print(error)}
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let message = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": sender,
                "message": message,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let errorWhileSendingMessage = error {print(errorWhileSendingMessage)}
                else {
                    print("message sent successfully.")
                    DispatchQueue.main.async{self.messageTextField.text = nil}
                }
            }
        }
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
        if message.senderEmail==Auth.auth().currentUser?.email {cell.sender = "self"}
        else if message.senderEmail != Auth.auth().currentUser?.email {cell.sender = "otherUser"}
        return cell
    }
}
