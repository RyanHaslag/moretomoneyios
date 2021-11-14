//
//  InvestmentViewModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation
import Combine

class InvestmentViewModel: ObservableObject {
    @Published var allInvestments: [Investment] = []
    
    private let dataService = InvestmentModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allInvestments
            .sink { [weak self] (returnedInvestments) in
                self?.allInvestments = returnedInvestments
            }
            .store(in: &cancellables)
    }
}
