//
//  ShelterViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 15..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
//import FirebaseAuth


class ShelterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserIsLoggedIn()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func checkIfUserIsLoggedIn(){ // ShelterUser에 데이터 값(이름)을 load 한다.
        let uid = Auth.auth().currentUser?.uid
        //한 번만 호출되고 즉시 삭제되는 콜백이 필요한 경우가 있다. 이후에 변경되지 않는 UI 요소를 초기화할 때가 observeSingleEvent를 사용
        Database.database().reference().child("Shelter Users").child(uid!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject]{
                self.navigationItem.title = dictionary["name"] as? String
            }
        }, withCancel: nil)
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
