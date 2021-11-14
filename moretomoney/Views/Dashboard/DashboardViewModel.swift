//
//  DashboardViewModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 10/30/21.
//

import Foundation
import Combine

struct Income: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
    var frequency: String
}

struct Asset: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
}

struct SampleInvestment: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
    var type: String
    var contribution: Double = 0.00
    var investmentType: String = "Mutual Fund"
    var contributing: Bool = false
    var liquid: Bool = true
    var shares: Double = 0.00
    var sharePrice: Double = 0.00
    var overrideTotalValue: Double = 0.00
    var interestRate: Double = 0.00
}

struct Expense: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
}

struct FutureInvestment {
    var years = ""
    var principal = ""
    var monthly = ""
    var interest = ""
    var result = "$0"
}

struct Share {
    var amount = ""
    var price = ""
    var result = "$0"
}

class DashboardViewModel: ObservableObject {
    @Published var netWorth = NetWorth()
    
    private let dataService = NetWorthModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$netWorth
            .sink { [weak self] (returnedNetWorth) in
                self?.netWorth = returnedNetWorth
            }
            .store(in: &cancellables)
    }
}
