//
//  RegistrationService.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 24/07/24.
//

protocol RegisterServiceProtocol {
    func register(user: User, completion: @escaping (Result<Bool, Error>) -> Void) 
}
