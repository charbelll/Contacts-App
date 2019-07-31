//
//  ApiServices.swift
//  Contacts
//
//  Created by Charbel Nammour on 7/25/19.
//  Copyright © 2019 Charbel Nammour. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class ApiServices {
    
    init() {
    }
    
    static func getPersons( completion: @escaping ([Person]?, Int) -> Void) {
        
        let url = URL(string: API_GETUSERS)!
        
        let req = request(url, method: .get)
        
        req.responseArray { (response: DataResponse<[Person]>) in
            if let res = response.response{
                completion(response.value, res.statusCode)
            }else{
                print("Problem loading elements from database")
            }
        
        }
    }
    
    static func getPersonsFromSearch(input: String? ,completion: @escaping ([Person]?, Int) -> Void) {
        if let requestURL = input {
            let url = URL(string: API_GETUSERFROMSEARCH + requestURL)
            let req = request(url ?? " ", method: .get)
            
            req.responseArray { (response: DataResponse<[Person]>) in
                if let res = response.response {
                    completion(response.value, res.statusCode)
                }
                
            }
        }
    }
    
    static func addNewContact(params : [String : String]){
        Alamofire.request(API_ADDNEWUSER, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }
    }
    
    static func updatePerson(urlExtension: String, params : [String : String]){
        Alamofire.request(API_UPDATEUSER+urlExtension, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            print(API_UPDATEUSER+urlExtension)
            print(response)
        }
    }
}
