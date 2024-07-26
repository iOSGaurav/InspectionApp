//
//  LoginServiceProtocol.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

protocol LoginServiceProtocol {
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}
