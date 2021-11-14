//
//  InvestmentModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation
import Combine

struct Investment: Codable, Identifiable {
    var id, name, liquid, createdAt: String
    var updatedAt, userID, investmentTypeID, shortName: String
    var investmentValue: InvestmentValue
    var investmentType: InvestmentType

    enum CodingKeys: String, CodingKey {
        case id, name, liquid
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case investmentTypeID = "investment_type_id"
        case shortName = "short_name"
        case investmentValue = "investment_value"
        case investmentType = "investment_type"
    }
}

//Investment Type Struct
struct InvestmentType: Codable, Identifiable {
    var id: Int
    var publicName, shortName, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case publicName = "public_name"
        case shortName = "short_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//Investment Value Struct
struct InvestmentValue: Codable, Identifiable {
    var id: Int
    var contribution: Int?
    var frequencyPerYear, contributing: Int
    var expirationDate: String?
    var expectedInterestRate, currentShares, currentPrice: Double?
    var currentTotalValue: Int?
    var investmentID: Int
    var createdAt, updatedAt: String
    var calculatedValue: String {
        if let currentTotalValuePresent = currentTotalValue {
            return String(currentTotalValuePresent).currencyFormatting()
        }
        
        if let sharesPresent = currentShares, let pricePresent = currentPrice{
            return String(sharesPresent * pricePresent).currencyFormatting()
        } else {
            return "0"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, contribution
        case frequencyPerYear = "frequency_per_year"
        case contributing
        case expirationDate = "expiration_date"
        case expectedInterestRate = "expected_interest_rate"
        case currentShares = "current_shares"
        case currentPrice = "current_price"
        case currentTotalValue = "current_total_value"
        case investmentID = "investment_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

class InvestmentModel {
    //Publisher to connect investments from the API to any subscribers
    @Published var allInvestments: [Investment] = []
    
    init() {
        loadInvestments()
    }
    
    //Query the API for all investments for user
    private func loadInvestments() {
        var getInvestmentsAttempt: AnyCancellable?

        //Create the URL request
        let url = URL(string: "https://moretomoney.com/API/v1/investment/all")!
        var request = URLRequest(url: url)
        //Set the method on the request
        request.httpMethod = "GET"
        
        //Dynamically add the bearer token if present in keychain storage
        let data = KeychainHelper.standard.read(service: "access-token", account: "more-to-money") ?? Data.init()
        let accessToken = String(data: data, encoding: .utf8) ?? ""
        if(accessToken != "") {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        getInvestmentsAttempt = Networking.call(url: request)
            .decode(type: [Investment].self, decoder: JSONDecoder())
            .sink(receiveCompletion: Networking.handleCompletion, receiveValue: {[weak self] foundInvestments in
                //Set the local investments publisher values to the returned investments
                self?.allInvestments = foundInvestments
                getInvestmentsAttempt?.cancel()
            })
    }
}
