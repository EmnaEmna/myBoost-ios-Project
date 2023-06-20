//
//  listofitem.swift
//  myboost
//
//  Created by Apple Esprit on 10/4/2023.
//
import SwiftUI
import Alamofire
import SwiftyJSON


struct GroupsView: View {
    @ObservedObject var grp = GroupsViewModel()
    var body: some View{
            NavigationView{
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(grp.groups) { group in
                            NavigationLink(destination: TasksList(group_id: group.id,group_name:group.name)) {
                                groupcard(name: group.name, year: group.year, classroom: group.classroom)
                            }
                            //.buttonStyle(PlainButtonStyle())
                        }
                    }.onAppear(perform: grp.getgroups)
                }

            }
        
    }
    
    struct groupcard : View{
        var name = "default name"
        var year = "default year"
        var classroom = "default classroom"
        
        var body: some View{
            VStack(alignment: .trailing){
                HStack{
                    
                    Text(name).font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                    //Text("YEAR :")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(year).font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }.padding()
                VStack{
                    Text(classroom)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }.padding()
                
                
            }.frame(maxWidth: .infinity)
                .background(Color("PrimaryColor"))
                .cornerRadius(10.0)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 16)
                .padding(.horizontal , 10.0)
        }
    }

    
    
    struct ItemView_Previews: PreviewProvider {
        static var previews: some View {
            GroupsView()
        }
    }
}
