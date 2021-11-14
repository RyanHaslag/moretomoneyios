//
//  IncomeView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/6/21.
//

import SwiftUI

struct IncomeView: View {
    //Sample investments to be replaced by API call
    var sampleIncomes: [Income] = [
        Income(name: "REM", value: "$6,760", frequency: "Monthly")
    ]
    
    var body: some View {
        //Category items
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampleIncomes) { income in
                        IncomeCard(name: income.name, value: income.value, frequency: income.frequency).padding(.trailing, 10)
                    }
                }
            }
        }
    }
}

struct IncomeCard: View {
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
            Text("100% of total")
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.blue100)
                .padding(.bottom, -8)
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(progressIndicatorBackground)
                    .frame(width: 200, height: 5)
                Capsule()
                    .fill(Color.pink500)
                    .frame(width: 200, height: 5)
            }
            .padding(.top, 10)
        }
        .padding(.leading, 10)
        .frame(minWidth: 250, maxWidth: 250, minHeight: 150, maxHeight: 150, alignment: .topLeading)
        .background(.white)
        .cornerRadius(10)
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
            .previewLayout(.sizeThatFits)
    }
}
