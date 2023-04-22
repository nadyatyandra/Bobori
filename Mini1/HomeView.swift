//
//  HomeView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CalendarView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Calendar", systemImage: "1.circle")
            }
            .tag(0)
            
            NavigationView {
                InformationView()
            }
            .tabItem {
                Label("Information", systemImage: "2.circle")
            }
            .tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
