//
//  ShareCalculator.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/24/21.
//

import SwiftUI

struct ShareCalculator: View {
    //Share for calculator
    @State private var share = Share()
    
    var body: some View {
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

struct ShareCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ShareCalculator()
            .previewLayout(.sizeThatFits)
    }
}
