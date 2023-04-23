//
//  CalendarView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI
import EventKit

struct FirstTabView: View { 
    @ObservedObject var viewModel: FirstTabViewModel
    
    var body: some View {
        VStack {
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
