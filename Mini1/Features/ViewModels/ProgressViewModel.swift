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
    
    //Moved into ViewModel
    @ObservedObject var entryViewModel = EntryViewModel()
    @Published var isFilled: Bool = false
    @Published var showSheet: Bool = false
    
    init(selectedTab: Binding<Int>) {
        _selectedTab = selectedTab
    }
    
    func navigateToSecondTab() {
        selectedTab = 1
    }
    
    func checkDailyProgress() {
        let date = Date()
        entryViewModel.selectedDateEntry.removeAll()
        
        guard let sleepRoutine = entryViewModel.getOneEntry(date: date)
        else {
            isFilled = false
            return
        }
        entryViewModel.selectedDateEntry.append(sleepRoutine)
        isFilled = true
    }
}
