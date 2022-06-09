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
    
    func fetchFooterImages()async throws -> ImagesResponse {
        let imageResponse : ImagesResponse = try await networkManager.fetchData(endpoint: .images, queryString: "")
        return imageResponse
    }
}
