//
//  LoginService.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import Alamofire
import Foundation

class LoginService: LoginServiceProtocol {
    
    func login(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        // Define the URL
        let url = URL(string: Constants.baseURL + "/api/login")! // Replace with your actual URL
        
        // Set up the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the JSON body
        let parameters: [String: String] = [
            "email": user.email,
            "password": user.password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Check the response status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let errorMessage = "Invalid response with status code: \(statusCode)"
                print(errorMessage)
                completion(.failure(NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(())) // Successful response with no data
                return
            }
            // Handle empty response
            guard let data = data else {
                completion(.success(())) // Successful response with no data
                return
            }
            
            // Handle non-empty response
            do {
                // Attempt to parse the response JSON
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(json)")
                    // Add any specific success handling if needed
                    completion(.success(()))
                } else {
                    let errorMessage = "Unexpected response format"
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the data task
        task.resume()
    }
}
