//
//  ParentRegisterViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 17..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ParentRegisterViewController: UIViewController, UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        //displayLabel.text = textField.text
        return true
        
    }
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var phoneText: UITextField!
    
    
    @IBAction func createUsers(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text, let name = nameText.text, let phone = phoneText.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                // ...
                
                if let firebaseError = error{
                    print(firebaseError.localizedDescription)
                    return
                }
                //self.presentLoggedInScreen()
                guard let uid = user?.uid else{
                    return
                }
                let ref = Database.database().reference(fromURL: "https://petsitter-87985.firebaseio.com/")
                let userReference = ref.child("Parent Users").child(uid)
                let values = ["name": name, "email" : email, "phone" : phone]
                userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil{
                        print("err")
                        return
                    }
                    print("save user successfully into Firebase db")
                })
                
                
                
            })
            
            
            print("success!")
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
