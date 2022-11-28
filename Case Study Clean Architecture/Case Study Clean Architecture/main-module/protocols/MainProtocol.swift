//
//  MainProtocol.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterMainProtocol {
    var MainInteractor:PresenterToInteractorMainProtocol? {get set}
    var MainView:PresenterToViewMainProtocol? {get set}
    
    func getSearchResult(Keyword: String)
    func getCellImage(indexPath: IndexPath) -> UIImage
    func getSectionCount() -> Int
    func getCellCount(Section: Int) -> Int
    func getSectionHeaderTitle(Section: Int) -> String
    func getPreviewImage(indexPath: IndexPath) -> UIImage
}

protocol PresenterToInteractorMainProtocol {
    var MainPresenter:InteractorToPresenterMainProtocol? {get set}
    
    func apiCall(Keyword: String)
    func downloadImages(Array: [String])
    func calculateImageSize(Image: UIImage) -> Int
}

protocol InteractorToPresenterMainProtocol {
    func sendSearchResults(Results: [Result])
    func sendDownloadedImage(Image:UIImage)
}

protocol PresenterToViewMainProtocol {
    func performDataRefresh()
}

protocol PresenterToRouterMainProtocol {
    static func createModule(ref:MainViewController)
}
