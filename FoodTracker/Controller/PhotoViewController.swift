//
//  PhotoViewController.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2017. 11. 22..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var selectedimage = UIImage()
     //var id :UIImage!
    @IBOutlet weak var imageView1: UIImageView!
      
    @IBAction func btnCancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnAction(_ sender: Any) {
    }
    
    
    @IBAction func btnTrash(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      imageView1.image = selectedimage
        
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

