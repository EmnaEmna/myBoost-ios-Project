//
//  SignUpScreen.swift
//  myboost
//
//  Created by Mac2021 on 13/3/2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Spacer()
                    Image("myboost_logo")
                        .resizable()
                        .frame(width: 132.0, height: 132.0)
                    Spacer()
                    
                    NavigationLink(destination: SignInScreen().navigationBarHidden(false),
                                   
                    label: {
                        PrimaryButton(title: "Get Started")
                    }
                    
                    )
                      HStack {
                          Spacer(minLength: 30.0)
                          Text("New around here? ")
                        NavigationLink(
                            destination: SignUpScreen().navigationBarHidden(false),
                            
                            label: {
                                
                                Text("Sign Up")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                    .padding(.vertical)
                            })
                            .navigationBarHidden(true)
                          //Spacer(minLength: 25.0)
                      }
                }.padding(.bottom,100)
                .padding()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
