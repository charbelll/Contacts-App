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
            
            completion(response.value, response.response!.statusCode)
        }
    }
}
