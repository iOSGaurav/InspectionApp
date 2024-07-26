//
//  RegistrationService.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import Alamofire

class RegisterService: RegisterServiceProtocol {
    func register(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Constants.baseURL + "/api/register"
        let parameters: [String: String] = [
            "email": user.email,
            "password": user.password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                switch response.result {
                case .success(_):
                    // Assuming success if the response code is 200 and there are no errors
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
