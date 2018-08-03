//
//  ParentCareViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 17..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import SDWebImage
import FirebaseStorage
import MobileCoreServices
import CoreData

class ParentCareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var petInDate: UILabel!
    @IBOutlet weak var petActionList: UILabel!
    @IBOutlet weak var petActionDate: UILabel!

    let imagePicker: UIImagePickerController! = UIImagePickerController()

    var user: Users?
    var meal: Meal?
    var action = [petAction]()
    var pet: petAction?
    
    var fromId: String?
    var toId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        observeAction()
        
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2;
        photoImageView.clipsToBounds = true;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendingMessage(_ sender: UIButton) {
    }
    
    
    func observeAction(){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        var action = [petAction]()
        var actionDictionary = [String: petAction]()
        
        let ref = Database.database().reference().child("Pet-action-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let actionId = snapshot.key
             //Action Info 데이터베이스에 있는 값들을 actionRefeference에 넣어준다.
            let actionReference = Database.database().reference().child("Action Info").child(actionId)
           
            
            //특정 경로의 데이터를 읽고 변경을 수신 대기하려면 FIRDatabaseReference의 observeEventType:withBlock 또는 observeSingleEventOfType:withBlock 메소드를 사용하여 FIRDataEventTypeValue 이벤트를 관찰한다
            //observeSingleEvent 는 데이터 한번 읽고 다시 호출되지 않는다

            actionReference.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                let ref = Database.database().reference().child("Action Info")
                
                //리스너는 이벤트 발생 시점에 데이터베이스에서 지정된 위치에 있던 데이터를 value 속성에 포함하는 FIRDataSnapshot을 수신한다. 이 값을 NSDictionary 등의 적절한 기본 유형에 대입할 수 있습니다. 해당 위치에 데이터가 없는 경우 value는 nil이다
                ref.observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                       
                        let actionMessage = petAction()
                        
                        actionMessage.fromId = dictionary["fromId"] as? String
                        actionMessage.action = dictionary["action"] as? String
                        actionMessage.toId = dictionary["toId"] as? String
                        actionMessage.date = dictionary["date"] as? String
                        actionMessage.inDate = dictionary["inDate"] as? String
                        self.action.append(actionMessage)
                        
                        
                        if let action = actionMessage.action {
                            self.petActionList.text = "- " + actionMessage.action! + ": "
                            self.petActionDate.text = actionMessage.date
                            self.petInDate.text = actionMessage.inDate
                            self.fromId = actionMessage.fromId
                            self.toId = actionMessage.toId
                        }
                        DispatchQueue.main.async {
                            //self.tableView.reloadData()
                            self.view.reloadInputViews()
                        }
                        //self.view.reloadInputViews()
                    }
                    
                    
                    
                }, withCancel: nil)
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }

    @IBAction func petPicture(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        
        // Dismiss the picker.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? RequirementViewController
        //destination?.fromId = toId
        destination?.toId = fromId
        
        
    }

}
