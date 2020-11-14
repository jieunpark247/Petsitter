import UIKit
import MobileCoreServices
import Photos
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage
import FirebaseStorage



class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate{
    
    var id :UIImage!
    var customImageFlowLayout: CustomImageFlowLayout1!
    @IBOutlet weak var burstAlbumCollectionView: UICollectionView!
    var dbRef: DatabaseReference!
    var images = [DogImage] ()
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
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // I want to upload th
            var data = Data()
            data = UIImageJPEGRepresentation(pickedimage, 0.8)!
            
            let imageRef = Storage.storage().reference().child("images/" + randomString(20))
            
            _ = imageRef.putData(data,metadata : nil){ (metadata,error) in
                guard let metadata = metadata else {
                    return
                }
                let downloadURL = metadata.downloadURL()
                
                print(downloadURL?.absoluteString ?? "")
                
                let key = self.dbRef.childByAutoId().key
                let image = ["url": downloadURL?.absoluteString]
                
                let childUpdates = ["/\(key)" : image]
                self.dbRef.updateChildValues(childUpdates)
                
            }
            
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
    
    
    //addphoto
    @IBAction func addPhoto(_ sender: UIBarButtonItem) {
        
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        /*
         imagePicker.allowsEditing = false
         imagePicker.sourceType = .photoLibrary
         present(imagePicker, animated: true, completion: nil)
         */
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        burstAlbumCollectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! CameraCollectionViewCell
        
        var selectedimage = UIImage ()
        selectedimage = (cell.imageView.image)!
        
        
        
        
        // let selectedCar = Photo()
        
        if let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC" ) as? PhotoViewController{
            //destinationController.selectedimage = selectedimage
            navigationController?.pushViewController(destinationController, animated: true)
            
            
        }
        
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "viewLargePhoto"{
     let destinationViewController = segue.destination as! PhotoViewController
     destinationViewController.imageView1 = id
     navigationController?.pushViewController(destinationViewController, animated: true)
     }
     }*/
}
