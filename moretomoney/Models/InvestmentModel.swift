//
//  InvestmentModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation
import Combine

class Investment: Codable, Identifiable, ObservableObject {
    var id, name, liquid: String
    var createdAt, updatedAt, shortName: String?
    var userID, investmentTypeID: String
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

    init(id: String, name: String, liquid: String, createdAt: String, updatedAt: String, userID: String, investmentTypeID: String, shortName: String, investmentValue: InvestmentValue, investmentType: InvestmentType) {
        self.id = id
        self.name = name
        self.liquid = liquid
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userID = userID
        self.investmentTypeID = investmentTypeID
        self.shortName = shortName
        self.investmentValue = investmentValue
        self.investmentType = investmentType
    }
}

//Investment Type
class InvestmentType: Codable {
    var id: Int
    var publicName, shortName, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case publicName = "public_name"
        case shortName = "short_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, publicName: String, shortName: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.publicName = publicName
        self.shortName = shortName
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

//Investment Value
class InvestmentValue: Codable {
    var id: Int
    var contribution: Int?
    var frequencyPerYear, contributing: Int
    var expirationDate, createdAt, updatedAt: String?
    var expectedInterestRate, currentShares, currentPrice: Double?
    var currentTotalValue: Int?
    var investmentID: Int
    
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

    init(id: Int, contribution: Int?, frequencyPerYear: Int, contributing: Int, expirationDate: String?, expectedInterestRate: Double?, currentShares: Double?, currentPrice: Double?, currentTotalValue: Int?, investmentID: Int, createdAt: String, updatedAt: String) {
        self.id = id
        self.contribution = contribution
        self.frequencyPerYear = frequencyPerYear
        self.contributing = contributing
        self.expirationDate = expirationDate
        self.expectedInterestRate = expectedInterestRate
        self.currentShares = currentShares
        self.currentPrice = currentPrice
        self.currentTotalValue = currentTotalValue
        self.investmentID = investmentID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

class InvestmentModel {
    //Publisher to connect investments from the API to any subscribers
    @Published var allInvestments: [Investment] = []
    
    init() {
        loadInvestments()
    }
    
    //Query the API for all investments for user
    func loadInvestments() {
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
