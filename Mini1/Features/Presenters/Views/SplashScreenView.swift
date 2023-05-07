//
//  SplashScreenView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 05/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @State var size: Double = 0.1
    @State var opacity: Double = 0.5
    let paleBlue = Color(UIColor(named: "paleBlue")!)

    var body: some View {
        if isActive {
            DashboardView()
        }
        else {
            ZStack {
                Color("paleBlue").ignoresSafeArea()
                VStack {
                    Image("LogoBobori")
                        .resizable()
                        .frame(width: 393, height: 393)
                        .padding(.top, -100)
                    Text(" Chair method sleep training is a gentle and effective want to sleep train baby to sleep independently")
                        .font(Font.custom("Nunito ExtraLight", size: 21))
                        .frame(width: 288, height: 150)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 150)
                        .padding(.bottom, -100)
                }.padding(.top, 50)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)){
                        self.size = 0.8
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
