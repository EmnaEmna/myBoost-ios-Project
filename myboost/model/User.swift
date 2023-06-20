//
//  User.swift
//  myboost
//
//  Created by Apple Esprit on 6/4/2023.
//

struct User: Codable {
    let id:String
    let email: String
    let name : String
    let token : String
    let age : Int?
    let password : String?
    let role : String

    init(id:String = "",email: String, name: String, token: String, age: Int? = nil, password: String? = nil, role : String = "") {

            self.email = email

            self.name = name

            self.token = token

            self.age = age

            self.password = password

            self.id = id
        self.role = role

        }

    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case name
        case token
        case age
        case password
        case role 


    }
}
