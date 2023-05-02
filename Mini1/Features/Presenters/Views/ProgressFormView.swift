//
//  AddEntryView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import SwiftUI

struct ProgressFormView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    @State private var bedTime: Date = Date()
    @State private var date: Date = Date()
    @State private var distance = ""
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Section(header: Text("sementara pilih tgl dr sini")) {
                        FormattedDate(date: self.date)
                        DatePicker("pilih tgl", selection: $date,
                                   in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    }
                    
                    Section(header: Text("What time does ur child sleep today?")) {
                        FormattedTime(time: self.bedTime)
                        DatePicker("", selection: $bedTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    TextField("Entry distance", text: $distance).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
                    
                    Button(action: {
//                        if !self.date.isEmpty && !self.bedHour.isEmpty {
//                        self.entryController.createEntry(title: self.title, entryDescription: self.description)
                        self.entryViewModel.createEntry(date: self.date, bedTime: self.bedTime, distance: self.distance)
//                            self.title = ""
//                            self.description = ""
//
//                            self.presentationMode.wrappedValue.dismiss()
//                        } else {
//                            self.isShowingAlert = true
//                        }
                          
                    }) {
                        Text("Save")
                        }.padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).shadow(color: Color.gray, radius: 5)
                    Spacer()
                    }.padding().navigationBarTitle("Add Entry", displayMode: .inline).alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Warning"), message: Text("Please make sure both the title and the description aren't empty!"), dismissButton: .default(Text("OK!")))
                }
            }
        }
    }
}
