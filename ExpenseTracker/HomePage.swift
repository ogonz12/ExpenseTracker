//
//  HomePage.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI

struct HomePage: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @State private var activeTab: Tab = .home
    
    var body: some View {
        TabView(selection: $activeTab){
            HomeView()
                .tag(Tab.home)
                .tabItem { Tab.home.tabContent }
            ChartsView()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            SettingsView()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
    }
}

#Preview {
    HomePage()
}
