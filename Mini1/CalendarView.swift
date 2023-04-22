//
//  CalendarView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI

struct CalendarView: View { 
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Button("Go to information view") {
                selectedTab = 1
            }
            .padding()
            .navigationTitle("Calendar")
            }
        }
}

