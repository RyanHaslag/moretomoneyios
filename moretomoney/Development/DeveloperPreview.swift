//
//  DevModels.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let investment = Investment(
        id: "1",
        name: "Sample Investments",
        liquid: "1",
        createdAt: "2022-01-01 12:00:00",
        updatedAt: "2022-01-01 12:00:00",
        userID: "1",
        investmentTypeID: "1",
        shortName: "SI",
        investmentValue: InvestmentValue(
            id: 1,
            contribution: 100,
            frequencyPerYear: 12,
            contributing: 1,
            expirationDate: nil,
            expectedInterestRate: 0.08,
            currentShares: nil,
            currentPrice: nil,
            currentTotalValue: 10000,
            investmentID: 1,
            createdAt: "2022-01-01 12:00:00",
            updatedAt: "2022-01-01 12:00:00"),
        investmentType: InvestmentType(
            id: 1,
            publicName: "Mutual Fund",
            shortName: "mutual_fund",
            createdAt: "2022-01-01 12:00:00",
            updatedAt: "2022-01-01 12:00:00")
        )
}
