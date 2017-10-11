//
//  ConversationCell.swift
//  tinchat
//
//  Created by nate.taylor_mac on 11.10.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration : class {
    var tweet : String? {get set}
}

class ConversationCell: UITableViewCell, MessageCellConfiguration {
    @IBOutlet weak var messageTextLabel: UILabel!
    
    var tweet : String? {
        didSet{
            if tweet != nil {
                messageTextLabel.text = tweet
            }else{
                messageTextLabel.text = "message wasn't found"
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
