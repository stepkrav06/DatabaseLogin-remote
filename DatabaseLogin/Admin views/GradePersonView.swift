//
//  GradePersonView.swift
//
//  The view for grading a person
//
//

import SwiftUI

struct GradePersonView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var user: User
    var event: Event
    var oldGrade: Grade
    @State private var isAbsent: Bool = false
    @State private var activity: Double = 0
    @State private var comments: String = ""
    @State private var gradeSubmitAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0){
            Group{
                Text("Attendance")
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
            }
            HStack{
                
                Toggle(isOn: $isAbsent){
                    Text("Absent")
                        .fontWeight(.light)
                        
                }
                    .padding()
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if !isAbsent{
                // shown if a person attended the event
                Group{
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
                    Spacer()
                        .frame(maxHeight: 20)
                    HStack{
                        Text("0")
                            .fontWeight(.thin)
                        Slider(value: $activity, in: 0...10, step: 1)
                                .accentColor(Color.textColor1)
                        Text("10")
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    Text(String(Int(activity)))
                        .fontWeight(.thin)
                        .offset(x: CGFloat(28.8 * activity - 147))
                    
                }
                Spacer()
                    .frame(maxHeight: 20)
                Group{
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
                    TextEditor(text: $comments)
                                .padding()
                                .frame(maxHeight: 200)
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .frame(height: 1)
                        .padding(.top, 4)
                        .padding(.horizontal)
                                
                }
                
                
            }
            else{
                // shown if a person did not attend the event
                Spacer()
            }
            Button(action: {gradeSubmitAlert.toggle()}){
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.teal)
                        .frame(height:50)
                        .padding()
                    Text("Submit grade")
                        .foregroundColor(.white)
                }
                    
                
                
            }
            .alert("You want to submit the grade?", isPresented: $gradeSubmitAlert) {
                Button("Cancel", role: .none) { }
                Button("Yes", role: .cancel) {
                    if isAbsent{
                        let grade = Grade(attendance: false, activity: "0", comments: "")
                        viewModel.submitGrade(grade: grade, user: user, event: event)
                    } else{
                        let grade = Grade(attendance: true, activity: String(Int(activity)), comments: comments)
                        viewModel.submitGrade(grade: grade, user: user, event: event)
                    }
                    
                    dismiss()
                }
            }
        }
        .navigationTitle(user.name + " " + user.lastName)
        .onAppear{
            self.comments = oldGrade.comments
            self.isAbsent = !oldGrade.attendance
            if oldGrade.activity == ""{
                self.activity = 0
            } else {
                self.activity = Double(oldGrade.activity)!
            }
        }
    }
}

struct GradePersonView_Previews: PreviewProvider {
    static var previews: some View {
        GradePersonView(user: User(uid: "", email: "em", name: "Name", lastName: "Lastname", isAdmin: false, grade: "7"), event: Event(name: "", startDate: Date(), endDate: Date(), isCharity: false), oldGrade: Grade(attendance: false, activity: "", comments: ""))
    }
}
