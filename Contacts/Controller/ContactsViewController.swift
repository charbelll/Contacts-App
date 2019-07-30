//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/25/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    var persons: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
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
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addPersonSegue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(persons[indexPath.row].name!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - SearchBar methods

extension ContactsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getUserFromSearch(test: searchBar.text!)
       
        contactsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.getAllUsers()
            }
        }
        else{
            getUserFromSearch(test: searchBar.text!)
            contactsTableView.reloadData()
            
        }
    }
    
    func getUserFromSearch(test: String){
        if let text = searchBar.text{
            ApiServices.getPersonsFromSearch(input: text) { (personsData, statusCode) in
                if statusCode == 200 {
                    if let personData = personsData{
                        self.persons = personData
//                        print(self.persons[0].city!)
//                        print(text)
                        self.contactsTableView.reloadData()}
                }
            }
        }
    }
    
    func getAllUsers(){
        ApiServices.getPersons { (personsData, statusCode) in
            if statusCode == 200 {
                self.persons = personsData!
//                print(self.persons[0].city!)
                
                self.contactsTableView.reloadData()
            }
        }
    }
    
    
}
