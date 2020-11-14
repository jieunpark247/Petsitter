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


class ShowViewController: UIViewController {
    
    @IBOutlet var nameText: UILabel!
    @IBOutlet var sexText: UILabel!
    @IBOutlet var birthText: UILabel!
    @IBOutlet var kindText: UILabel!
    @IBOutlet var infoText: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var mealSwitch: UISwitch!
    @IBOutlet var snackSwitch: UISwitch!
    @IBOutlet var poopSwitch: UISwitch!
    @IBOutlet var walkSwitch: UISwitch!
    @IBOutlet var bathSwitch: UISwitch!
    
    
/*
    @IBOutlet var nameText: UILabel!
    @IBOutlet var sexText: UILabel!
    @IBOutlet var birthText: UILabel!
    @IBOutlet var kindText: UILabel!
    @IBOutlet var infoText: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var mealSwitch: UISwitch!
    @IBOutlet var snackSwitch: UISwitch!
    @IBOutlet var poopSwitch: UISwitch!
    @IBOutlet var walkSwitch: UISwitch!
    @IBOutlet var bathSwitch: UISwitch!
 */
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let meal = meal {
            navigationItem.title = meal.name
            nameText.text = meal.name
            photoImageView.image = meal.photo
            photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2;
            photoImageView.clipsToBounds = true;
            birthText.text = meal.birth
            kindText.text = meal.kind
            sexText.text = meal.sex
            infoText.text = meal.info
            
            //ratingControl.rating = meal.rating
        }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge ], completionHandler:{didAllow,Error in
            
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func switchNotification(_ sender: UISwitch) {
        
        
            if mealSwitch.isOn{
            
            let content = UNMutableNotificationContent()
 
            content.title = (meal?.name)! + "행동 알림"
            //content.subtitle = (meal?.name)!
                content.body = "식사를 했습니다."
            
            content.badge=1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
 
            }else if snackSwitch.isOn{
                let content = UNMutableNotificationContent()
                
                content.title = (meal?.name)! + "행동 알림"
                //content.subtitle = (meal?.name)!
                content.body = "간식을 먹었습니다."
                
                content.badge=1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            }else if poopSwitch.isOn{
                let content = UNMutableNotificationContent()
                
                content.title = (meal?.name)! + "행동 알림"
                //content.subtitle = (meal?.name)!
                content.body = "대소변을 했습니다."
                
                content.badge=1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            }else if walkSwitch.isOn{
                let content = UNMutableNotificationContent()
                
                content.title = (meal?.name)! + "행동 알림"
                //content.subtitle = (meal?.name)!
                content.body = "산책을 했습니다."
                
                content.badge=1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            }else if bathSwitch.isOn{
                let content = UNMutableNotificationContent()
                
                content.title = (meal?.name)! + "행동 알림"
                //content.subtitle = (meal?.name)!
                content.body = "목욕을 했습니다."
                
                content.badge=1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
                let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            }
        
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
