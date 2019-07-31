//
//  ContactInfoViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/31/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    var newPerson : Person?
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var mobileTextField: UILabel!
    @IBOutlet weak var cityTextField: UILabel!
    @IBOutlet weak var countryTextField: UILabel!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Contact Info"
        // Do any additional setup after loading the view.
        if let person = newPerson{
            nameTextField.text = "Name: " + person.name!
            mobileTextField.text = "Mobile: " + String(person.mobile!)
            cityTextField.text = "City: " + person.city!
            countryTextField.text = "Country: " + person.country!
            notesTextView.text = person.notes
        }
    }
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "editPersonSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddContactViewController
        destinationVC.personToAdd = newPerson
    }
}
