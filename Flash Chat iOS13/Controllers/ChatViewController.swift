// ChatViewcontroller class is used to store, write, retrieve data

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    // Table view and message text field outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    // To initialize database
    let db = Firestore.firestore()
    
    // To store messages in array
    var messages : [Message]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To set delegate as table view
        tableView.dataSource = self
        
        // To set application name in Navigation bar
        navigationItem.title = K.appName
        
        // To hide back button in chat view
        navigationItem.hidesBackButton = true;
        
        // To register table view in ChatViewController class
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        // To show messages
        loadMessages()
    }
    
    func loadMessages(){
    
        // To retrieve messages by sorting date
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                // To show error if there is an bug during retrieving
                if let e = error{
                    print("There was an issue retrieving, \(e)")
                }else{
                    
                    // To unwrap snapshotDocuments
                    if let snapshotDocuments = querySnapshot?.documents{
                        
                        // Loop to retrieve message details from database
                        for doc in snapshotDocuments{
                            
                            // To assign message details to new variable
                            let data = doc.data()
                            
                            // To unwrap and separately assign to message and sender variables
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                                
                                // To initialize Message structure
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                
                                // To append messages to messages array
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    
                                    // To reload messages and display on screen
                                    self.tableView.reloadData()
                                    
                                    // To find length of array
                                    let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                    
                                    // To scroll to the latest messages when it loads
                                    self.tableView.scrollToRow(at: indexPath, at: .top  , animated: true)
                                }
                                
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        // To unwrap message body and check authorized user
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
    
            // To write message, sender and date to database
            db.collection(K.FStore.collectionName)
                .addDocument(data: [
                                    K.FStore.senderField: messageSender,
                                    K.FStore.bodyField: messageBody,
                                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                    
                // To show error message in console
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Success!")
                    
                    // To empty message field empty after sending message
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                        
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            // To Navigate to Welcome view (Root View)
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource{
    
    // To return number of cells based on array length
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    // To show message text and sender avatar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // To assign text and sender using indexPath
        let message = messages[indexPath.row]
        
        // To assign cell and force change type as MessageCell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        // To show cell label as message text
        cell.label?.text = message.body
        
        // To check if sender is authorized
        if message.sender == Auth.auth().currentUser?.email{
            
            // To hide avatar on left side
            cell.leftImageView.isHidden = true
            
            // To show avatar on right side
            cell.rightImageView.isHidden = false
            
            // To change message bubble's background color
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            
            // To change message text's color
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            
            // To show avatar on left side
            cell.leftImageView.isHidden = false
            
            // To hide avatar on right side
            cell.rightImageView.isHidden = true
            
            // To change message bubble's background color
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            
            // To change message text's color
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
}
