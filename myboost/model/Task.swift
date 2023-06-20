//
//  Task.swift
//  myboost
//
//  Created by Mac2021 on 25/4/2023.
//

import Foundation


struct Task: Identifiable, Decodable,Hashable {
    var id: String
    var name: String
    var gitlink: String
    var text: String
    var grpoupID: String
    var assignedto: String
    var deadline: String
    var status : String

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case gitlink
        case text
        case grpoupID = "group"
        case assignedto
        case deadline
        case status
    }
}

