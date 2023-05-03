//
//  CardView.swift
//  Mini1
//
//  Created by Randy Julian on 02/05/23.
//

import SwiftUI
import ACarousel

struct Item: Identifiable {
    let id = UUID()
    let image: Image
}

let list = ["satu", "dua", "tiga", "empat", "lima"]

struct CardView: View {
    
    @State var spacing: CGFloat = 40
    @State var headspace: CGFloat = 30
    @State var sidesScaling: CGFloat = 0.9
    @State var isWrap: Bool = true
    @State var autoScroll: Bool = false
    @State var time: TimeInterval = 2
    @State var currIndex: Int = 0
    
    var body: some View {
//            ZStack{
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.white)
//                    .shadow(radius: 10)
//                    .frame(width: 278, height: 412)
                
//                Image(cornerRadius: 10) //nanti buat image
//                    .frame(width: 239, height: 158)
//                    .offset(y:-105)
                
        VStack {
            ACarousel(list,
                    id: \.self,
                    index: $currIndex,
                    spacing: spacing,
                    headspace: headspace,
                    sidesScaling: sidesScaling,
                    isWrap: isWrap,
                    autoScroll: autoScroll ? .active(time) : .inactive){ name in
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 278, height: 412)
                            .cornerRadius(10)
            }
        }
//
//                VStack{
//                    Text("STAGE 1")
//                        .padding(.top, 20)
//                    Text("LABLABLABLA")
//                }
//            }
        

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

