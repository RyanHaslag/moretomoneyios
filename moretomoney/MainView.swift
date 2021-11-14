//
//  MainView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 10/30/21.
//

import SwiftUI

struct MainView: View {
    @State private var accessToken: String
    
    init() {
        let data = KeychainHelper.standard.read(service: "access-token", account: "more-to-money") ?? Data.init()
        accessToken = String(data: data, encoding: .utf8) ?? ""
    }
    
    var body: some View {
        if(accessToken == "") {
            LoginView()
        } else {
            TabView {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "chart.bar")
                    }
                MortgageCalculatorView()
                    .tabItem {
                        Label("Mortgage Calculator", systemImage: "slider.horizontal.3")
                    }
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
            }
            .accentColor(Color.blue500)
        }
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Poppins-Bold", size: 16))
            .padding()
            .frame(width: 200, height: 40)
            .background(Color.blue500)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
