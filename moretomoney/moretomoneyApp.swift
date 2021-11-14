//
//  moretomoneyApp.swift
//  moretomoney
//
//  Created by Ryan Haslag on 10/9/21.
//

import SwiftUI

@main
struct moretomoneyApp: App {
    let persistenceController = PersistenceController.shared
    
    //Add all view models used throughout the application
    @StateObject private var dashboardVM = DashboardViewModel()
    @StateObject private var investmentVM = InvestmentViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(investmentVM)
                .environmentObject(dashboardVM)
        }
    }
}
