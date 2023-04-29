//
//  CalendarView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI
import EventKit

struct ProgressComponent: View {
    @ObservedObject var viewModel: ProgressViewModel
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    FormattedDate(selectedDate: selectedDate)
                    DatePicker("Select Date", selection: $selectedDate,
                               in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                }
            }
            
            Button("Go to information view") {
                viewModel.navigateToSecondTab()
            }
            .padding()
            .navigationTitle("Calendar")
            
            ProfileCreationView()
            EditProfileView()
        }
    }
}

struct FormattedDate: View {
    var selectedDate: Date
    var omitTime: Bool = true
    var body: some View {
        Text(selectedDate.formatted(date: .abbreviated, time: omitTime ? .omitted : .standard))
            .font(.system(size: 28))
            .bold()
            .foregroundColor(Color.accentColor)
            .padding()
            .animation(.spring(), value: selectedDate)
            .frame(width: 500)
    }
}
