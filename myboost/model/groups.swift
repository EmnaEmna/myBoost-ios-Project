//
//  groups.swift
//  myboost
//
//  Created by Mac2021 on 11/4/2023.
//

import Foundation


struct GroupModel: Codable,Identifiable {
    let id: String
    let name: String
    let year: String?
    let classroom: String?
    let user: String
    let emails: [String]
}

