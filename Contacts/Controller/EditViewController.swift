//
//  EditViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/25/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class EditViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getContactData(url: getUserURL)
    }
    
    
    var persons : [String] = ["charbel","ghady","mona"]
//    let getUserURL = "http://localhost:4000/edit"
    var perso = [Person]()
    func getContactData(url: String){
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print("Success")
//                print(response.result.value!)
                let usersData : JSON = JSON(response.result.value!)
                
                for user in usersData{
                    print(user.1["name"])
                }
            }
            else{
                print("Error: \(response.result.error!)")
            }
        }
    }
    
 
    
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row]
        return cell
    }
}

