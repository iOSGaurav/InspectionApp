//
//  StartInspectionService.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

import Alamofire
import Foundation

class StartInspectionService: StartInspectionServiceProtocol {
    
    func fetchQuestions(completion: @escaping (Result<InspectionResponse, Error>) -> Void) {
        let url = Constants.baseURL + "/api/inspections/46"
        AF.request(url)
            .validate()
            .responseDecodable(of: InspectionResponse.self) { response in
                switch response.result {
                case .success(let questionsResponse):
                    completion(.success(questionsResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func submitQuestion(_ inspection: Inspection ,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: for pretty printed JSON
        var requestString: Parameters?
        do {
            let jsonData = try encoder.encode(inspection)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                requestString = self.jsonStringToDictionary(jsonString: jsonString)
            }
        } catch {
            print("Error encoding struct to JSON: \(error)")
        }
        
        let url = Constants.baseURL + "/api/inspections/submit"
        AF.request(url, method: .post, parameters: requestString)
            .validate()
            .responseDecodable(of: InspectionResponse.self) { response in
                switch response.result {
                case .success(_):
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func jsonStringToDictionary(jsonString: String) -> [String: Any]? {
        // Convert JSON string to Data
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error: Cannot convert string to Data")
            return nil
        }
        
        // Deserialize JSON data into a Dictionary
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return dictionary
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
}
