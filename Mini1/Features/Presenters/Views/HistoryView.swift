//
//  HistoryView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import SwiftUI
import LottieUI

struct HistoryView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    @State var entry: SleepRoutine
    
    var body: some View {
        ZStack{
            Color("paleBlue").ignoresSafeArea()
            VStack {
                LottieView(state: LUStateData(type: .name("empat", .main), loopMode: .loop))
                    .scaleEffect(0.7)
                    .padding(.top, -250)
                
                FormattedDate(date: entry.date!)
                    .padding(.top, -150)
                
                Text("Sleeping Time")
                    .font(Font.custom("Comfortaa", size: 16))
                    .foregroundColor(.white)
                    .padding(.leading, -165)
                    .padding(.top, -320)
                
                
                    FormattedTime(time: entry.bedTime!).bold()
                        .frame(width: 350, height: 50)
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 1)
                        )
                        .padding(.top, -300)
                    
                
                Text("Chair Distance")
                    .font(Font.custom("Comfortaa", size: 16))
                    .foregroundColor(.white)
                    .padding(.leading, -165)
                    .padding(.top, -230)
        
                Text(entry.distance ?? "ga ada distance" )
                        .font(Font.custom("Nunito ExtraLight", size: 18))
                        .frame(width: 350, height: 50)
                        .foregroundColor(Color.white)
                        .bold()
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 1)
                        )
                        .padding(.top, -210)

                    
                    
                } .padding(.top, -4)
            }
        }
    }

