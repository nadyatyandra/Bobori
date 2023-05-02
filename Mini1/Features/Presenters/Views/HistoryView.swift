//
//  HistoryView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    @State var entry: SleepRoutine
    @State var bedTime: Date = Date()
    @State var date: Date = Date()
    @State var distance = ""
    @State private var showing: Bool = false
    
    var body: some View {
        VStack {
            FormattedDate(date: entry.date!)
            FormattedTime(time: entry.bedTime!)
            Text(entry.distance ?? "ga ada distance" ).font(.title).padding()
        }
    }
}
