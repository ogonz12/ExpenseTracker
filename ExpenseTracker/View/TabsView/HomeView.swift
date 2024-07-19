//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedCategory: Category = .expense
    @State private var showBottomSheet = false
    @Namespace private var animation
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                        CardView(income: 2000, expense: 600)
                        
                        CustomSegmentedControl()
                            .padding(.bottom, 10)
                        
                        ForEach(TransactionStore().transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                            TransactionCardView(transaction: transaction)
                                .animation(.none, value: selectedCategory)
                        }
                    } header: {
                        HStack {
                            Text("Welcome!")
                                .font(.title.bold())
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    showBottomSheet.toggle()
                                }
                            }) {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: 45, height: 45)
                                    .background(.blue.gradient, in: .circle)
                                    .contentShape(.circle)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.gray.opacity(0.15))
            .overlay(
                BottomSheetView(show: $showBottomSheet) {
                    NewTransactionView(showSheet: $showBottomSheet)
                })

        }
        // VStack
    }// NavigationStack
    
    
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

struct BottomSheetView<Content: View>: View {
    @Binding var show: Bool
    let content: Content
    
    init(show: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._show = show
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    content
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
                .offset(y: show ? 0 : geometry.size.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 0 {
                                withAnimation {
                                    show = false
                                }
                            }
                        })
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    HomePage()
}
