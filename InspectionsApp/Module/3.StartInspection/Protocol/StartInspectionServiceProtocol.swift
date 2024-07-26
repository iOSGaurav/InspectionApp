//
//  StartInspectionServiceProtocol.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

protocol StartInspectionServiceProtocol {
    func fetchQuestions(completion: @escaping (Result<InspectionResponse, Error>) -> Void)
    func submitQuestion(_ inspection: Inspection ,completion: @escaping (Result<Bool, Error>) -> Void)
}
