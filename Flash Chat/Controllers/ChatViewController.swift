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
    private var messages: [Message] = []
    
    // Override View Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationController Customisation
        navigationItem.hidesBackButton = true
        // Delegates|DataSources
        tableView.delegate = self
        tableView.dataSource = self
        // Register Custom Message Cell
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        // Fetch Messages
        loadMessages()
    }
    
    // IBActions
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut();
            performSegue(withIdentifier: "ChatToWelcomeScene", sender: self)
        }
        catch {print(error)}
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let message = messageTextField.text, let senderEmail = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "senderEmail": senderEmail,
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
    
    //MARK:- Fetch Messages
    func loadMessages() {
        db.collection("messages").order(by: "date").addSnapshotListener { (querySnapshot, error) in
            if let snapshotError = error {print(snapshotError); return}
            self.messages = []
            if let snapshotDocuments = querySnapshot?.documents {
                for doc in snapshotDocuments {
                    let data = doc.data()
                    if let senderEmail=data["senderEmail"] as? String, let message=data["message"] as? String, let date=data["date"] as? TimeInterval {
                        let newMessage = Message(senderEmail: senderEmail, body: message, date: date)
                        self.messages.append(newMessage)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
        }
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
