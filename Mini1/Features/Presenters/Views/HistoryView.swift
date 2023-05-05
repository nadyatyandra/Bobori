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
        ZStack{
            Color("paleBlue").ignoresSafeArea()
            VStack {
                
                FormattedDate(date: entry.date!)
                
                
                Text("Sleeping Time")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                        .frame(width: 350, height: 50)
                    FormattedTime(time: entry.bedTime!)
                    
                }
                Text("Chair Distance")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                        .frame(width: 350, height: 50)
                    Text(entry.distance ?? "ga ada distance" ).font(.title).padding()
                        .font(.system(size: 18))
                        .foregroundColor(Color("paleBlue"))
                    
                }
                
                
            }
        }
    }
}
