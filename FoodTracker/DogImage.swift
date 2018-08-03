//
//  DogImage.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2017. 11. 21..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
struct DogImage {
    
    let key:String!
    let url:String!
    
    let itemRef:DatabaseReference?
    
    init(url:String,key:String) {
        self.key=key
        self.url=url
        self.itemRef=nil
        
    }
    init(snapshot : DataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
    
        if let imageUrl = snapshotValue?["url"] as? String{
                url = imageUrl
            
        }else{
            url=""
        }
    }
}
