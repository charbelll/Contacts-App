//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/30/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddContactViewController: UIViewController {

    var personToAdd : Person?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var noNameLabel: UILabel!
    @IBOutlet weak var noMobileLabel: UILabel!
    

    
    let dataSource = ["beirut", "dawra", "paris","marseille"]
    var selectedCityName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
        cityPickerView.selectRow(1, inComponent: 0, animated: true)
        loadInfo()
        self.navigationItem.title = "Create New Contact"
    }

    
    @IBAction func cancelButton(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if let person = personToAdd{
            ApiServices.updatePerson(urlExtension: String(person.id!), params: ["name" : nameTextField.text! , "mobile":mobileTextField.text!, "notes" : notesTextField.text ?? "", "cityname" : selectedCityName!])
            SVProgressHUD.showSuccess(withStatus: "Success")
            _ = self.navigationController?.popToRootViewController(animated: true)
        }else{
            submitNewPerson()
            

        }
    }
}

extension AddContactViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCityName = dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
}

extension AddContactViewController {
    func submitNewPerson(){
        if (nameTextField.text?.isEmpty ?? true || mobileTextField.text?.isEmpty ?? true) {
            if(nameTextField.text?.isEmpty ?? true && mobileTextField.text?.isEmpty ?? true){
                noNameLabel.textColor = .red
                noNameLabel.text = "This field is required"
                noMobileLabel.textColor = .red
                noMobileLabel.text = "This field is required"
            }else if(mobileTextField.text?.isEmpty ?? true){
                noMobileLabel.textColor = .red
                noMobileLabel.text = "This field is required"
            }else if(nameTextField.text?.isEmpty ?? true){
                noNameLabel.textColor = .red
                noNameLabel.text = "This firld is required"
            }
        } else {
            ApiServices.addNewContact(params: ["name" : nameTextField.text! , "mobile":mobileTextField.text!, "notes" : notesTextField.text ?? "", "cityname" : selectedCityName!])
            SVProgressHUD.showSuccess(withStatus: "Success")
            noMobileLabel.text = ""
            noNameLabel.text = ""
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func loadInfo(){
        if let newPerson = personToAdd{
            
            nameTextField.text = newPerson.name
            mobileTextField.text = String(newPerson.mobile!)
            notesTextField.text = newPerson.notes
            cityPickerView.selectRow(dataSource.firstIndex(of: newPerson.city!)!, inComponent: 0, animated: true)
            selectedCityName = dataSource[dataSource.firstIndex(of: newPerson.city!)!]
            
        }
    }
}
