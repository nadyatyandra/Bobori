
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

let list = ["Stage1", "Stage2", "Stage3", "Stage4", "Stage5"]

struct InformationComponent : View {
    
    @State var spacing: CGFloat = 40
    @State var headspace: CGFloat = 30
    @State var sidesScaling: CGFloat = 0.9
    @State var isWrap: Bool = true
    @State var autoScroll: Bool = false
    @State var time: TimeInterval = 2
    @State var currIndex: Int = 0
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Stages")
                            .font(.system(size: 16))
                            .padding(.leading, -52)
                            .foregroundColor(Color.gray)
                        Text("Chair Method Sleep Training")
                            .font(.system(size: 21))
                            .padding(.leading, 150)
                            .foregroundColor(Color("paleBlue"))
                    } .padding(.leading, -215)
                        .padding(.top, 10)
//                        .padding(.top, 5)
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .frame(width: 54, height: 54)
//                        .padding(.leading, 130)
//                        .padding(.top, 25)
//                        .foregroundColor(Color("paleBlue"))
//                    Button() {
//                        showProfile = true
//                    } label: {
//                        Image("placeholder")
//                            .resizable()
//                            .frame(width: 54, height: 54)
//                            .padding(.trailing, 10)
//
//                    }

                }
                Text("General Instruction")
                    .font(.system(size: 18))
                    .padding(.top)
                    .padding(.leading, -160)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                        .frame(width: 324, height: 611)
                                    
                    VStack {
                        Image("satu")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 278, height: 180)
                        .cornerRadius(10)
                                        
                    Text("Chair method sleep training is a gentle sleep training technique that gradually teaches your baby to sleep on their own. \n\nChair method sleep training allows you to stay in the room as your baby learns to self-soothe and settle to sleep independently. \n\nIf you’re patient and consistent, the Chair method of sleep training can help your baby start to sleep on their own in as little as two weeks.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                    }
                    .frame(width: 324, height: 611)
                            
                VStack{
                    Image("CardChairMethod")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 278, height: 180)
                    .cornerRadius(10)
                    .padding(.top, -90)
                                
                Text("Chair method sleep training is a gentle sleep training technique that gradually teaches your baby to sleep on their own. \n\nChair method sleep training allows you to stay in the room as your baby learns to self-soothe and settle to sleep independently. \n\nIf you’re patient and consistent, the Chair method of sleep training can help your baby start to sleep on their own in as little as two weeks.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    }.frame(width: 324, height: 611)
            }
                
                ACarousel(
                    list,
                    id: \.self,
                    index: $currIndex,
                    spacing: spacing,
                    headspace: headspace,
                    sidesScaling: sidesScaling,
                    isWrap: isWrap,
                    autoScroll: autoScroll ? .active(time) : .inactive
                ){ name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 278, height: 412)
                        .cornerRadius(10)
                        .padding(.top, -30)
                        .shadow(radius: 3)
                }
                .frame(width: 390, height: 500)
            }
            .frame(maxHeight: .infinity)
        }
    }
}
