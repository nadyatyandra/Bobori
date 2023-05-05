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
                    Image("placeholder")
                    Text("Bobori")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)){
                        self.size = 0.5
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
