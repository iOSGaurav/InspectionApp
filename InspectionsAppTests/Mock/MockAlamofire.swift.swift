//
//  MockAlamofire.swift.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 26/07/24.
//

@testable import Alamofire

// Protocol for making requests
protocol NetworkRequestProtocol {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding) -> DataRequest
}

// Alamofire wrapper
class AlamofireWrapper: NetworkRequestProtocol {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding) -> DataRequest {
        return AF.request(url, method: method, parameters: parameters, encoding: encoding)
    }
}

// Mock Alamofire wrapper
class MockAlamofireWrapper: NetworkRequestProtocol {
    var mockResponse: (Result<Any, AFError>)?
    
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding) -> DataRequest {
        let request = MockDataRequest()
        request.mockResponse = mockResponse
        return request
    }
}

// Mock DataRequest
class MockDataRequest: DataRequest {
    var mockResponse: (Result<Any, AFError>)?
    
    func responseDecodable(completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Self {
        if let mockResponse = mockResponse {
            completionHandler(AFDataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: mockResponse))
        }
        return self
    }
}
