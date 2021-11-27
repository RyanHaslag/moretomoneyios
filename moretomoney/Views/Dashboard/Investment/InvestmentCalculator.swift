//
//  InvestmentCalculator.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/24/21.
//

import SwiftUI

struct InvestmentCalculator: View {
    //Future investment for calculator
    @State private var futureInvestment = FutureInvestment()
    
    var body: some View {
        //Future investment calculator
        VStack {
            HStack {
                Image("coins-icon")
                Text("Future Investment").font(Font.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color.blue500)
                Text("Calculator").font(Font.custom("Poppins-Bold", size: 18))
                    .foregroundColor(Color.blue500)
                Image("coins-icon")
            }
            .padding(.bottom, 10)
            VStack {
                TextField("Years of Investment", text: $futureInvestment.years)
                    .padding(.bottom, 10)
                TextField("Principal", text: $futureInvestment.years)
                    .padding(.bottom, 10)
                TextField("Monthly Contribution", text: $futureInvestment.years)
                    .padding(.bottom, 10)
                TextField("Expected Interest Rate", text: $futureInvestment.years)
                    .padding(.bottom, 10)
                Button("Calculate") {
                           print("todo: Calculate the future value of the investment")
                       }
                       .buttonStyle(GrowingButton())
                Text("\(futureInvestment.result)")
                    .font(Font.custom("Poppins-Bold", size: 38))
                    .foregroundColor(Color.blue500)
            }
            .padding(10)
            .keyboardType(.decimalPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct InvestmentCalculator_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCalculator()
            .previewLayout(.sizeThatFits)
    }
}
