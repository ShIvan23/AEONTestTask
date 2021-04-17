//
//  APIManager.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

protocol APIProtocol {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func fetch<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void)
}

extension APIProtocol {
    
    func fetch<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        let dataTask = JSONTask(request: request) { (data, _, error) in
            
            DispatchQueue.main.async {
                guard let data = data else {
                    if let error = error {
                        completionHandler(.failure(error))
                    }
                    return
                }
                
                if let value = decodeJSON(type: T.self, from: data) {
                    completionHandler(.success(value))
                } else {
                    let error = NSError()
                    completionHandler(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    private func JSONTask(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let error = error
                completionHandler(nil, nil, error)
                return
            }
            
            switch HTTPResponse.statusCode {
            case 200:
                print("statusCode = \(HTTPResponse.statusCode)")
                completionHandler(data, HTTPResponse, nil)
            default:
                print("statusCode = \(HTTPResponse.statusCode)")
                completionHandler(nil, HTTPResponse, error)
            }
        }
        return dataTask
    }
    
    private func decodeJSON<T: Codable>(type: T.Type, from: Data?) ->T? {
        
        let decoder = JSONDecoder()
        
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError.localizedDescription)
            return nil
        }
    }
}
