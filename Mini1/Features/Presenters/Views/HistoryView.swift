//
//  HistoryView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    @State var entry: SleepRoutine
    
    var body: some View {
        VStack {
            FormattedDate(date: entry.date!)
            FormattedTime(time: entry.bedTime!)
            Text(entry.distance ?? "ga ada distance" ).font(.title).padding()
        }
    }
}
