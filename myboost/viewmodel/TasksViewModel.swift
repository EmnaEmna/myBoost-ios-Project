//
//  TasksModel.swift
//  myboost
//
//  Created by Mac2021 on 25/4/2023.
//

import Foundation
import  Alamofire
import Combine
import CoreData
import SwiftUI
import SwiftyJSON

class TasksViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
   
    
    
   
    func loadTasks(groupId:String ) {
      //  let baseUrl = "http://192.168.43.178:9090"
        let baseUrl = "http://172.17.1.141:9090"

        let params = ["groupId":"6448ef98f77b520d891024d1"]
        
        AF.request(baseUrl+"/api/project/getProject",
                   method: .post,
                   parameters: params)
      
       
    
            .responseData {
                (tasks) in
                let json = try! JSON(data : tasks.data!)
                for i in json{
                    self.tasks.append(Task(id: i.1["_id"].stringValue, name:  i.1["name"].stringValue, gitlink:  i.1["gitlink"].stringValue, text:  i.1["text"].stringValue,
                                           grpoupID:  i.1["group"].stringValue, assignedto:  i.1["assignedto"].stringValue, deadline:  i.1["deadline"].stringValue, status:  i.1["status"].stringValue))
                }
                print(self.tasks)
            }

        }
    
    
    
    
   /* func addTask(name: String, text: String, gitlink: String,grpoupID: String ) {
        let newTask = Task(id: UUID().uuidString, name: name, gitlink: gitlink, text: text, grpoupID: grpoupID)
        tasks.append(newTask)
    }*/
    
    func addTask(name: String, text: String, gitlink: String, assignedto:String, deadline:String, groupId: String,status :String ) {
        let baseUrl = "http://172.17.1.141:9090"

        let parameters: Parameters = [
            "name": name,
            "text": text,
            "gitlink": gitlink,
            "assignedto": assignedto,
            "status":status,
            "deadline": deadline,
            "groupId": "6448ef98f77b520d891024d1"
        ]

        AF.request(baseUrl+"/api/project/createproject", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Task.self) { response in
                switch response.result {
                case .success(let task):
                    self.tasks.append(task)
                case .failure(let error):
                    print(error)
                }
            }
    }
    


    func getEmails(completion: @escaping ([String]?, Error?) -> Void) {
        let baseUrl = "http://172.17.1.141:9090"
        let params = ["groupId":"6448ef98f77b520d891024d1"]
        print("hereerer1454584")
        AF.request(baseUrl+"/api/project/getEmails",
                   method: .get,
                   parameters: params)
            .responseJSON { response in
                if case .success(let json) = response.result {
                    let emailList = response.value as? [String]
                    completion(emailList, nil)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to retrieve emails"])
                    completion(nil, error)
                }
            }
    }




    func editTask( taskid: String , name: String, text: String, gitlink: String, assignedto:String, deadline:String, groupId: String,status :String ) {

        let baseUrl = "http://172.17.1.141:9090"

        let parameters: Parameters = [
            
            "name": name,
            "text": text,
            "gitlink": gitlink,
            "assignedto": assignedto,
            "status":status,
            "deadline": deadline,
            "groupId": "6448ef98f77b520d891024d1"
        ]

        AF.request(baseUrl+"/api/project/updatePROJECT/?taskid=\(taskid)", method: .put
                   , parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Task.self) { response in
                switch response.result {
                case .success(let task):
                    self.tasks.append(task)
                case .failure(let error):
                    print(error)
                }
            }
    }
    


        
        
    }
    



