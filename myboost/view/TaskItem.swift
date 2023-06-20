//
//  TaskItem.swift
//  myboost
//
//  Created by Mac2021 on 26/4/2023.
//

import SwiftUI

struct TaskItem: View {
    @State private var showTaskEditForm = false
    @ObservedObject var viewModel = TasksViewModel()
    //var name = "default name"
    //var text = "default description"
    //var gitlink = "https://github.com/your-username/your-repo"
    let groupId = "6448ef98f77b520d891024d1"

    let task :Task
    //@ObservedObject var taskviewModel : TasksView
    @State private var showDetails = false
    
    var body: some View {
        HStack {
            
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                
                HStack{
                    Spacer( )
                    Button(action: {
                        showDetails = true
                    }) {
                        Label("", systemImage: "info.circle")
                    }
                    .foregroundColor(.red)
                    .sheet(isPresented: $showDetails) {
                        TaskDetails(name: task.name, text: task.text, gitlink: task.gitlink,assignedto: task.assignedto, deadline: task.deadline)
                    }
                    
                    /* Menu {
                     Button(action: {
                     }) {
                     Label("Edit", systemImage: "square.and.pencil")
                     }
                     
                     Button(action: {
                     // Action for other menu item
                     }) {
                     Label("delete", systemImage: "trash")
                     }
                     .padding()
                     .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                     .cornerRadius(10)
                     
                     
                     }
                     
                     label: {
                     Image(systemName: "ellipsis")
                     .foregroundColor(.gray)
                     .font(.subheadline)
                     .padding(.trailing)
                     }*/
                    
                    Menu(content: {
                        Button(action: {
                            // Code to edit the task goes here
                            self.showTaskEditForm = true
                            
                            // edittask()
                        }) {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                        
                        Button(action: {
                            // Code to delete the task goes here
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.trailing)
                    })
                    .menuStyle(BorderlessButtonMenuStyle())
                    .buttonStyle(.bordered)
                    
                    .padding(10)
                    .background(
                        ZStack {
                            //  LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 48/255, blue: 51/255), Color(red: 255/255, green: 50/255, blue: 51/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        }
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                Spacer( )
                Text(task.name)
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(task.text)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text(task.gitlink)
                    .font(.body)
                    .foregroundColor(.black)
                
                Text(task.assignedto)
                    .font(.body)
                    .foregroundColor(.green)
                
                Text(task.deadline)
                    .font(.body)
                    .foregroundColor(.red)
            }
            .padding(.leading, 16)
            
            Spacer()
            
            
            
            
        }
        .sheet(isPresented: $showTaskEditForm) {
            EditTaskView(task: task)
            }
            .padding()
            .background(
                Color.white
            )
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.7), radius: 3, x: 5, y: 2)
            .padding(.horizontal)
            
            
            
        }
    }
    
    struct TaskDetails: View {
        var name: String
        var text: String
        var gitlink: String
        var assignedto:String
        var deadline:String
        
        var body: some View {
            VStack {
                Text(name)
                    .font(.title)
                    .padding()
                Text(text)
                    .padding()
                Text(gitlink)
                    .padding()
                Spacer()
                Text(assignedto)
                    .font(.title)
                    .padding()
                Text(deadline)
                    .font(.title)
                    .padding()
                Spacer()
                
            }
        }
    }
    
    
    
    /*struct TaskItem_Previews: PreviewProvider {
     static var previews: some View {
     TaskItem(task: Task(id: "id1", name: "name", gitlink: "gitlink", text: "text", grpoupID: "fff", assignedto:"Ahmedgmailcom", deadline:"05-05-2023" ))
     }
     } */

