//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//  Modified by Orlando Now Income and Expense reflect on the total balance

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var selectedCategory: Category = .expense
    @Namespace private var animation
    
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                        CardView(income: totalIncome(), expense: totalExpense())
                        
                        CustomSegmentedControl()
                            .padding(.bottom, 10)
                        
                        ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                            TransactionCardView(transaction: transaction)
                        }
                        
                    } header: {
                        HStack {
                            Text("Welcome!")
                                .font(.title.bold())
                            Spacer()
                            
                            NavigationLink {
                                NewTransactionView()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: 45, height: 45)
                                    .background(appTint.gradient, in: .circle)
                                    .contentShape(.circle)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.gray.opacity(0.15))

        }
        // VStack
    }// NavigationStack
    
    private func totalIncome() -> Double {
        transactions.filter { $0.category == Category.income.rawValue }.reduce(0) { $0 + $1.amount }
    }
    
    private func totalExpense() -> Double {
        transactions.filter { $0.category == Category.expense.rawValue }.reduce(0) { $0 + $1.amount }
    }
    
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
}
#Preview {
    HomePage()
}
