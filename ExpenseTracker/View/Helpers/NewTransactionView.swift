//
//  NewTransactionView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//  Modified by Orlando Now Income and Expense reflect on the total balance

import SwiftUI
import SwiftData

struct NewTransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    @State var tint: TintColor = tints.randomElement()!
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                Text("New Transaction")
                    .font(.title.bold())
    
                Form {
                    Section(header: Text("Transaction Details")) {
                        TextField("Title", text: $title)
                        TextField("Remarks", text: $remarks)
                        TextField("0.0", value: $amount, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                        
                        Picker("Category", selection: $category) {
                            ForEach(Category.allCases, id: \.rawValue) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    }
                    
                    Button(action: addTransaction) {
                        Text("Add Transaction")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func addTransaction() {
            guard !title.isEmpty else {
                showAlert(message: "Title cannot be empty")
                return
            }
            
            guard !remarks.isEmpty else {
                showAlert(message: "Remarks cannot be empty")
                return
            }
            
            guard amount > 0 else {
                showAlert(message: "Amount must be greater than zero")
                return
            }
            
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
            context.insert(transaction)
            dismiss()
        }
        
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}


#Preview {
    HomeView()
}
