//
//  ParentLoginViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 17..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ParentLoginViewController: UIViewController, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //displayLabel.text = textField.text
        return true
        
    }
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.presentLoggedInScreen()
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        if let email = idTextField.text, let password = pwTextField.text{
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error{
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                print("success!")
            })
        }
        
    }

    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let loggedInVC:ParentViewController = storyboard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
        //self.present(loggedInVC, animated: true, completion: nil)
        self.navigationController!.pushViewController(loggedInVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
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
