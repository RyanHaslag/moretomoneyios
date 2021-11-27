//
//  InvestmentCard.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import SwiftUI

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

struct InvestmentCard_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCard()
    }
}
