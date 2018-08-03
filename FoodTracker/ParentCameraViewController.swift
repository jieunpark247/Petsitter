//
//  ParentCameraViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 25..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage
import FirebaseStorage

class ParentCameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate{
    
    var id :UIImage!
    var customImageFlowLayout: CustomImageFlowLayout1!
    @IBOutlet weak var burstAlbumCollectionView: UICollectionView!
    var dbRef: DatabaseReference!
    var images = [DogImage] ()
    //var imageCell = [Doggy]()
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    class Photo {
        var img: UIImage = UIImage()
        init(){
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dbRef = Database.database().reference().child("images")
        loadDB()
        customImageFlowLayout = CustomImageFlowLayout1()
        burstAlbumCollectionView.collectionViewLayout=customImageFlowLayout
        burstAlbumCollectionView.backgroundColor = .white
        
        
        
        
    }
    
    func loadDB(){
        
        dbRef.observe(DataEventType.value, with:{ (snapshot) in
            var newImage = [DogImage]()
            
            for dogImageSnapshot in snapshot.children{
                let dogImageObject = DogImage(snapshot: dogImageSnapshot as! DataSnapshot)
                newImage.append(dogImageObject)
            }
            self.images=newImage
            self.burstAlbumCollectionView.reloadData()
        })

 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? CameraCollectionViewCell{
            
            
            let image = images[indexPath.row]
            cell.imageView.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
            
            return cell
        }
        else {
            
            return UICollectionViewCell()
        }
        
        
    }
    
     func randomString(_ length: Int) -> String{
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length{
            let rand = arc4random_uniform(len)
            var nextChar=letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    @IBAction func Delete(_ sender: Any) {
        
    }
    
       
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        burstAlbumCollectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! CameraCollectionViewCell
        
        var selectedimage = UIImage ()
        selectedimage = (cell.imageView.image)!
        
        
        
        
        // let selectedCar = Photo()
        
        if let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC" ) as? PhotoViewController{
            destinationController.selectedimage = selectedimage
            navigationController?.pushViewController(destinationController, animated: true)
            
            
        }
        
        
    }

    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewLargePhoto"{
            let destinationViewController = segue.destination as! PhotoViewController
            //    destinationViewController.imageView1 = id
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }*/
}
