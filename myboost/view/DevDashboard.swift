//
//  DevDashboard.swift
//  myboost
//
//  Created by Mac2021 on 30/4/2023.
//

import SwiftUI

struct DevDashboard: View {
    var body: some View {
        
            VStack(alignment: .leading){
                
                HStack{
                    Text("Hey")
                        .font(.title3)
                        .padding(.leading, 30)
                        .padding(.top,30)
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
                        .padding(.vertical, 10)
                        
                HStack{
                    VStack(alignment: .leading){
                        Text("Your groups  : ")
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
                    devgroups().scrollContentBackground(.hidden)
                    //RightDownFloatButton()
                }
                
        }
        }
    }

struct devgroups: View {
    @ObservedObject var grp = GroupsViewModel()
    @State var progressValue: Float = 0.5
    var body: some View{
            NavigationView{
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(grp.groups) { group in
                            devdashgroupcard(name: group.name, year: group.year, classroom: group.classroom,allproj: group.allproj,done: group.doneprojts)
                            }
                            //.buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onAppear(perform: grp.getgroups)
                 
                }
        

            }
}


struct devdashgroupcard : View{
    var name = "default name"
    var year = "default year"
    var classroom = "default classroom"
    var allproj = "all"
    var done: Double
   
    
    
    var body: some View{
        VStack(){
            HStack{
                
                Text(name).font(.headline)
                    .fontWeight(.bold)
                
               
                Spacer()
                Image(systemName: "calendar")
                        
                Text(year)
                        .font(.headline)
                        .fontWeight(.bold)
                        
                    
             
            }
            .padding(.top,20)
            .padding(.horizontal, 35)
        
                
            HStack{
                ProgressBar(value: done).frame(height: 10)
                    HStack{
                        Image(systemName: "bookmark.fill")
                        Text(allproj).font(.headline)
                            .fontWeight(.bold)
                        Text("Tasks")
                    }
                    .padding(.leading)
                
            }
            .padding(.horizontal,35)
            .padding(.bottom,15)
        }.frame(maxWidth: .infinity)
            .background(Color("PrimaryColor"))
            .cornerRadius(10.0)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 16)
            .padding(.vertical , 5)
            .padding(.horizontal , 10.0)
        
    }
}

