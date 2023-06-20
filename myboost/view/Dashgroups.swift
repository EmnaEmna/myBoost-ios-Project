//
//  Dashgroups.swift
//  myboost
//
//  Created by Mac2021 on 30/4/2023.
//

import SwiftUI

struct Dashgroups: View {
    @ObservedObject var grp = GroupsViewModel()
    var body: some View{
            NavigationView{
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(grp.groups) { group in
                            
                            dashgroupcard(name: group.name, year: group.year, classroom: group.classroom,allproj: group.allproj,done: group.doneprojts)
                            }
                            //.buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onAppear(perform: grp.getallgroups)
                }

            }
        
    }
    
    struct dashgroupcard : View{
        var name = "default name"
        var year = "default year"
        var classroom = "default classroom"
        var allproj = "all"
        var done: Double
        
        
        var body: some View{
            HStack(){
                VStack(alignment: .leading){
                    
                    Text(name)
                        .padding(.leading,30)
                        .padding(.top,20)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(classroom)
                        .padding(.leading,30)
                        .padding(.top,10)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    HStack{
                        Image(systemName: "calendar")
                            .padding(.leading)
                        Text(year)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                    }
                    .padding(.leading)
                    .padding(.bottom)
                }
                Spacer()
                VStack(alignment: .center){
                    
                    CircularProgressView(progress: done)
                        //.padding(.vertical)
                        .padding(.trailing)
                        .padding(.top,15)
                        .frame(width: 100,height: 100)
                    HStack{
                        Image(systemName: "bookmark.fill")
                        Text(allproj)
                           
                            
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Tasks")
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.trailing)
                    .padding(.bottom)
                    
                }.padding(.trailing,15)
                
            }.frame(maxWidth: .infinity)
                .background(Color("PrimaryColor"))
                .cornerRadius(10.0)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 16)
                .padding(.vertical , 5)
                .padding(.horizontal , 10.0)
            
        }
    }


