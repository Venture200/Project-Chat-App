//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Elnur Valikhanli on 25.07.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // Message area
    @IBOutlet weak var messageBubble: UIView!
    
    // Message label
    @IBOutlet weak var label: UILabel!
    
    // Authorized user's avatar
    @IBOutlet weak var rightImageView: UIImageView!
    
    // Other user's avatar
    @IBOutlet weak var leftImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // To make round message area
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
