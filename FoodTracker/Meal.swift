//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log


class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    var toId: String?
    var fromId: String?
    var name: String
    var photo: UIImage?
    //var rating: Int
    var sex: String
    var birth: String
    //var info: String
    var kind: String
    var date: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        static let toId = "toId"
        static let fromId = "fromId"
        static let name = "name"
        static let photo = "photo"
        //static let rating = "rating"
        static let sex = "sex"
        static let birth = "birth"
        //static let info = "info"
        static let kind = "kind"
        static let date = "date"
    }
    
    //MARK: Initialization
    
    init?(toId: String, fromId: String, name: String, photo: UIImage?,  sex: String, birth: String,kind: String, date: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        /*
         // The rating must be between 0 and 5 inclusively
         guard (rating >= 0) && (rating <= 5) else {
         return nil
         }
         
         // Initialization should fail if there is no name or if the rating is negative.
         if name.isEmpty || rating < 0  {
         return nil
         }*/
        
        // Initialize stored properties.
        self.toId = toId
        self.fromId = fromId
        self.name = name
        self.photo = photo
        //self.rating = rating
        self.sex = sex
        self.birth = birth
        //self.info = info
        self.kind = kind
        self.date = date
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(toId, forKey: PropertyKey.toId)
        aCoder.encode(fromId, forKey: PropertyKey.fromId)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        //aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(sex, forKey: PropertyKey.sex)
        aCoder.encode(birth, forKey: PropertyKey.birth)
        //aCoder.encode(info, forKey: PropertyKey.info)
        aCoder.encode(kind, forKey: PropertyKey.kind)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let toId = aDecoder.decodeObject(forKey: PropertyKey.toId) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let fromId = aDecoder.decodeObject(forKey: PropertyKey.fromId) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        guard let sex = aDecoder.decodeObject(forKey: PropertyKey.sex) as? String else {
            os_log("Unable to decode the sex for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let birth = aDecoder.decodeObject(forKey: PropertyKey.birth) as? String else {
            os_log("Unable to decode the birth for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        /*
        guard let info = aDecoder.decodeObject(forKey: PropertyKey.info) as? String else {
            os_log("Unable to decode the info for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }*/
        guard let kind = aDecoder.decodeObject(forKey: PropertyKey.kind) as? String else {
            os_log("Unable to decode the kind for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the kind for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        //let sex = aDecoder.decodeObject(forKey: PropertyKey.sex)
        //        let kind = aDecoder.decodeObject(forKey: PropertyKey.kind)
        
        // Must call designated initializer.
        self.init(toId: toId, fromId: fromId, name: name, photo: photo, sex: sex, birth: birth, kind: kind, date: date)
        
    }
}
