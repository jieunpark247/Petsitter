//
//  NotificationModel.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2018. 8. 29..
//  Copyright © 2018년 Apple Inc. All rights reserved.
//

import ObjectMapper

class NotificationModel: Mappable {
    
    public var to :String?
    public var notification: Notification = Notification()

    init(){
        
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        to<-map["to"]
        notification <- map["notification"]
    }
    class Notification:Mappable{
        public var title : String?
        public var text :String?
        
        init(){
            
        }
        required init?(map: Map) {
            
        }
        func mapping(map: Map) {
             title <- map["title"]
            text <- map["text"]
        }
    }
}
