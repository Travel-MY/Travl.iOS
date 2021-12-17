//
//  PlannerInteractor.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 16/12/2021.
//

import Foundation

final class PlannerInteractor {
    //MARK: - Variables
    private let networkManager = NetworkManager()
    
    func fetchFooterImages(completion :@escaping ((Result<ImagesResponse, TError>)->Void)) {
        networkManager.fetchData(endpoint: .images) { (_ result : Result<ImagesResponse, TError>) in
            switch result {
            case .success(let data):
                print("Image Data : \(data.images)")
                completion(.success(data))
            case .failure(let error):
                print("ERROR : \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
