//
//  ConversationListCell.swift
//  tinchat
//
//  Created by nate.taylor_mac on 09.10.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit


class ConversationListCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var content: CellContent?{
        didSet{
            name.text = content?.name
            
            if content?.online == true {
                self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.7, alpha: 1.0)
            } else {
                self.backgroundColor = UIColor.white
            }
            
            if let tweet = content?.message {
                message.font = UIFont.preferredFont(forTextStyle: .body)
                message.text = tweet
            } else {
                UIFont.preferredFont(forTextStyle: .caption2)
                message.text = "No messages yet"
            }
            
            if content?.message != nil {
                if content?.hasUnreadMessages == true {
                    message.font = UIFont.boldSystemFont(ofSize: 17.0)
                } else {
                    message.font = UIFont.preferredFont(forTextStyle: .body)
                }
            }
            
            if content?.date != nil {
                date.text = content?.setDate()
            } else{
                date.text = "--"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
