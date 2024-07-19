//
//  Transaction.swift
//  Expense Tracker
//
//  Created by Balaji Venkatesh on 11/12/23.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    // Extracting Color Value from tintColor String
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
}


