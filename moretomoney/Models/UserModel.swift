//
//  UserModel.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation
import Combine

//User Data Model
struct UserData: Codable {
    var user: User?
    var accessToken: String?

    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
    }
}

//User Model
struct User: Codable {
    var id: Int
    var name, email: String
    var emailVerifiedAt: String?
    var createdAt, updatedAt: String?
    var futureYears: Int
    var avatar: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case futureYears = "future_years"
        case avatar
    }
}

class UserModel {
    var email: String = ""
    var password: String = ""
    
    func login() {
        var user = UserData()
        var loginUserAttempt: AnyCancellable?

        //Prepare the body params
        let body: [String: String] = ["email": email, "password": password]
        let bodyJSON = try? JSONSerialization.data(withJSONObject: body)

        //Create the URL request
        let url = URL(string: "https://moretomoney.com/API/v1/user/login")!
        var request = URLRequest(url: url)
        //Set the method on the request
        request.httpMethod = "POST"
        //Insert the JSON into the request
        request.httpBody = bodyJSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        loginUserAttempt = Networking.call(url: request)
            .decode(type: UserData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: Networking.handleCompletion, receiveValue: { foundUser in
                user = foundUser
                loginUserAttempt?.cancel()
                
                if(user.accessToken != nil) {
                    //Store the access token in the user's keychain
                    let accessToken = user.accessToken!
                    let data = Data(accessToken.utf8)
                    KeychainHelper.standard.save(data, service: "access-token", account: "more-to-money")
                    print(accessToken)
                }
            })
    }
}
