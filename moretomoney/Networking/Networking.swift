//
//  Networking.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation
import Combine

class Networking {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URLRequest)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL. \(url)"
            case .unknown: return "Unknown error occured"
            }
        }
    }
    
    static func call(url: URLRequest) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URLRequest) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingError.badURLResponse(url: url)
              }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break;
        case .failure(let error):
            //print(error.localizedDescription)
            print(String(describing: error))
        }
    }
}
