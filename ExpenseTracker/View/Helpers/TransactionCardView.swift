//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(transaction.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(Color.primary.secondary)
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                })
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            } //HStack
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

#Preview {
    HomeView()
}
