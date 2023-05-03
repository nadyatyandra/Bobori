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
    @Environment(\.presentationMode) var presentationMode
    var distances = ["Besides crib", "Halfway towards door", "Next to doorway", "Outside the room with opened door", "Outside the room with closed door"]
    
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
                    
                    Text("Entry distance")
                    Picker("Please choose a distance", selection: $distance) {
                        ForEach(distances, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Button(action: {
                        self.entryViewModel.createEntry(date: self.date, bedTime: self.bedTime, distance: self.distance)
                    }) {
                        Text("Save")
                        }
                        .padding()
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .shadow(color: Color.gray, radius: 5)
                    }
                .padding()
            }
        }
    }
}
