//
//  MortgageCalculatorView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 10/9/21.
//

import SwiftUI

struct MortgageCalculatorView: View {
    @ObservedObject var mortgage = Mortgage()
    
    //Available mortgage length timeframes (fixed mortgage)
    var mortgageLengths = ["15 Year Fixed", "20 Year Fixed", "30 Year Fixed"]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                VStack(spacing: 20) {
                    //Title heading
                    HStack {
                        Image("coins-icon")
                        Text("Mortgage").font(Font.custom("Poppins-Regular", size: 20))
                        Text("Calculator").font(Font.custom("Poppins-Bold", size: 20)).padding(.leading, -2)
                        Image("coins-icon")
                    }
                    Text("$\(mortgage.totalMonthlyPayment, specifier: "%.2f")").font(Font.custom("Poppins-Bold", size: 40)).fontWeight(.bold)
                    Text("$\(mortgage.mortgagePayment, specifier: "%.2f") Mortgage Payment")

                    Picker("Mortgage length", selection: $mortgage.selectedMortgageLength) {
                        ForEach(mortgageLengths, id: \.self) { number in
                            Text(number)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    //Sliders to modify purchase price and interest rate
                    HStack {
                        VStack {
                            Text("$\(mortgage.purchasePrice, specifier: "%.0f")").font(Font.custom("Poppins-Bold", size: 22))
                            Text("Purchase Price")
                                .font(.subheadline)
                                .foregroundColor(Color.gray500)
                            Slider(value: $mortgage.purchasePrice, in: 100000...1000000, step: 5000).accentColor(Color.pink500)
                        }
                        VStack {
                            Text("\(mortgage.estimatedRate, specifier: "%.2f")%").font(Font.custom("Poppins-Bold", size: 22))
                            Text("Estimated Rate")
                                .font(.subheadline)
                                .foregroundColor(Color.gray500)
                            Slider(value: $mortgage.estimatedRate, in: 0...10)
                                .accentColor(Color.pink500)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    //Sliders to modify down payment and HOA fee
                    HStack {
                        VStack {
                            Text("$\(mortgage.downPayment, specifier: "%.0f")").font(Font.custom("Poppins-Bold", size: 22))
                            Text("Down Payment")
                                .font(.subheadline)
                                .foregroundColor(Color.gray500)
                            Slider(value: $mortgage.downPayment, in: 0...mortgage.purchasePrice, step: 1000)
                                .accentColor(Color.pink500)
                        }
                        VStack {
                            Text("$\(mortgage.hoaFee, specifier: "%.0f")").font(Font.custom("Poppins-Bold", size: 22))
                            Text("HOA Fee")
                                .font(.subheadline)
                                .foregroundColor(Color.gray500)
                            Slider(value: $mortgage.hoaFee, in: 0...500, step: 5)
                                .accentColor(Color.pink500)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    //Toggles for all costs associated with the mortgage
                    VStack(alignment: .leading) {
                        //Monthly Costs
                        Text("Monthly Costs").foregroundColor(Color.gray500)
                        HStack {
                            Toggle("Property Tax", isOn: $mortgage.propertyTaxSelected).customToggle()
                            Text("Property Tax")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.propertyTax)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("Homeowner's Insurance", isOn: $mortgage.homeOwnersInsuranceSelected).customToggle()
                            Text("Homeowner's Insurance")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.homeOwnersInsurance)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("Maintenance", isOn: $mortgage.maintenanceSelected).customToggle()
                            Text("Maintenance")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.maintenance)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("PMI", isOn: $mortgage.pmiSelected).customToggle()
                            Text("PMI")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.pmi)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        
                        //One-Time Costs
                        Text("One-Time Costs").padding(.top, 10).foregroundColor(.gray)
                        HStack {
                            Toggle("Broker's Fee", isOn: $mortgage.brokerFeeSelected).customToggle()
                            Text("Broker's Fee")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.brokerFee)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("Closing Costs", isOn: $mortgage.closingCostSelected).customToggle()
                            Text("Closing Costs")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.closingCost)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("Appraisal Fee", isOn: $mortgage.appraisalFeeSelected).customToggle()
                            Text("Appraisal Fee")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.appraisalFee)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                        HStack {
                            Toggle("Inspection Fee", isOn: $mortgage.inspectionFeeSelected).customToggle()
                            Text("Inspection Fee")
                                .foregroundColor(Color.gray500)
                            Spacer()
                            Text("$\(mortgage.inspectionFee)")
                                .font(Font.custom("Poppins-Bold", size: 16))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    Spacer()
                }
            }
        }
        .font(.custom("Poppins-Regular", size: 16))
        .foregroundColor(Color.blue500)
        .padding(20)
        .background(Color.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageCalculatorView()
    }
}
