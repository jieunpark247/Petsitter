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
import GoogleSignIn
import FirebaseMessaging

class ParentLoginViewController: UIViewController, UITextFieldDelegate,GIDSignInUIDelegate {
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
//        if Auth.auth().currentUser != nil{
//            self.presentLoggedInScreen()
//        }
        
         GIDSignIn.sharedInstance().uiDelegate = self //델리게이트
        
        //키값이 맞으면 자동로그인
        if UserDefaults.standard.bool(forKey: "USERLOGGEDIN") == true{
            //user is already logged in just navigate him to home  screen
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
        
            //각자 아이디별로 토큰이 만들어어진다.
            let uid = Auth.auth().currentUser?.uid
            let token = InstanceID.instanceID().token()
            // let fcmToken=Messaging.messaging().fcmToken
            Database.database().reference().child("Parent Users").child(uid!).updateChildValues(["pushToken":token!]) // 내 데이터베이스 계정에 넣어준다. setvalue 는 기존 데이터 다 날라감 update를 해서 덮어씌워줘야 한다.
            // print("Firebase registration token: \(fcmToken)")
          
            print("FCM token: \(token ?? "")")
            print("success!")
            
            //자동 로그인하기위해 아이디비번이 맞다면 키값 저장
            UserDefaults.standard.set(true, forKey: "USERLOGGEDIN")
             self.presentLoggedInScreen()
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
    
    @IBAction func SignInButton(_ sender: Any) {

           GIDSignIn.sharedInstance().signIn() //회원가입 신청
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
