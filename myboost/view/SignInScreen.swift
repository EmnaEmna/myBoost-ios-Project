//
//  SignInScreen.swift
//  myboost
//
//  Created by Mac2021 on 13/3/2023.
//

import SwiftUI

struct SignInScreen: View {
    
    struct User {
        var username: String = ""
        var password: String = ""
        var email: String = ""
        
    }
    @State var nextview = false
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var presentAlert = false
    @State private var forget_email: String = ""
    @ObservedObject var viewModel = UserViewModel()
    
    @ObservedObject var Signup = SignupViewModel()
    
    @State var user: User = .init()
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    Image("myboost_logo")
                        .resizable()
                        .frame(width: 132.0, height: 132.0)
                    Spacer()
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                
                    
                    HStack{
                        TextField("Email", text: $Signup.email)
                            .font(.title3)
                            .padding()
                        if !Signup.isEmailValid(){
                            Text("Invalid ")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .padding()
                        }
                    }   .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                        .padding(.vertical)

                    
                    
                    HStack{
                        SecureField("Password", text: $Signup.password )
                            .font(.title3)
                            .padding()
                            
                        if !Signup.isPasswordValid(){
                            Text("Invalid ")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                    }.frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                   
                    Button(action: submit){
                            Text("Connect")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                            .padding(.vertical)
                    }
                    .opacity( Signup.isEmailValid() && Signup.isPasswordValid() ? 1 : 0.6)
                    .disabled(!Signup.isEmailValid() || !Signup.isPasswordValid())
                   
                    }
                
                Spacer()
                Divider()
                
                Button("Forget Password ? Click Here") {
                    presentAlert = true
                }
                .alert("Forget Password", isPresented: $presentAlert, actions: {
                    TextField("Email", text: $forget_email)
                    Button("Reset", action: {})
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter your email to reset your password.")
                })
                }
                .padding()
                .background(NavigationLink(
                    destination:HomeView().navigationBarHidden(true
                                                              ),
                    isActive: $nextview
                ) { EmptyView() })
        }

    }
   

    
func submit()
{
    viewModel.login(email: Signup.email, password: Signup.password, onSuccess: {
        userid,name in
        nextview = true
     
    }, onFailure: { title, message in
        // Show dialog with title and message
        print(title)
        print(message)
    })
}
    
    
}


struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}


struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}

