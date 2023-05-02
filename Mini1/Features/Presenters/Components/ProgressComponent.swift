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
