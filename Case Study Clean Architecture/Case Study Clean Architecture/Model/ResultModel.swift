//
//  ResultModel.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation

// MARK: - ResultModel
struct ResultModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let screenshotUrls: [String]
}
