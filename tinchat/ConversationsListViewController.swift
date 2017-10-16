//
//  ConversationsListViewController.swift
//  tinchat
//
//  Created by nate.taylor_mac on 08.10.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var conversationListTableView: UITableView!
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
    }
    
    var arrOn:[CellContent]=[]
    var arrOff:[CellContent]=[]
    let section = ["Online", "History"]
    
    let namesSection1 = ["Dmitry Klabertanc","Vitaliy Pyatnikov","Ekaterina Shestimerova","Kamil Lotfullin","Artem Belkov","Maxim Stegnienko","Nikita Borodulin","ArtyomKiss","Omar","Sergey Korobok"]
    
    let namesSection2 = ["user11","user12","user13","user14","user15","user16","user17","user18","user19","user20"]
    
    let messages=["hey how are u?","for Asgard!","for Midgard!","I say the nay!","Have at thee!","lieve Hulk alone!","with great power comes great responsibility","yes?","see u!","OK!"]
    
    
    let data = [Date]()
    
    let array = [CellContent]()
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ConversationListCell
        
        if indexPath.section == 0 {
            cell.content = arrOn[indexPath.row]
        } else {
            cell.content = arrOff[indexPath.row]
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toConversation", let destination = segue.destination as? ConversationViewController{
            
            if let cell = sender as? ConversationListCell {
                destination.navigationItem.title = cell.name.text
                
                /*
                let backButton = UIBarButtonItem()
                backButton.title = "Back"
                destination.navigationItem.setLeftBarButton(backButton, animated: true)
                */
                
            }
        }
    }
    
    func createCellContent(){
        for index in 0...9 {
            arrOn.append(CellContent(pName: namesSection1[index], pMessage: messages[index], pOnline: true))
            arrOff.append(CellContent(pName: namesSection2[index]))
        }
        
        arrOn[3].hasUnreadMessages = true
        arrOn[3].date = Date(timeIntervalSince1970: 100)
        
        arrOn[0].date = Date()
        
        arrOff[4].message = "i will be back!"
        arrOff[4].hasUnreadMessages = true
        arrOff[4].date = Date(timeIntervalSinceNow: 20)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2017/10/08 22:31")
        arrOff[0].date = someDateTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCellContent()
        
        self.conversationListTableView.estimatedRowHeight = 80
        self.conversationListTableView.rowHeight = UITableViewAutomaticDimension
        
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
