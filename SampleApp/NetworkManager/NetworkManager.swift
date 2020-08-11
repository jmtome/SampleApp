//
//  NetworkManager.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Network error enum
enum NetworkError: Error {
    case clientNetworkError
    case serverNetworkError
    case nilDataError
    case dataDecodingError
    case badURL
}
class NetworkManager {
 
    //TODO: - This network request takes a generic codable argument T, it will be useful to parse json data but for other kinds of data that dont conform to codable this wont work , ideally other arrangements would have to be done
    func fetchRequest<T: Codable>(_ urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                completion(.failure(.clientNetworkError))
                return
            }

            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverNetworkError))
                return
            }

            guard let data = data else {
                completion(.failure(.nilDataError))
                return
            }

            
            guard let decodedData: T = self.decodedData(data) else {
                completion(.failure(.dataDecodingError))
                return
            }

            completion(.success(decodedData))
        }
        dataTask.resume()
    }
    
    //This method assumes that the data to be decoded is a json, this should be improved
    private func decodedData<T: Codable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let error as NSError {
            print("error decoding json \(error) , \(error.userInfo)")
            return nil
        }
    }
    
    //MARK: - Method to fetch generic data
    //TODO: - This could be improved
    func fetchUserImage(with urlString: String, completion: @escaping (Data?)->Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            completion(data)
        }
        dataTask.resume()
    }
}
