//
//  HomeView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            NavigationView {
                ProgressComponent(viewModel: ProgressViewModel(selectedTab: $viewModel.selectedTab))
            }
            .tabItem {
                Label("Calendar", systemImage: "1.circle")
            }
            .tag(0)
            
            NavigationView {
                InformationComponent()
            }
            .tabItem {
                Label("Information", systemImage: "2.circle")
            }
            .tag(1)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
