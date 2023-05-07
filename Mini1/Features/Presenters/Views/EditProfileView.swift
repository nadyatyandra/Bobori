//
//  EditProfileView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var showProfile: Bool
    @State var oldName: String = ""
    @Binding var newName: String
    @Binding var time: Date
    @StateObject var EKManager: EventKitManager = EventKitManager()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var entryViewModel: EntryViewModel
    
    var body: some View {
        ZStack {
            Color("paleBlue").ignoresSafeArea()
            VStack {
                Image("ProfilePicture")
                    .frame(width: 116, height: 116)
                    .padding(.top, 100)
                VStack{
                    Text("Name")
                        .font(Font.custom("Comfortaa", size: 21))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, -150)
                        .padding(.top, -50)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 305, height: 45)
                        
                        .overlay(
                            TextField("", text: $newName)
                                .font(Font.custom("Nunito ExtraLight", size: 18))
                                .foregroundColor(Color("paleBlue"))
                                .padding(.leading)
                        )
                        .padding(.top, -30)
                    Text("Sleeping Time")
                        .font(Font.custom("Comfortaa", size: 21))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, -150)
                        .padding(.top, 30)
                    
                    DatePicker("Sleeping Time", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .frame(width: 299, height: 210)
                        .background(Color.white)
                        .cornerRadius(20)

                    Spacer()
                    
                    Button(action: {
                        withAnimation() {
                            EKManager.editReminder(oldName: oldName, newName: newName, hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time))
                            
                            entryViewModel.saveToChild(entry: entryViewModel.child[0], name: newName, bedTime: time)
                            
                            showProfile = false
                        }
                    }, label: {
                        Text("Save")
                            .font(.system(size: 21))
                            .foregroundColor(profileViewModel.nameIsEmpty(name: newName) ? Color.white : Color("paleBlue"))
                            .frame(width: 210, height: 55)
                            .background(profileViewModel.nameIsEmpty(name: newName) ? Color.gray : Color.white)
                            .cornerRadius(70)
                            .padding(.top)
                            .padding(.trailing, -10)
                        
                    })
                    .disabled(profileViewModel.nameIsEmpty(name: newName))
                } .padding(.top, 100)
            }
        }
    }
}
