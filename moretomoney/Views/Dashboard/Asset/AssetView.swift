//
//  AssetView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/6/21.
//

import SwiftUI

struct AssetView: View {
    //Sample investments to be replaced by API call
    var sampleAssets: [Asset] = [
        Asset(name: "Emergency Fund", value: "$6,839"),
        Asset(name: "Camaro", value: "$9,850")
    ]
    
    var body: some View {
        //Category items
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampleAssets) { asset in
                        AssetCard(name: asset.name, value: asset.value).padding(.trailing, 10)
                    }
                }
            }
        }
    }
}

struct AssetCard: View {
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

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView()
            .previewLayout(.sizeThatFits)
    }
}
