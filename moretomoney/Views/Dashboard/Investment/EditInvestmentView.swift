//
//  EditInvestmentView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import SwiftUI

struct EditInvestmentView: View {
    @Binding var selectedInvestment: Investment?
    @State private var currentShares = "100"
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text(selectedInvestment?.name ?? "Sample Investment")
                .padding(.top, 10)
                .foregroundColor(Color.blue500)
                .font(Font.custom("Poppins-Bold", size: 24))
            TextField("Current Shares", text: $currentShares)
                .padding(.bottom, 10)
            Button("Press to dismiss") {
                dismiss()
            }
            .padding()
            Spacer()
        }
        .font(Font.custom("Poppins-Regular", size: 16))
        .padding(.all, 10)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct EditInvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        EditInvestmentView(selectedInvestment: .constant(nil))
    }
}
