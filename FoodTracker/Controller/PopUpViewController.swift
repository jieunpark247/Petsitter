//
//  PopUpViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 26..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet var message: UILabel!
    var name: String?
    @IBOutlet var popUpView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        message.text = name! + " 주인님께 알림전송!"
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
