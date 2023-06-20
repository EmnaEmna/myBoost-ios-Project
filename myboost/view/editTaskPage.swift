//
//  editTaskPage.swift
//  myboost
//
//  Created by Mac2021 on 5/5/2023.
//
//
//  EditTaskView.swift
//  myboost
//
//  Created by Mac2021 on 5/5/2023.
//

import SwiftUI

struct EditTaskView: View {
   @State var task :Task
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var isDatePickerShown = false
  //  let addTask: (String, String, String, String, String,String ) -> Void
    @ObservedObject var viewModel = TasksViewModel()
    @State private var assignedto = ""
    // let addTask: (String, String, String) -> Void
    @State var emailList: [String] = []
    let taskStatus = [ "Doing", "Done"]
    let userDefaults = UserDefaults()
    @State private var  role = ""

    var body: some View {
        
        VStack {
            Image("task_icon9")
                .resizable()
                .cornerRadius(10)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding().padding(.bottom, 10)
            
            TextField("Task Name", text: $task.name)
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color(red: 0.5, green: 0, blue: 0, opacity: 0.1), radius: 10, x: 0, y: 5)
                .padding(.bottom, 20)
            
            TextField("Task Description", text: $task.text)
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color(red: 0.5, green: 0, blue: 0, opacity: 0.1), radius: 10, x: 0, y: 5)
                .padding(.bottom, 20)
            
            TextField("GitHub Link", text: $task.gitlink)
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color(red: 0.5, green: 0, blue: 0, opacity: 0.1), radius: 10, x: 0, y: 5)
                .padding(.bottom, 30)

            if(role == "manager") {
                Button(action: {
                    isDatePickerShown.toggle()
                },label:{
                    Text(task.deadline)
                })
                .sheet(isPresented: $isDatePickerShown) {
                    
                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .onChange(of: selectedDate) { newValue in
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            // replace this with your selected date
                            task.deadline = dateFormatter.string(from: newValue)
                            print("selected date is  \(newValue) ")
                            
                            dismiss()
                        }
                }
            }
                           

            if(role != "manager") {
                Picker("Status", selection: $task.status) {
                                        ForEach(taskStatus, id: \.self) { status in
                                            Text(status)
                                        }
                                    }
            }
                
            if(role == "manager") {
                Picker("Assigned to", selection: $assignedto) {
                    ForEach(emailList, id: \.self) { role in
                        Text(role)
                    }
                }               }
            
            HStack {
                            Spacer()
                         
                
                
                
                
                
                Button(action: {
                    if(task.status == "") {
                        task.status = "doing"
                    }
                    if(role == "manager") {
                        task.status = "to do"
                    }
                    print("status \(task.status)")
                    print("status lower \(task.status.lowercased())")
                    
                    
                    viewModel.editTask( taskid:task.id,name: task.name, text: task.text, gitlink: task.gitlink,assignedto:task.assignedto, deadline:task.deadline,groupId: "",status: task.status.lowercased())
                    dismiss()
                    
                }) {
                    Text("EDIT TASK")
                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 0.980, green:0.294, blue: 0.1647))
                                        .cornerRadius(10)
                                        .shadow(color: Color(red: 0, green: 0, blue: 0.5, opacity: 0.3), radius: 10, x: 0, y: 5)
                                        .padding(.horizontal)


                }
                
                            Spacer()
                        }


            .frame(maxWidth: .infinity, maxHeight: .infinity)

            .navigationBarTitle("New Task", displayMode: .inline)

        }
        .onAppear {
            
            role =  userDefaults.object(forKey: "role") as! String
            print("role is \(role )")
            viewModel.getEmails { emails, error in
                if let emails = emails {
             
                    self.emailList = emails
                    print("emails are ")
                    print(emailList)
                } else {
                    // Handle error
                }
            }
        }
    }    }

/*
struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView()
    }
}*/
