//
//  observer.swift
//  myboost
//
//  Created by Mac2021 on 12/4/2023.
//

import Foundation
import  Alamofire
import Combine
import CoreData
import SwiftUI
import SwiftyJSON
//list test script
class observer : ObservableObject {
    

    @Published var datas = [ItemModel]()
     init (){
     AF.request("https://api.github.com/users/hadley/orgs").responseData {
     (data) in
     let json = try! JSON(data : data.data!)
     for i in json{
     print(i.0)
     self.datas.append(ItemModel(id: i.1["id"].intValue, login: i.1["login"].stringValue, avatar_url: i.1["avatar_url"].stringValue))
     }
     }
     
     }
 
}
