//
//  RegisterViewController.swift
//  shelterForDog
//
//  Created by SWUCOMPUTER on 2017. 11. 4..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        //displayLabel.text = textField.text
        return true
        
    } 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createUsers(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text, let name = nameText.text {
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
                let userReference = ref.child("Shelter Users").child(uid)
                let values = ["name": name, "email" : email]
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
    
    /*
    @IBAction func createUsers(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text, let name = nameText.text {
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
                let userReference = ref.child("Shelter Users").child(uid)
                let values = ["name": name, "email" : email]
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
 */
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
