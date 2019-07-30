//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/30/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    let dataSource = ["beirut", "dawra", "paris","marseille"]
    var selectedCityName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPickerView.dataSource = self
        cityPickerView.delegate = self

    }

    @IBAction func cancelButton(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        ApiServices.addNewContact(params: ["name" : nameTextField.text! , "mobile":mobileTextField.text!, "notes" : notesTextField.text!, "cityname" : selectedCityName ?? "beirut"])
        _ = self.navigationController?.popToRootViewController(animated: true)
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
