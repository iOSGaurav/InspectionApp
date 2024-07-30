//
//  LoginModel.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

struct User {
    let email: String
    let password: String
}
struct UserError: Decodable {
    let error: String
}
