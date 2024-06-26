//
//  GradeViewDetailedNonAdmin.swift
//
//  The view with detailed grade informaiton for regular users
//
//

import SwiftUI
import Firebase

struct GradeViewDetailedNonAdmin: View {
    var event: Event
    @EnvironmentObject var viewModel: AppViewModel
    @State var grades = Grade(attendance: true, activity: "", comments: "")
    var body: some View {
        VStack(spacing: 0){
            if grades.attendance{
            Text("Activity")
                .font(.body)
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.top, 4)
                .padding(.horizontal)
           
            Text("My grade: \(grades.activity)")
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text("Comments")
                .font(.body)
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.top, 4)
                .padding(.horizontal)
            Text(grades.comments)
                .fontWeight(.thin)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(32)
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(minHeight: 50)
                        .foregroundColor(Color.lightGray)
                        .padding()
                }
            }
            else{
                Text("You did not participate in this event")
                    .fontWeight(.thin)
                    .padding()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle(event.name)
        .onAppear{
            // grade information loaded
            let ref = Database.database().reference(withPath: "grades").child(viewModel.currentLoggedUser!.uid)
            
                
            
                ref.child(event.sid).observe(.value, with: { snapshot in
                                        
                     
                        let grade = Grade(snapshot: snapshot)
                        grades = grade!
                        
                  
                
                }) { (error) in
                    print(error.localizedDescription)
                }
            
        }
    }
}

struct GradeViewDetailedNonAdmin_Previews: PreviewProvider {
    static var previews: some View {
        GradeViewDetailedNonAdmin(event: Event(name: "", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
