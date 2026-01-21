//
//  HomeViewModel.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import Foundation
import Playgrounds
import FoundationModels


final class HomeViewModel {

    private let service = HomeService()

    func getLetter(
        name: String,
        profession: String,
        goal: String,
        date: Date
    ) async throws -> String {

        let availability = SystemLanguageModel.default.availability
        guard case .available = availability else {
            throw NSError(domain: "ModelUnavailable", code: 0)
        }

        return try await service.getLetter(
            name: name,
            profession: profession,
            goal: goal,
            date: date
        )
    }
}


