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
    
    @State var showProfile: Bool = false
    
    @Binding var name: String
    @Binding var time: Date
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CalendarView()
                    
                    Button("Go to information view") {
                        viewModel.navigateToSecondTab()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Progress")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    showProfile = true
                } label: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 40))
                }
            }
        }
        .sheet(isPresented: $showProfile) {
            EditProfileView(showProfile: $showProfile, name: $name, time: $time)
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
