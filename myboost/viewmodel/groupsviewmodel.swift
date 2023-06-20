
import Foundation
import  Alamofire
import Combine
import CoreData
import SwiftUI
import SwiftyJSON
//list test script
class GroupsViewModel : ObservableObject {
    @Published var groups = [GroupModel]()
    private let baseURL = "http://localhost:9090/"

  /*  private let baseURL = "http://192.168.43.46:9090/"
   init (){
        AF.request("http://127.0.0.1:9090/api/group/getgroups",
                   method: .post,
                   parameters: [ "email" : "haythem.daoud@esprit.tn" ],
                   encoding: JSONEncoding.default)
        .responseData {
            (groups) in
            let json = try! JSON(data : groups.data!)
            for i in json{
                self.groups.append(GroupModel(id: i.1["_id"].stringValue, name:  i.1["name"].stringValue, year:  i.1["year"].stringValue, classroom:  i.1["classroom"].stringValue, user:  i.1["user"].stringValue, emails: i.1["emails"].rawValue as! [String] ))
            }
            print(self.groups)
        }
    }*/
    func getgroups(){
        //"haythemdaoud@gmail.com"
        AF.request(baseURL+"api/group/getgroups",
                   method: .post,
                   parameters: [ "email" : UserDefaults.standard.string(forKey: "email")! as String ],
                   encoding: JSONEncoding.default)
        .responseData {
            (groups) in
            let json = try! JSON(data : groups.data!)
            for i in json{
                self.groups.append(GroupModel(id: i.1["_id"].stringValue, name:  i.1["name"].stringValue, year:  i.1["year"].stringValue, classroom:  i.1["classroom"].stringValue, user:  i.1["user"].stringValue, emails: i.1["emails"].rawValue as? [String] ,allproj: i.1["allproj"].stringValue,doneprojtslenght: i.1["doneprojtslenght"].stringValue, doneprojts: i.1["doneprojts"].doubleValue))
            }
            print(self.groups)
            
        }
        groups=[];
    }
    func getallgroups(){
        //"haythemdaoud@gmail.com"
        AF.request(baseURL+"api/group/getallgroupwithdata",
                   method: .post,
                   parameters: [ "email" : UserDefaults.standard.string(forKey: "email")! as String ],
                   encoding: JSONEncoding.default)
        .responseData {
            (groups) in
            let json = try! JSON(data : groups.data!)
            for i in json{
                self.groups.append(GroupModel(id: i.1["_id"].stringValue, name:  i.1["name"].stringValue, year:  i.1["year"].stringValue, classroom:  i.1["classroom"].stringValue, user:  i.1["user"].stringValue, emails: i.1["emails"].rawValue as? [String] ,allproj: i.1["allproj"].stringValue,doneprojtslenght: i.1["doneprojtslenght"].stringValue, doneprojts: i.1["doneprojts"].doubleValue))
            }
            print(self.groups)
            
        }
        groups=[];
    }
    
    
    func addgroup(param: [String: Any]) {
        let url = baseURL+"api/group/creategroup"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let parameters: Parameters = param
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response JSON: \(value)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

