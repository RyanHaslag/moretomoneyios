//
//  ExpenseView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/6/21.
//

import SwiftUI

struct ExpenseView: View {
    //Sample investments to be replaced by API call
    var sampleExpenses: [Expense] = [
        Expense(name: "Rent", value: "$914"),
        Expense(name: "Garage", value: "$125"),
        Expense(name: "Utilities", value: "$200"),
        Expense(name: "Food", value: "$450"),
        Expense(name: "Gas", value: "$30"),
        Expense(name: "TV", value: "$90"),
        Expense(name: "Spotify", value: "$10"),
        Expense(name: "Amazon Prime", value: "$10"),
        Expense(name: "Amazon AWS", value: "$60"),
        Expense(name: "Sirius", value: "$10"),
        Expense(name: "Misc", value: "$150"),
    ]
    
    var body: some View {
        //Category items
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampleExpenses) { expense in
                        ExpenseCard(name: expense.name, value: expense.value).padding(.trailing, 10)
                    }
                }
            }
        }
    }
}

struct ExpenseCard: View {
    var progressIndicatorBackground = Color(red: 0.89, green: 0.89, blue: 0.92)
    
    var name = ""
    var value = ""
    var frequency = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.blue300)
                    .padding(.top, 15)
                Spacer()
            }
            
            Text(value)
                .font(Font.custom("Poppins-Bold", size: 32))
                .foregroundColor(Color.blue500)
                .padding(.top, -10)
            Text(frequency)
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.blue300)
            Text("50% of total")
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.blue100)
                .padding(.bottom, -8)
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(progressIndicatorBackground)
                    .frame(width: 200, height: 5)
                Capsule()
                    .fill(Color.pink500)
                    .frame(width: 100, height: 5)
            }
            .padding(.top, 10)
        }
        .padding(.leading, 10)
        .frame(minWidth: 250, maxWidth: 250, minHeight: 150, maxHeight: 150, alignment: .topLeading)
        .background(.white)
        .cornerRadius(10)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
            .previewLayout(.sizeThatFits)
    }
}
