//
//  AboutView.swift
//  ExpenseTrackerSettings
//
//  Created by Wesley John on 7/24/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About Us")
                .font(.largeTitle)
                .padding()

            Text("""
Welcome to the ExpenseTrackerApp, the ultimate tool for managing your finances. Our purpose is to ensure that individuals and their families are able to take control of their financial well-being. Whether you're trying to budget your money, build your worth, or track your purchases, the ExpenseTracker is here to help achieve these goals.

Created with SwiftUI, our app offers one of the best user experiences, making it simple to see where your money goes. Join us on this journey to help you make better financial choices, become financially literate, and maintain financial freedom!
""")
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
