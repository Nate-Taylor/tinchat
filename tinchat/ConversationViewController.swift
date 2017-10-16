//
//  ConversationViewController.swift
//  tinchat
//
//  Created by nate.taylor_mac on 11.10.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var conversationTableView: UITableView!
    
    var messages = [(text: String?,id: String?)]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ConversationCell
        if messages[indexPath.row].id == "inMessage" {
            cell = tableView.dequeueReusableCell(withIdentifier: "inMessage", for: indexPath) as! ConversationCell
            cell.messageTextLabel.preferredMaxLayoutWidth = (3/4)*view.frame.width
           } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "outMessage", for: indexPath) as! ConversationCell
            cell.messageTextLabel.preferredMaxLayoutWidth = (3/4)*view.frame.width
        }
        
        cell.tweet = messages[indexPath.row].text
        return cell
    }
    
    func createMessageCellContent(){
        messages.append(("i","inMessage"))
        messages.append(("o","outMessage"))
        messages.append(("30sym: input-message........30","inMessage"))
        messages.append(("30sym: output-message.......30","outMessage"))
        messages.append(("300sym: input-message ................................................................................. .................................................................................................................................................................................................300","inMessage"))
        messages.append(("300sym: output-message ................................................................................ .................................................................................................................................................................................................300","outMessage"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createMessageCellContent()
        self.conversationTableView.estimatedRowHeight = 80
        self.conversationTableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
