//
//  HomeView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI

struct DashboardView: View {
    @State var isOnboardingCompleted: Bool = false
    
    @StateObject var viewModel = DashboardViewModel()
    
    @State private var name: String = ""
    @State private var time: Date = Date()
    
    
    var body: some View {
        ZStack {
            if !isOnboardingCompleted {
                OnboardView(isOnboardingCompleted: $isOnboardingCompleted, name: $name, time: $time)
                    .zIndex(1)
                    .transition(.move(edge: .leading))
            }
                
            
            VStack {
                TabView(selection: $viewModel.selectedTab) {
                NavigationView {
                    ProgressComponent(viewModel: ProgressViewModel(selectedTab: $viewModel.selectedTab), name: $name, time: $time)
                }
                .tabItem {
                    Label("Progress", systemImage: "calendar")
                }
                .tag(0)
                
                NavigationView {
                    InformationComponent()
                }
                .tabItem {
                    Label("Information", systemImage: "info")
                }
                .tag(1)
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
