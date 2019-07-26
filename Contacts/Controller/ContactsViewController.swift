//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/25/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var contactsTableView: UITableView!
    var persons: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiServices.getPersons { (personsData, statusCode) in
            if statusCode == 200 {
                self.persons = personsData!
                print(self.persons[0].city!)
                self.contactsTableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name!
        cell.detailTextLabel?.text = "\(persons[indexPath.row].city!), \(persons[indexPath.row].country!)"
        return cell
    }


}

