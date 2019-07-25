import Foundation
import ObjectMapper

class Person: Mappable, Codable  {
    
    var country: String?
    var name: String?
    var city: String?
    var notes: String?
    var mobile: Int?
    var id: Int?
    
    required init?(map: Map) {
        country <- map["country"]
        name <- map["name"]
        city <- map["city"]
        mobile <- map["mobile"]
        notes <- map["notes"]
        id <- map["id"]
    }
    
    func mapping(map: Map) {
        
    }
    
}
