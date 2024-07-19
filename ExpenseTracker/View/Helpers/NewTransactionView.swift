//
//  NewTransactionView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//

import SwiftUI

struct NewTransactionView: View {
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = 0.0
    @State private var dateAdded: Date = Date.now
    @State private var category: Category = .expense
    @State private var tintColor: TintColor = tints.randomElement()!
    
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Spacer()
                Text("New Transaction")
                    .font(.title.bold())
    
                Form {
                    Section(header: Text("Transaction Details")) {
                        TextField("Title", text: $title)
                        TextField("Remarks", text: $remarks)
                        NumberTextField(value: $amount)
                        
                        Picker("Category", selection: $category) {
                            ForEach(Category.allCases, id: \.rawValue) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    }
                    
                    Button(action: {
                                        let newTransaction = Transaction(
                                            title: title,
                                            remarks: remarks,
                                            amount: amount,
                                            dateAdded: dateAdded,
                                            category: category,
                                            tintColor: tintColor
                                        )
                        TransactionStore().transactions.append(newTransaction)
                        showSheet = false
                        
                                    }) {
                                        Text("Add Transaction")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                }
            }
        }
    }
}



#Preview {
    HomeView()
}
