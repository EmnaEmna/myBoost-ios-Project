//
//  userviewmodel.swift
//  myboost
//
//  Created by Apple Esprit on 6/4/2023.
//

import Foundation
import  Alamofire
import Combine
import CoreData

class UserViewModel: ObservableObject {
    var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated = false
    @Published var isRegistred = false
    private let baseURL = "http://172.17.1.141:9090"
    
    func login(email: String, password: String, onSuccess: @escaping (_ userid: String,_ name: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"/api/users/login" ,
                   method: .post,
                   parameters: [ "email" : email , "password" : password  ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<403)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                    guard let userid = jsonData["_id"] as? String,
                          let name = jsonData["name"] as? String,
                          let email = jsonData["email"] as? String,
                          let token = jsonData["token"] as? String,
                          let role = jsonData["role"] as? String
                            
                    else {
                        onFailure("Error", "Invalid response format")
                        return
                    }
                    let user = User(email: email, name: name, token: token, role : role)
                    self.currentUser = user
                    // Store token in UserDefaults
                   
                    print(userid)
                    UserDefaults.standard.set(name, forKey: "username")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(userid, forKey: "id")
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(role, forKey: "role")
                    


print()
                    
                    // Set isAuthenticated to true and navigate to home page
                    onSuccess(String(userid),name)
                    
                case 400:
                    onFailure("Login failed", "Invalid password")
                case 402:
                    onFailure("Account not activated", "Your email address has not been verified")
                default:
                    onFailure("User not found", "This email address is not associated with any account")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    
    func Signup(email: String, password: String, name: String, onSuccess: @escaping () -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"/api/users/register" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password, "name" : name ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<401)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 201:
                 //   self.isRegistred = true
                    onSuccess()
                case 400:
                    onFailure("Register failed", "This email is already associated to an account . please use another one or reset your password")
                default:
                    onFailure("Error", "something went wrong please try again")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    /*
    func editprofile( name: String, onSucess: @escaping () -> Void, onFailure: @escaping (Result<String, Error>) -> Void) {
        let userd =  UserDefaults.standard

        let headers: HTTPHeaders = [        "Authorization": "Bearer \(userd.string(forKey: "token"))"    ]
        AF.request(baseURL+"api/users/\(userd.string(forKey: "id"))",
                   method: .patch,
                   parameters: ["name" : name],
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    guard let jsonData = data as? [String: Any],
                          let statusCode = response.response?.statusCode else {
                        onFailure("Error", "Invalid response format")
                        return
                    }
                    
                    switch statusCode {
                    case 200:
                        onSuccess()
                    default:
                        onFailure("Error", "something went wrong please try again")
                    }
                case .failure(let error):
                    onFailure("Error", error.localizedDescription)
                }
        }
    }*/
    func editprofile( name: String, completion: @escaping  (Result<String, Error>) -> Void) {
        let userd =  UserDefaults.standard
print(userd.object(forKey: "id")!,"taht id")
        let headers: HTTPHeaders = [        "Authorization": "Bearer \(userd.string(forKey: "token")!)"    ]
        AF.request(baseURL+"/api/userp/editInfo/\(userd.string(forKey: "id")!)",
                   method: .patch,
                   parameters: ["name" : name],
                   encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let value):
                
                if let dict = value as? [String: Any], let email = dict["email"] as? String, let name = dict["name"] as? String{
                    // Save the token to UserDefaults
                 
                    print(name)
                    UserDefaults.standard.set(email, forKey: "jwtToken")
                    completion(.success(email))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response serialization failed"])
                    completion(.failure(error))

                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    
                   }
    
    
    func editpass( password: String, completion: @escaping  (Result<String, Error>) -> Void) {
        let userd =  UserDefaults.standard
print(userd.object(forKey: "id")!,"taht id")
        let headers: HTTPHeaders = [        "Authorization": "Bearer \(userd.string(forKey: "token")!)"    ]
        AF.request(baseURL+"api/userp/editInfo/\(userd.string(forKey: "id")!)",
                   method: .patch,
                   parameters: ["password" : password],
                   encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let value):
                
                if let dict = value as? [String: Any], let email = dict["email"] as? String, let name = dict["name"] as? String{
                    // Save the token to UserDefaults
                 
                    print(name)
                    UserDefaults.standard.set(email, forKey: "jwtToken")
                    completion(.success(email))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response serialization failed"])
                    completion(.failure(error))

                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    
                   }
    
    
    
       //     @Published var profileImage: UIImage?
       // @Published var selectedImage: UIImage?
        
       /* func uploadImage(_ image: UIImage) {
            // Call the uploadImage function with a completion handler that updates the profileImage property with the uploaded image
            uploadImage(image) { [weak self] result in
                switch result {
                case .success(let filePath):
                    // If the upload is successful, update the profileImage property with the uploaded image
                    if let url = URL(string: filePath), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        self?.profileImage = image
                    }
                    
                case .failure(let error):
                    // If there is an error, print the error message
                    print(error.localizedDescription)
                }
            }
        }*/
        
       /* private func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
            let imageData = image.jpegData(compressionQuality: 0.5)!
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: "http://localhost:3000/upload")
            .responseString { response in
                switch response.result {
                case .success(let filePath):
                    completion(.success(filePath))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }*/
    





      /*
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
            let imageData = image.jpegData(compressionQuality: 0.5)!
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: "http://localhost:3000/upload")
            .responseString { response in
                switch response.result {
                case .success(let filePath):
                    completion(.success(filePath))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }*/

  /*
    
    func PostImage(url : UIImage){
        // Access Shared Defaults Object
        let userd = UserDefaults.standard

        // Read/Get Value
        let email = userd.object(forKey: "email") as? String ?? ""


        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
        },
            to: (baseURL+"/user/updateImage/")+email, method: .post , headers: headers)
            .response { resp in
                print(resp)

        }

    }*/
    
    
    func updateprofil(email: String,name: String, onSuccess: @escaping (_ resmeg: String ) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"api/userp/editus" ,
                   method: .post,
                   parameters: [ "email" : email, "name" : name ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<401)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                 //   self.isRegistred = true
                    onSuccess("Update with succes")
                case 400:
                    onFailure("Register failed", "This email is already associated to an account . please use another one or reset your password")
                default:
                    onFailure("Error", "something went wrong please try again")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    
    func modifyString(_ input: String) -> String {
        let startIndex = input.index(input.startIndex, offsetBy: 8)
        let endIndex = input.index(input.endIndex, offsetBy: -3)
        return String(input[startIndex..<endIndex])
    }
}


