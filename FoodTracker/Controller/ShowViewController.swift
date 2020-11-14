//
//  ShowViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 11..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import os.log
import UserNotifications
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class ShowViewController: UIViewController {
    //var meal: Meal?
    var user: Users?
    var pushusers = [PushUsers]()
    var action: petAction?
    var requirement = [Requirement]()
    var textmessage : String?
    var toId: String?
    var fromId: String?
    var inDate: String?
    var notificationModel = NotificationModel()
    public var destinationUid :String? // 나중에 내가 보낼 대상의 uid
    let uid = Auth.auth().currentUser?.uid
    
    @IBOutlet var nameText: UILabel!
    @IBOutlet var sexText: UILabel!
    @IBOutlet var birthText: UILabel!
    @IBOutlet var kindText: UILabel!
    @IBOutlet var infoText: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var mealButton: UIButton!
    @IBOutlet var snackButton: UIButton!
    @IBOutlet var poopButton: UIButton!
    @IBOutlet var walkButton: UIButton!
    @IBOutlet var bathButton: UIButton!
    
    
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeInfoFromParent()

        if let meal = meal {
            navigationItem.title = meal.name
            nameText.text = meal.name
            photoImageView.image = meal.photo
            photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2;
            photoImageView.clipsToBounds = true;
            birthText.text = meal.birth
            kindText.text = meal.kind
            sexText.text = meal.sex
            //infoText.text = meal.info
            
            //ratingControl.rating = meal.rating
        }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge ], completionHandler:{didAllow,Error in
            
            
        })
        
        // Do any additional setup after loading the view.
    }

    
    
    func observeInfoFromParent(){
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let ref = Database.database().reference().child("Requirement-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let actionId = snapshot.key
            let actionReference = Database.database().reference().child("Requirement Info").child(actionId)
            
            actionReference.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                let ref = Database.database().reference().child("Requirement Info")
                ref.observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        let requirementMessage = Requirement()
                        
                        requirementMessage.fromId = dictionary["fromId"] as? String
                        requirementMessage.toId = dictionary["toId"] as? String
                        requirementMessage.message = dictionary["message"] as? String
                        self.requirement.append(requirementMessage)
                        
                        
                        print(requirementMessage.message )//??뒤에 추가
                        print(requirementMessage.fromId )
                        if requirementMessage.fromId == self.toId{
                            self.infoText.text = requirementMessage.message!
                        }
                        
                        /*
                         if let message = requirementMessage.message {
                         self.infoText.text = requirementMessage.message!
                         }
                         */
                        DispatchQueue.main.async {
                            //self.tableView.reloadData()
                            self.view.reloadInputViews()
                        }
                        //self.view.reloadInputViews()
                    }
                    
                }, withCancel: nil)
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func sendPush(){
//
//            let actionReference = Database.database().reference().child("Action Info").child(self.toId!)
//            actionReference.observeSingleEvent(of: .value, with: { (snapshot) in
//              //  print(snapshot)
//                let ref = Database.database().reference().child("Action Info")
//               ref.observe(.childAdded, with: { (snapshot) in
//                    if let dictionary = snapshot.value as? [String: AnyObject]{
//                        let pushuser = PushUsers()
//
//                        pushuser.date = dictionary["date"] as? String
//                        pushuser.id = dictionary["toID"] as? String
//                        pushuser.action = dictionary["action"] as? String
//
//                       // self.pushusers.append(pushuser)
//                        print("action: \(pushuser.action)" )//??뒤에 추가
//                        print("action: \(pushuser.id )")
//                        if pushuser.id == self.toId{
//                        self.textmessage = pushuser.date! + "에 강아지 " + (self.meal?.name)! + pushuser.action! + " 했습니다"
//                            // self.sendGum()
//
//                        }
//                    }
//
//                }, withCancel: nil)
//
//        }, withCancel: nil)
//
//      //  self.sendGum()
//    }
//
    //noti=========================================================
    func sendGum(){
        let url = "https://gcm-http.googleapis.com/gcm/send"
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization":"key=AIzaSyDPuMscXpqLmIl1cdc5txeAOKWCBOh8yg8"
        ]
        
        Database.database().reference().child("Parent Users").child(self.toId!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject]{
               let pushToken = dictionary["pushToken"] as? String
                self.notificationModel.to = pushToken
                print(pushToken)
                let name = dictionary["name"] as? String
                self.notificationModel.notification.title = name! + "님 "
                self.notificationModel.notification.text =  self.textmessage//보내는 내용
                print("textmessage: \(self.textmessage)")
            }
        }, withCancel: nil)
        
        let params =  self.notificationModel.toJSON()

        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.result.value)
        }
    }
    // ================================================
        
    @IBAction func buttonPressed(_ sender: UIButton) {
       
        if sender == mealButton{
            
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
            let dateNow: String = dateFormatter.string(from: now as Date)
            
            
            let values = ["toID": toId, "fromId": fromId, "action": "식사 완료", "date": dateNow, "inDate": inDate]
            
            // 다른 하위 노드를 덮어쓰지 않고 특정 하위 노드에 동시에 쓰려면 updateChildValues 메소드를 사용합니다. 특정필드 업데이트
            
            childRef.updateChildValues(values){ (error, ref) in
                if error != nil{
                    print(error)
                    return
                }
                let petActionRef = Database.database().reference().child("Pet-action-messages").child(self.toId!)
                
                let userActionRef = childRef.key
                petActionRef.updateChildValues([userActionRef: 1])
                
            }

            let action =  values["action"] as? String
            let date =  values["date"] as? String
            print(action)
            print(date)
            self.textmessage = date! + "에 강아!지 " + (self.meal?.name)! + action! + " 했습니다"
            self.sendGum()
        }
    
        else if  sender == snackButton{
            let content = UNMutableNotificationContent()
            
            content.title = "펫시터"
            //content.subtitle = (meal?.name)!
            content.body = "간식을 먹었습니다."
            
            content.badge=2
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
            let dateNow: String = dateFormatter.string(from: now as Date)
            
            
            let values = ["toID": toId, "fromId": fromId, "action": "간식 완료", "date": dateNow, "inDate": inDate]
            childRef.updateChildValues(values){ (error, ref) in
                if error != nil{
                    print(error)
                    return
                }
                let petActionRef = Database.database().reference().child("Pet-action-messages").child(self.toId!)
                
                let userActionRef = childRef.key
                petActionRef.updateChildValues([userActionRef: 1])
                
    }
    

            let action =  values["action"] as? String
            let date =  values["date"] as? String
            print(action)
            print(date)
            self.textmessage = date! + "에 강아지 " + (self.meal?.name)! + action! + " 했습니다"
            self.sendGum()
            
            
        }else if  sender == poopButton{
            let content = UNMutableNotificationContent()
            
            content.title = (meal?.name)! + "행동 알림"
            //content.subtitle = (meal?.name)!
            content.body = "대소변을 했습니다."
            
            content.badge=3
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
            let dateNow: String = dateFormatter.string(from: now as Date)
            
            
            let values = ["toID": toId, "fromId": fromId, "action": "대소변 완료", "date": dateNow, "inDate": inDate]
            childRef.updateChildValues(values){ (error, ref) in
                if error != nil{
                    print(error)
                    return
                }
                let petActionRef = Database.database().reference().child("Pet-action-messages").child(self.toId!)
                
                let userActionRef = childRef.key
                petActionRef.updateChildValues([userActionRef: 1])
            
            }
            
            let action =  values["action"] as? String
            let date =  values["date"] as? String
            print(action)
            print(date)
            self.textmessage = date! + "에 강아지 " + (self.meal?.name)! + action! + " 했습니다"
            self.sendGum()
            
        }else if  sender == walkButton{
            
            
            let content = UNMutableNotificationContent()
            
            content.title = (meal?.name)! + "행동 알림"
            //content.subtitle = (meal?.name)!
            content.body = "산책을 했습니다."
            
            content.badge=4
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
            let dateNow: String = dateFormatter.string(from: now as Date)
            
            
            let values = ["toID": toId, "fromId": fromId, "action": "산책 완료", "date": dateNow, "inDate": inDate]
            childRef.updateChildValues(values){ (error, ref) in
                if error != nil{
                    print(error)
                    return
                }
                let petActionRef = Database.database().reference().child("Pet-action-messages").child(self.toId!)
                
                let userActionRef = childRef.key
                petActionRef.updateChildValues([userActionRef: 1])
            }
            let action =  values["action"] as? String
            let date =  values["date"] as? String
            print(action)
            print(date)
            self.textmessage = date! + "에 강아지 " + (self.meal?.name)! + action! + " 했습니다"
            self.sendGum()
            
            
        }else if  sender == bathButton{
            
            let content = UNMutableNotificationContent()
            
            content.title = (meal?.name)! + "행동 알림"
            //content.subtitle = (meal?.name)!
            content.body = "목욕을 했습니다."
            
            content.badge=5
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale!
            let dateNow: String = dateFormatter.string(from: now as Date)
            
            
            let values = ["toID": toId, "fromId": fromId, "action": "목욕 완료", "date": dateNow, "inDate": inDate]
            childRef.updateChildValues(values){ (error, ref) in
                if error != nil{
                    print(error)
                    return
                }
                let petActionRef = Database.database().reference().child("Pet-action-messages").child(self.toId!)
          
            }
            
   
            let action =  values["action"] as? String
            let date =  values["date"] as? String
            print(action)
            print(date)
            self.textmessage = date! + "에 강아지 " + (self.meal?.name)! + action! + " 했습니다"
            self.sendGum()
            
        }
        
        
        
        
       //   self.sendPush()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? PopUpViewController
        //destination?.toId = toId
        //destination?.fromId = fromId
        destination?.name = meal?.name
        
    }

    
    
}
