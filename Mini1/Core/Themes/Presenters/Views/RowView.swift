//
//  RowView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var entry: SleepRoutine
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.white).frame(width: 361, height: 100).cornerRadius(10).shadow(color: .gray, radius: 4)
            VStack(alignment: .leading) {
                HStack {
                    FormattedDate(date: entry.date!)
                    FormattedTime(time: entry.bedTime!)
                    Text(entry.distance ?? "ga ada distance" ).font(.footnote).padding()
                }
            }
        }
    }
}
