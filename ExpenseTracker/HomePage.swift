//
//  HomePage.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI

struct HomePage: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activeTab){
            Text("RecentsAday")
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            Text("Search")
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            Text("Chart")
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            Text("Settings")
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
    }
}

#Preview {
    HomePage()
}
