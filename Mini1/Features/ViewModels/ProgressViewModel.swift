//
//  CalendarViewModel.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import Foundation
import SwiftUI

class ProgressViewModel: ObservableObject {
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
        _selectedTab = selectedTab
    }
    
    func navigateToSecondTab() {
        selectedTab = 1
    }
}
