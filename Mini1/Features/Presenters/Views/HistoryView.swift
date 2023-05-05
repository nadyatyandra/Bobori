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
                Image("placeholder")
                    .resizable()
                    .frame(width: 192, height: 160)
                    .padding(.top, -80)
                FormattedDate(date: entry.date!)
                    
                
                Text("Sleeping Time")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.leading, -165)
//                    .padding(.leading, 10)
                    .padding(.top, 60)
                
                
                    FormattedTime(time: entry.bedTime!).bold()
                        .frame(width: 350, height: 50)
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 1)
                        )
                    
                
                Text("Chair Distance")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.leading, -165)
                    .padding(.top, 22)
        
                Text(entry.distance ?? "ga ada distance" )
                        .font(.system(size: 18))
                        .frame(width: 350, height: 50)
                        .foregroundColor(Color.white)
                        .bold()
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 1)
                        )

                    
                    
                } .padding(.top, -4)
            }
        }
    }

