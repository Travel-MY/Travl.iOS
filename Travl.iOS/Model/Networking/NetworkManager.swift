//
//  NetworkManager.swift
//  News+
//
//  Created by Ikmal Azman on 15/08/2021.
//

import Foundation

final class NetworkManager {
    
    private let baseURL = "https://travl-api.herokuapp.com/"
    
    //MARK: - Generic Decoded Methods
    func fetchData<T:Decodable>(endpoint : Endpoint, queryString : String = "",completion : @escaping ((Result<T, TError>)->Void)) {
        let urlString = ( baseURL + "\(endpoint.rawValue)" + queryString).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        guard let url = URL(string: urlString) else {return}
        print("URL for \(endpoint.rawValue) : \(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: safeData)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.invalidData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}



