//
//  ProfileSettigsView.swift
//  myboost
//
//  Created by Mac2021 on 5/4/2023.
//

import SwiftUI


struct ProfileSettigsView1: View {
    struct User {
        var username: String = "Emna"
        var password: String = ""
        var email: String = "emna@esprit.tn"
        var age: String = "25"
    }
    @State var showlogin=false
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    @State var user: User = .init()

    var body : some View {

        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                
                Button(action: {
                    showlogin = true
                },
                           label: {
                Text("Edit")
                    .font(.system(size: 20, weight: .bold))
            })
              

                VStack {
                    VStack{
                        Text(" My Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                    }
                    .padding(.vertical)
                    
                    Image("profilee")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            isImagePickerPresented = true
                        }



                        Text(user.username)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                            .padding(.vertical)

                        
                        Text( user.email)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                            .padding(.vertical)
                        
                       /* Text( "Age: " + user.age + "  ans")
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                            .padding(.vertical)*/
                        
                        Text("Password:    " + "**********")
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                            .padding(.vertical)

                        /* PrimaryButton(title: "Email me a signup link").padding(.vertical)*/
                    }
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                }
                .padding()
            }
        .fullScreenCover(isPresented: $showlogin, content: {
                        ProfileView()
              //  .edgesIgnoringSafeArea(.bottom)
                             })
        }
      
    }
    
    
    struct ProfileSettigsView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileSettigsView1()
        }
    }
    
