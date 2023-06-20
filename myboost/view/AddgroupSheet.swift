//
//  AddgroupSheet.swift
//  myboost
//
//  Created by Mac2021 on 17/4/2023.
//

import SwiftUI

struct AddGroupView: View {
    
    @ObservedObject var grp = GroupsViewModel()
    @State var newgroupname: String = ""
    @State var newgroupyear: String = ""
    @State var classroom: String = ""
    @State var emails: [String] = []
    
    @State var email1: String = ""
    @State var email2: String = ""
    @State var email3: String = ""
    
    
    @State var dueDate = Date()
    
    @State var newToDo: String = ""
    @State var textfieldText: String = ""
    
    @State var isShowAlert: Bool = false
    @State var showDatePicker = false
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        return min...max
    }
    
    var alert: Alert {
        Alert(title: Text("Please enter the Task name"), message: Text("Next Task to Do"), dismissButton: .default(Text("OK")))
    }
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            
            Button(action: submit){
                    Text("add group")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                    .padding(.horizontal)
                    .padding(.top,50)
            }
            
            TextField("Group Name", text: $newgroupname)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 16)
                .padding(.vertical)
                .padding(.horizontal)
        
            
            HStack(alignment: .center, spacing: 10) {
                Text("Due Date")
                    .foregroundColor(.primary)
                    .font(.system(size: 21))
                    .bold()
                
                Text("\(dueDate, formatter: dateFormatter)")
                    .foregroundColor(.secondary)
                    .font(.system(size: 20))
                    .bold()
            }.onTapGesture {
                self.showDatePicker.toggle()
            }
            if self.showDatePicker {
                DatePicker(
                    selection: $dueDate,
                    in: dateClosedRange,
                    displayedComponents: [.date],
                    label: {Text("")})
                .datePickerStyle(DefaultDatePickerStyle())
                .padding(.trailing,60)
            }
            
            
            MyTextField(title:"Group Name", text: $classroom)
            MyTextField(title:"Group membre 1", text: $email1)
            MyTextField(title:"Group membre 2", text: $email2)
          
            Button("add emails"){
                
                //addmails(email1: email1,email2: email2);

            }
            
            
        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            .alert(isPresented: $isShowAlert, content:  {
                alert
            })
    }

    func addmails(email1 : String, email2: String){
        emails.insert(email1, at: 0)
        emails.insert(email2, at: 1)
    }

func submit(){
    addmails(email1: email1,email2: email2);
    print("adding group button")
    let params: [String: Any] = ["emails": emails,"name": newgroupname,"year": dateFormatter.string(from: dueDate),"_id":"6436cca4f2ce96bc7ca551c6","classroom":classroom]
    grp.addgroup(param: params)
    
}
}

    struct groupsheet_Previews: PreviewProvider {
        static var previews: some View {
            AddGroupView()
        }
    }
    

