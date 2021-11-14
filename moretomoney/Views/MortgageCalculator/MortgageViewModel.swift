//
//  MortgageViewModel.swift
//  moretomoneyUI
//
//  Created by Ryan Haslag on 10/28/21.
//

import Foundation

class Mortgage: ObservableObject {
    private var defaultPercentage = 0.0008333
    
    @Published var totalMonthlyPayment: Double = 2135.16
    @Published var mortgagePayment: Double = 1381.16
    
    //Mortgage Principal Values
    @Published var purchasePrice: Double = 250000 {
        didSet {
            //Update monthly and one-time costs
            updateAssociatedCosts()
            calculateMortgagePayment()
        }
    }
    @Published var selectedMortgageLength = "15 Year Fixed" {
        didSet {
            //Update monthly and one-time costs
            updateAssociatedCosts()
            calculateMortgagePayment()
        }
    }
    @Published var downPayment: Double = 50000 {
        didSet {
            //Update monthly and one-time costs
            updateAssociatedCosts()
            calculateMortgagePayment()
        }
    }
    @Published var estimatedRate: Double = 3.00 {
        didSet {
            //Update monthly and one-time costs
            updateAssociatedCosts()
            calculateMortgagePayment()
        }
    }
    @Published var hoaFee: Double = 0 {
        didSet {
            //Update monthly and one-time costs
            updateAssociatedCosts()
            calculateMortgagePayment()
        }
    }
    
    //Monthly Costs
    @Published var propertyTax = 208
    @Published var propertyTaxSelected = true {
        didSet {
            propertyTax = calculatePercentageCost(shouldApply: propertyTaxSelected, percentage: defaultPercentage)
            calculateMortgagePayment()
        }
    }
    @Published var homeOwnersInsurance = 130
    @Published var homeOwnersInsuranceSelected = true {
        didSet {
            homeOwnersInsurance = homeOwnersInsuranceSelected ? 130 : 0
            calculateMortgagePayment()
        }
    }
    @Published var maintenance = 208
    @Published var maintenanceSelected = true {
        didSet {
            maintenance = calculatePercentageCost(shouldApply: maintenanceSelected, percentage: defaultPercentage)
            calculateMortgagePayment()
        }
    }
    @Published var pmi = 0
    @Published var pmiSelected = true {
        didSet {
            pmi = pmiRequired() ? calculatePercentageCost(shouldApply: pmiSelected, percentage: defaultPercentage) : 0
            calculateMortgagePayment()
        }
    }
    
    //One-Time Costs
    @Published var brokerFee = 7500
    @Published var brokerFeeSelected = true {
        didSet {
            brokerFee = calculatePercentageCost(shouldApply: brokerFeeSelected, percentage: 0.03)
        }
    }
    @Published var closingCost = 8750
    @Published var closingCostSelected = true {
        didSet {
            closingCost = calculatePercentageCost(shouldApply: closingCostSelected, percentage: 0.035)
        }
    }
    @Published var appraisalFee = 400
    @Published var appraisalFeeSelected = true {
        didSet {
            appraisalFee = appraisalFeeSelected ? 400 : 0
        }
    }
    @Published var inspectionFee = 400
    @Published var inspectionFeeSelected = true {
        didSet {
            inspectionFee = inspectionFeeSelected ? 400 : 0
        }
    }
    
    func pmiRequired() -> Bool {
        return (downPayment / purchasePrice) < 0.20
    }
    
    //Calculate the default percentage amount for monthly and one-time costs
    func calculatePercentageCost(shouldApply: Bool, percentage: Double) -> Int {
        return shouldApply ? Int(self.purchasePrice * percentage) : 0
    }
    
    func updateAssociatedCosts() {
        propertyTax = calculatePercentageCost(shouldApply: propertyTaxSelected, percentage: defaultPercentage)
        homeOwnersInsurance = homeOwnersInsuranceSelected ? 130 : 0
        maintenance = calculatePercentageCost(shouldApply: maintenanceSelected, percentage: defaultPercentage)
        pmi = pmiRequired() ? calculatePercentageCost(shouldApply: pmiSelected, percentage: defaultPercentage) : 0
        brokerFee = calculatePercentageCost(shouldApply: brokerFeeSelected, percentage: 0.03)
        closingCost = calculatePercentageCost(shouldApply: closingCostSelected, percentage: 0.035)
        appraisalFee = appraisalFeeSelected ? 400 : 0
        inspectionFee = inspectionFeeSelected ? 400 : 0
    }
    
    /* Calculate the amortization schedule for current settings
       Formula: M = P[r(1+r)^n/((1+r)^n)-1)]
     */
    func calculateMortgagePayment() {
        let totalLoanAmount = purchasePrice - downPayment
        let convertedRate = estimatedRate / 100 / 12
        let months = monthsInMortgage()
    
        mortgagePayment = totalLoanAmount * ( (convertedRate * pow(1 + convertedRate, months)) / (pow(1 + convertedRate, months) - 1) )
        
        //Add the monthly costs to determine total monthly payment
        totalMonthlyPayment = mortgagePayment + Double(propertyTax) + Double(homeOwnersInsurance) + Double(maintenance) + Double(pmi) + Double(hoaFee)
    }
    
    func monthsInMortgage() -> Double {
        var totalMonths: Double = 0
        
        switch(selectedMortgageLength) {
        case "15 Year Fixed":
            totalMonths = 180
            break
        case "20 Year Fixed":
            totalMonths = 240
            break
        default:
            totalMonths = 360
            break
        }
        
        return totalMonths
    }
}
