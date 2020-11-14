//
//  UserTableViewController.swift
//  FoodTracker
//
//  Created by SWUCOMPUTER on 2017. 11. 18..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class UserTableViewController: UITableViewController,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == ""{
            filterData  = users
        }else {
            filterData=users.filter({($0.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!})
        }
        self.tableView.reloadData()
    }
    
    let cellId = "cellId"

    @IBOutlet weak var searchBar: UISearchBar!
   
    var filterData = [Users]()
 
    var users = [Users]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData  = users
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation  = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        //self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = editButtonItem
        tableView.backgroundView = UIImageView(image: UIImage(named: "2.png"))
      
     
        
//        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: "handleCancel")
//
//
//        func handleCancel(){
//            dismiss(animated: true, completion: nil)
//        }
        
        
        self.navigationItem.title = "주인 선택"
        fetchUser()
    }
    
    
    func fetchUser(){
        //DB의 Parent User 부분의 값들을 가져온다.
        // single 로 하고 싶다면 Auth.auth().currentUser.?uid 부분을 가져온다. 각각의 parent user 의 값들(uid )를 가리킨다.  == nil  그래서 observesingleEventType 실행  snapshot으로 보내주면 특정 값1개를 보내줄 수 있음-> self.navigaion.title로 제목설정 등 할 수 있다.
        //밑은 여러개 값들을 뿌려주는 방법!
        // Parent user의 모든 유저의 데이터베이스 값들을 snapshot에 넣어줘 뿌려준다
        Database.database().reference().child("Parent Users").observe(.childAdded, with: { (snapshot) in
            //snap의 값들을 dictionary 형태로 가져온다.
            //firebase dictionary key 와 your class properties가 일치하지 않는다면 crash이 날 것이다.
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = Users()
                user.id = snapshot.key
                //user.setValuesForKeys(dictionary)
                
                user.name = dictionary["name"] as! String
                user.email = dictionary["email"] as! String
                self.users.append(user) // 배열뒤에 값 추가
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData() //this will crash b/c background thread  so, let use dispatch _async to fix
                }
                
                print(user.name, user.email)
            }
            
            //print(snapshot)
            
        }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
           return filterData.count
    
        // #warning Incomplete implementation, return the number of rows
        //return users.count //user count 만큼 table view 추가
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Cells", for: indexPath)
        //dequeueReusableCell란? 화면에 볼 수 있는 tablecell만 뿌려주게 만들어준다.(모든 cell을 보여주지 않아도 되기 때문에 데이터를 줄일 수 있다.)
        
        // Configure the cell...
        let user = users[indexPath.row] // cell 에 값들 뿌려주기 firebase 의 데이터 값들을 user에 넣어둔것을 가져와 tablecell 에 뿌려준다.
       
          cell.textLabel?.text = self.filterData[indexPath.row].name
            cell.detailTextLabel?.text = self.filterData[indexPath.row].email
     
    
      //      cell.textLabel?.text = user.name
       //     cell.detailTextLabel?.text = user.email
        
     
     
  
       
        return cell
    }
    
    //var mealTableViewController: MealTableViewController?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        self.selectUser(user: user)
    }

    func selectUser(user: Users){
        let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let addInVC:MealViewController = storyboard.instantiateViewController(withIdentifier: "PetAddViewController") as! MealViewController
        //self.present(loggedInVC, animated: true, completion: nil)
        addInVC.user = user
        self.navigationController!.pushViewController(addInVC, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MealViewController
        
        
        //destination.
    }


}
