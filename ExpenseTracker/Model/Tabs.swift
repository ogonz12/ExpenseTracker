//
//  Model.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/8/24.
//

import SwiftUI

enum Tab: String {
    case home = "Home"
    case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .home:
            Image(systemName: "house")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    }
}


#Preview {
    HomePage()
}

