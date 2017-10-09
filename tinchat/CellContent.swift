//
//  CellContent.swift
//  tinchat
//
//  Created by nate.taylor_mac on 09.10.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration {
    var name : String? {get set}
    var message : String? {get set}
    var date : Date? {get set}
    var online : Bool {get set}
    var hasUnreadMessages : Bool {get set}
}

struct CellContent: ConversationCellConfiguration {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
    
    init(pName: String?, pMessage: String? = nil, pOnline: Bool = false, pHasUnreadmessages: Bool = false, pDate: Date? = nil){
        name = pName
        message = pMessage
        date = pDate
        online = pOnline
        hasUnreadMessages = pHasUnreadmessages
    }
    
    func setDate () -> String {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let myFormatter = DateFormatter()
        
        if date! < yesterday! {
            myFormatter.dateFormat = "dd MMM"
        } else {
            myFormatter.dateFormat = "HH:MM"
        }
        
        return myFormatter.string(from: date!)
    }
}
