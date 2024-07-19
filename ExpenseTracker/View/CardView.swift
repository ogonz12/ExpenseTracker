//
//  CardView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//

import SwiftUI

struct CardView: View {
    
    var income: Double
    var expense: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack {
                HStack {
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                    
                    Image(systemName: (income > expense ? "chart.line.uptrend.xyaxis.circle" : "chart.line.downtrend.xyaxis.circle"))
                        .foregroundColor(income > expense ? .green : .red)
                }
                .padding(10)
                
                HStack (spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let tint = category == .income ? Color.green : Color.red
                        
                        HStack (spacing: 10) {
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }
                            
                            VStack {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                                Text(currencyString(category == .income ? income : expense, allowedDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            if category == .income {
                                Spacer(minLength: 10)
                            }
                        }
                    }// ForEach
                }
            } // VStack
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }// ZStack
        
        
        
        
    }
    
}

#Preview {
    CardView(income: 2000, expense: 300)
}
