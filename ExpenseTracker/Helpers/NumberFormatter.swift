//
//  NumberFormatter.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//

import SwiftUI

struct NumberTextField: View {
    @Binding var value: Double
    
    var body: some View {
        TextField("Amount", value: $value, formatter: NumberTextField.numberFormatter)
            .keyboardType(.decimalPad)
    }
    
    private static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}
