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
