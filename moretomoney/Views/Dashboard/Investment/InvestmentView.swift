//
//  InvestmentView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/6/21.
//

import SwiftUI

struct InvestmentView: View {
    //Load investments from the API
    @EnvironmentObject private var investmentVM: InvestmentViewModel
    
    //Future investment for calculator
    @State private var futureInvestment = FutureInvestment()
    //Share for calculator
    @State private var share = Share()
    
    @State private var showingSheet = false
    
    var body: some View {
        //Category items
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(investmentVM.allInvestments) { investment in
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            InvestmentCard(name: investment.name, value: investment.investmentValue.calculatedValue, type: investment.investmentType.publicName).padding(.trailing, 10)
                        }
                        .sheet(isPresented: $showingSheet) {
                            SheetView()
                        }
                    }
                }
            }
        }
        //Future investment performance chart
        VStack {
            Text("Future Investment Chart Here")
                .foregroundColor(Color.gray500)
                .padding(10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300, alignment: .topLeading)
        .background(.white)
        .cornerRadius(10)
        .padding(.top, 15)
        //Projected net worth
        VStack {
            Text("Projected net worth in 5 years")
                .font(Font.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color.blue300)
            Text("$498,001")
                .font(Font.custom("Poppins-Bold", size: 38))
                .foregroundColor(Color.blue500)
        }
        .padding(.top, 10)
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
        
        //Share Calculator
        VStack {
            HStack {
                Text("Share").font(Font.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color.blue500)
                Text("Calculator").font(Font.custom("Poppins-Bold", size: 18))
                    .foregroundColor(Color.blue500)
            }
            .padding(.bottom, 10)
            VStack {
                TextField("Shares", text: $share.amount)
                    .padding(.bottom, 10)
                TextField("Price", text: $share.price)
                    .padding(.bottom, 10)
                Button("Calculate") {
                           print("todo: Calculate the future value of the investment")
                       }
                       .buttonStyle(GrowingButton())
                Text("\(share.result)")
                    .font(Font.custom("Poppins-Bold", size: 38))
                    .foregroundColor(Color.blue500)
            }
            .padding(10)
            .keyboardType(.decimalPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

/*
 Struct: Card view to show current values for investments
 */
struct InvestmentCard: View {
    var progressIndicatorBackground = Color(red: 0.89, green: 0.89, blue: 0.92)
    
    var name = ""
    var value = ""
    var type = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.blue300)
                    .padding(.top, 15)
                Spacer()
                ZStack {
                    Capsule()
                        .fill(Color.blue100)
                        .frame(width: 50, height: 25)
                    Text("Liquid")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Regular", size: 11))
                }
                .padding(.trailing, 10)
                .padding(.top, 10)
            }
            
            Text(value)
                .font(Font.custom("Poppins-Bold", size: 32))
                .foregroundColor(Color.blue500)
                .padding(.top, -10)
            Text(type)
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.blue300)
            Text("43% of total")
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

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    //dismiss() to dismiss the sheet view

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
    }
}

struct InvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentView()
            .previewLayout(.sizeThatFits)
            .environmentObject(InvestmentViewModel())
    }
}
