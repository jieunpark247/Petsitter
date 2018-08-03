//
//  ParentViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 17..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
//import FirebaseDatabase
import FirebaseAuth
import Firebase
import UserNotifications

class ParentViewController: UIViewController {
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()

        
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2;
        photoImageView.clipsToBounds = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfUserIsLoggedIn(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Parent Users").child(uid!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject]{
                self.navigationItem.title = dictionary["name"] as? String
            }
        }, withCancel: nil)
    }

    @IBAction func loggedOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    @IBAction func btnPush(_ sender: Any) {
        
      
            let content = UNMutableNotificationContent()
            
            content.title = /*(meal?.name)! + */"마루가"
            //content.subtitle = (meal?.name)!
            content.body = "식사를 했습니다."
            
            content.badge=1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval : 5 , repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add( request, withCompletionHandler: nil )
            
            
            let ref = Database.database().reference().child("Action Info")
            let childRef = ref.childByAutoId()
            
            

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
