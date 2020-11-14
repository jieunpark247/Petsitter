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

class ParentViewController: UIViewController {
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2;
        photoImageView.clipsToBounds = true;
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
