//
//  LoginView.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/8/21.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("Logo")
                    .padding(.top, 100)
                HStack {
                    Text("more")
                        .font(Font.custom("Poppins-Bold", size: 32))
                    Text("to")
                        .font(Font.custom("Poppins-medium", size: 32))
                        .padding(.leading, -8)
                    Text("money")
                        .font(Font.custom("Poppins-Bold", size: 32))
                        .padding(.leading, -8)
                }
                .foregroundColor(Color.blue500)
                .font(.largeTitle)
                VStack {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                        .padding(.vertical, 20)
                }
                .font(Font.custom("Poppins-Medium", size: 16))
                .padding(.horizontal, 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                
                Button("Login") {
                    login(email: email, password: password)
                }
                .buttonStyle(GrowingButton())
                Spacer()
                Image("login-waves")
            }
        }
        .background(Color.background)
        .edgesIgnoringSafeArea(.all)
    }
}

func login(email: String, password: String) {
    //Attempt to login the user with the provided credentials
    let user = UserModel()
    user.email = email
    user.password = password
    user.login()
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
