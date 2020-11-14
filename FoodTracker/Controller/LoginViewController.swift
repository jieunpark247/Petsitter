//
//  LoginViewController.swift
//  shelterForDog
//
//  Created by SWUCOMPUTER on 2017. 10. 20..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    let num = 1;
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //displayLabel.text = textField.text
        return true
        
    } 

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    //@IBOutlet var idTextField: UITextField!
    //@IBOutlet var pwTextField: UITextField!
    //@IBOutlet var signInButton: UIButton!
    
    
   /*
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
    }
    */
    
    
    
    
       //var isSignIn:Bool = true
    let ref = Database.database().reference(fromURL: "https://petsitter-388aa.firebaseio.com/")
    //ref.updateChildValues()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self //델리게이트
        

       
        // Do any additional setup after loading the view.
        


    
    }
    


    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.presentLoggedInScreen()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        /*
        if let email = idTextField.text, let password = pwTextField.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                // ...
                
                if let firebaseError = error{
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                print("success!")
                
            })
        }
 */
    }
    //로그인하기
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
  
    
    
    
    
    
    
    
    
    
    
    /*
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
*/
    /*
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
    */
    
 
    
    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let loggedInVC:ShelterViewController = storyboard.instantiateViewController(withIdentifier: "ShelterViewController") as! ShelterViewController
        //self.present(loggedInVC, animated: true, completion: nil)
        self.navigationController!.pushViewController(loggedInVC, animated: true)
    }
 
 
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SettingViewController
        destination.title = "강아지 정보를 입력해주세요."
    }
 */
  
    /*
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        //do some form validation on the email and password
        
        if let email = idTextField.text, let pass = pwTextField.text{
            if isSignIn{
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    // check that user isnt nil
                    if let u = user{
                        //user is found
                        self.performSegue(withIdentifier: "toLogin", sender: self)
                    }else{
                        //error
                    }
                }
                
            }else{
                //register
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    // ...
                    if let u = user{
                        self.performSegue(withIdentifier: "toLogin", sender: self)
                    }else{
                        
                    }
                }
            }
        }
        
        
        
    }
    
 */
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        //destination.title = nameText.text
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }

}
