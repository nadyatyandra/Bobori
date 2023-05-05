//
//  HomeView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI

struct DashboardView: View {
    // Check if onboarding is completed
    @State var isOnboardingCompleted: Bool = false
    
    @StateObject var viewModel = DashboardViewModel()
    
    @StateObject var entryViewModel = EntryViewModel()
    
    // Data for reminder
    @State private var name: String = ""
    @State private var time: Date = Date()
    
    // Music Variables
    @State var showMusic: Bool = false
    @State var playMusic: Bool = false
    @ObservedObject var musicPlayerViewModel = MusicPlayerViewModel()
    
    var body: some View {
        ZStack {
            Color("paleBlue").ignoresSafeArea()
            if !isOnboardingCompleted {
                OnboardView(isOnboardingCompleted: $isOnboardingCompleted, name: $name, time: $time)
                    .zIndex(1)
                    .transition(.move(edge: .leading))
            } else {
                VStack {
                    TabView(selection: $viewModel.selectedTab) {
                    NavigationView {
                        ProgressComponent(viewModel: ProgressViewModel(selectedTab: $viewModel.selectedTab), entryViewModel: entryViewModel, showMusic: $showMusic, playMusic: $playMusic, musicPlayerViewModel: musicPlayerViewModel, name: $name, time: $time)
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
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
