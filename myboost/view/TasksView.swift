//
//  TasksView.swift
//  myboost
//
//  Created by Mac2021 on 25/4/2023.
//


import SwiftUI


struct TasksView: View {
    
    
    @State private var showTaskForm = false
    @ObservedObject var viewModel = TasksViewModel()
    let groupId = "6448ef98f77b520d891024d1"
    @State private var selectedStatus = "All"
    let userDefaults = UserDefaults()
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
               VStack (spacing: 30){
                                Picker(selection: $selectedStatus, label: Text("Filter by Status")) {
                                 Text("All").tag("All")
                                 Text("To Do").tag("To Do")
                                 Text("Doing").tag("Doing")
                                 Text("Done").tag("Done")
                             }
                             .pickerStyle(SegmentedPickerStyle())
                             .frame(width: 300)
                             .padding(.horizontal)
                             .accentColor(selectedStatus == "To Do" ? Color.green : (selectedStatus == "Doing" ? Color.red : nil))


                           .overlay(
                                 RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(#colorLiteral(red: 0, green:1, blue: 0, alpha: 1)), lineWidth: selectedStatus == "All" ? 2 : 0)
                                     .foregroundColor(.clear)
                                     .padding(.horizontal, -16)
                             )
                            


                    ForEach(viewModel.tasks.filter { task in
                        selectedStatus == "All" || task.status == selectedStatus.lowercased()
                            }) { task in
                                TaskItem(task: task)
                            }
                        

                }
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    viewModel.loadTasks(groupId: groupId)
                }
                
            }
            /*onChange(of: selectedStatus){
                value in
                switch value {
                case "To Do":
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.green
                    case "Doing":
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
                    default:
                    break



                }
            }*/
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showTaskForm = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.red)
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 10, y: 8)
                        
                    }
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showTaskForm) {
            TaskFormView { name, text, gitlink, assignedto, deadline, status  in
                viewModel.addTask(name: name, text: text, gitlink: gitlink, assignedto:assignedto, deadline:deadline ,
                              groupId: groupId,    status : status )
            }
        }

        
    }


    struct TasksView_Previews: PreviewProvider {
        static var previews: some View {
            TasksView()
        }
    }
}





