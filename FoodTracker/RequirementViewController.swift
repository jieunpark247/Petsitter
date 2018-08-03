//
//  RequirementViewController.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2017. 11. 23..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RequirementViewController: UIViewController, UITextViewDelegate {

    var toId: String!
    //var fromId: String!
    
    var fromId = Auth.auth().currentUser?.uid
    
    var user: petAction?
    var meal: Meal?

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendingMessage(_ sender: UIButton) {
        let ref = Database.database().reference().child("Requirement Info")
        let childRef = ref.childByAutoId()
        
        
        //let toId = user?.id
        //let fromId = Auth.auth().currentUser?.uid
        //let timeStamp = Int(NSNumber(value: Date().timeIntervalSinceNow))
        //let date = NSDate(timeIntervalSince1970: 1432233446145.0/1000.0)
        
        let message = textView.text
        
        let values = ["toID": toId, "fromId": fromId, "message": message]
        childRef.updateChildValues(values){ (error, ref) in
            if error != nil{
                print(error)
                return
            }
            
            let petRequireRef = Database.database().reference().child("Requirement-messages").child(self.fromId!)
            
            let userRequireRef = childRef.key
            petRequireRef.updateChildValues([userRequireRef: 1])
            
            let recipientUserMessagesRef = Database.database().reference().child("Requirement-messages").child(self.toId)
            recipientUserMessagesRef.updateChildValues([userRequireRef: 1])
        }

    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
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
