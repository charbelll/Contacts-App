//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/25/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactsViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        getAllUsers()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactInfoSegue"{
        let destinationVC = segue.destination as! ContactInfoViewController
        if let indexPath = contactsTableView.indexPathForSelectedRow{
            destinationVC.newPerson = persons[indexPath.row]
            }
        }
    }
    
}

//Mark: - TableView methods

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
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
        performSegue(withIdentifier: "ContactInfoSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            let alert = UIAlertController(title: "Delete Contact?", message: "Are you sure you want to delete this contact?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                completion(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                ApiServices.deletePerson(urlExtension: String(self.persons[indexPath.row].id!))
                self.persons.remove(at: indexPath.row)
                self.contactsTableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }))
            
            self.present(alert, animated: true)
        }
        return action
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
