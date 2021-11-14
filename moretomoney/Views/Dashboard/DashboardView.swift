//
//  DashboardView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 10/30/21.
//

import SwiftUI

struct DashboardView: View {
    //Load Dashboard View Model information from the API
    @EnvironmentObject private var dashboardVM: DashboardViewModel
    
    //Categories to change current card display
    var categories = ["Income", "Asset", "Investment", "Expense", "Debt", "Settings", "Logout"]
    @State var selectedCategory = "Investment"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                //Net worth and profile picture section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back, Ryan")
                            .foregroundColor(Color.gray500)
                        Text(String(dashboardVM.netWorth.current ?? 0).currencyFormatting())
                            .font(Font.custom("Poppins-Bold", size: 38))
                            .foregroundColor(Color.blue500)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image("default-user-icon")
                    }
                }
                //Category navigation
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    self.changeCategory(category)
                                }) {
                                    categoryCard(name: category, selectedCategory: $selectedCategory)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 25)
                
                VStack {
                    if(selectedCategory == "Income") {
                        IncomeView()
                    }
                    if(selectedCategory == "Asset") {
                        AssetView()
                    }
                    if(selectedCategory == "Investment") {
                        InvestmentView()
                    }
                    if(selectedCategory == "Expense") {
                        ExpenseView()
                    }
                }
            
                Spacer()
            }
        }
        .font(Font.custom("Poppins-Regular", size: 16))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
        .background(Color.background)
    }
    
    func changeCategory(_ name: String) {
        self.selectedCategory = name
    }
}

/*
 Struct: Card view to display selectable categories
 */
struct categoryCard: View {
    var name = ""
    @Binding var selectedCategory : String
    
    var body: some View {
        VStack {
            Image(name == selectedCategory ? name + "-Selected" : name)
            Text(name)
                .font(Font.custom("Poppins-Regular", size: 11))
                .foregroundColor(name == selectedCategory ? Color.pink500 : Color.tealAccent)
        }
        .frame(width: 65, height: 80)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
