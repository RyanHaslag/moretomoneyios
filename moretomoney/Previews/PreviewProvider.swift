//
//  PreviewProvider.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var development: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let investmentVM = InvestmentViewModel()
    
    let sampleInvestments: [Investment] = [Investment(
        id: "1",
        name: "Sample Investment",
        liquid: "true",
        createdAt: "2021-01-01",
        updatedAt: "2021-01-01",
        userID: "1",
        investmentTypeID: "1",
        shortName: "sample_investment",
        investmentValue:
            InvestmentValue(
                id: 1,
                contribution: 500,
                frequencyPerYear: 12,
                contributing: 1,
                expirationDate: "2021-01-01",
                expectedInterestRate: 8.00,
                currentShares: nil,
                currentPrice: nil,
                currentTotalValue: 1000,
                investmentID: 1,
                createdAt: "2021-01-01",
                updatedAt: "2021-01-01"),
        investmentType:
            InvestmentType(
                id: 1,
                publicName: "Mutual Fund",
                shortName: "mutual_fund",
                createdAt: "2021-01-01",
                updatedAt: "2021-01-01")
    )]
    
    
}
