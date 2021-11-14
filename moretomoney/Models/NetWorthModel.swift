//
//  NetWorthModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import Foundation
import Combine

//Net Worth Struct
struct NetWorth: Codable {
    var current, assetTotal, investmentTotal, debtTotal: Int?

    enum CodingKeys: String, CodingKey {
        case current
        case assetTotal = "asset_total"
        case investmentTotal = "investment_total"
        case debtTotal = "debt_total"
    }
}

class NetWorthModel {
    //Publisher to connect investments from the API to any subscribers
    @Published var netWorth = NetWorth()
    
    init() {
        loadNetWorth()
    }
    
    //Query the API for all investments for user
    private func loadNetWorth() {
        var getNetWorthAttempt: AnyCancellable?

        //Create the URL request
        let url = URL(string: "https://moretomoney.com/API/v1/worth/breakdown")!
        var request = URLRequest(url: url)
        //Set the method on the request
        request.httpMethod = "GET"
        
        //Dynamically add the bearer token if present in keychain storage
        let data = KeychainHelper.standard.read(service: "access-token", account: "more-to-money") ?? Data.init()
        let accessToken = String(data: data, encoding: .utf8) ?? ""
        if(accessToken != "") {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        getNetWorthAttempt = Networking.call(url: request)
            .decode(type: NetWorth.self, decoder: JSONDecoder())
            .sink(receiveCompletion: Networking.handleCompletion, receiveValue: {[weak self] foundNetWorth in
                //Set the local investments publisher values to the returned investments
                self?.netWorth = foundNetWorth
                getNetWorthAttempt?.cancel()
            })
    }
}
