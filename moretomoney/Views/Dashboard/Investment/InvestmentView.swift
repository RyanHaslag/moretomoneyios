//
//  InvestmentView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/6/21.
//

import SwiftUI

struct InvestmentView: View {
    @EnvironmentObject private var investmentVM: InvestmentViewModel
    
    //Selected investment id for edit
    @StateObject private var sheetDetail = OptionalInvestmentWrapper()
    
    var body: some View {
        //Category items
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(investmentVM.allInvestments) { investment in
                        Button(action: {
                            self.sheetDetail.wrappedValue = investment
                        }) {
                            InvestmentCard(name: investment.name, value: investment.investmentValue.calculatedValue, type: investment.investmentType.publicName).padding(.trailing, 10)
                        }
                    }
                }
                .sheet(item: $sheetDetail.wrappedValue, onDismiss: didDismiss) { investment in
                    EditInvestmentSheet(investment: investment)
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("Investment Name: \(investment.name)")
//                        TextField("$0.00", value: investment.investmentValue.currentTotalValue, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//        //                        TextField("Current Total Value", text: $currentTotalValue)
//        //                            .padding(.bottom, 10)
//        //                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
                }
            }
        }

        .onAppear {
            investmentVM.reloadInvestments()
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
    }
        
    func didDismiss() {
          // Handle the dismissing action.
      }
}

//struct InvestmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        InvestmentView()
//            .previewLayout(.sizeThatFits)
//            .environmentObject(InvestmentViewModel())
//    }
//}

class OptionalInvestmentWrapper: ObservableObject {
    @Published var wrappedValue: Investment?
    
    init(wrappedValue: Investment? = nil) {
        self.wrappedValue = wrappedValue
    }
}

struct EditInvestmentSheet: View {
    var investment: Investment
    
    var body: some View {
        let currentTotalValueProxy = Binding(
            get: {
                investment.investmentValue.currentTotalValue
            }, set: { value in
                investment.investmentValue.currentTotalValue = value
            })
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Investment Name: \(investment.name)")
            TextField("$0.00", value: currentTotalValueProxy, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .padding(.bottom, 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
