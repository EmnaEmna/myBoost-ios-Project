//
//  ManagerDashboard.swift
//  myboost
//
//  Created by Mac2021 on 30/4/2023.
//

import SwiftUI

struct ManagerDashboard: View {
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text("Hey Mr " + UserDefaults.standard.string(forKey: "name")! as String)
                    .font(.title3)
                    .padding(.leading, 30)
                    .padding(.top,30)
               /* Text(UserDefaults.standard.string(forKey: "name")! as String)
                    .font(.title3)
                    .padding(.leading, 30)
                    .padding(.top,30)*/
                /*Text("username")
                    .padding(.leading, 30)
                    .padding(.top,30)*/
            }
            HStack( ){
                Text("What's your plan ? ")
                    .font(.largeTitle)
                    .padding(.leading,30)
            }
            
                WeatherView()
                    .padding(.leading)
                    .padding(.horizontal, 10)
                    .padding(.vertical,10)
            HStack{
                VStack(alignment: .leading){
                    Text("All groups  : ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryColor"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.2),radius: 60, x: 0.0, y: 16)
                        .padding(.horizontal)
                        .padding(.top ,10)
                }
                
            }
            VStack{
                Dashgroups().scrollContentBackground(.hidden)
                //RightDownFloatButton()
            }
            
    }
    }
}



