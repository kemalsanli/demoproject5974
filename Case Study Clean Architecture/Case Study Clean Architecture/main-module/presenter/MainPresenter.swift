//
//  MainPresenter.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

final class MainPresenter: ViewToPresenterMainProtocol{

    var imageUrlsArray: Array<String> = [String]()
    var imageSizeLessThan100KB: Array<UIImage> = [UIImage]()
    var imageSizeLessThan250KB: Array<UIImage> = [UIImage]()
    var imageSizeLessThan500KB: Array<UIImage> = [UIImage]()
    var imageSizemMoreThan500KB: Array<UIImage> = [UIImage]()

    var MainInteractor: PresenterToInteractorMainProtocol?
    
    var MainView: PresenterToViewMainProtocol?
    
    
    func getSearchResult(Keyword: String) {
        let trimmedString = Keyword.trimmingCharacters(in: .whitespaces)
        if trimmedString.count > 3 {
            let lowercasedString = trimmedString.lowercased()
            MainInteractor?.apiCall(Keyword: lowercasedString)
        }
    }
    
    func getCellImage(indexPath: IndexPath) -> UIImage {
        switch indexPath.section {
        case 0:
            return imageSizeLessThan100KB[indexPath.row]
        case 1:
            return imageSizeLessThan250KB[indexPath.row]
        case 2:
            return imageSizeLessThan500KB[indexPath.row]
        case 3:
            return imageSizemMoreThan500KB[indexPath.row]
        default:
            return UIImage(systemName: "star")!
        }
    }
    
    func getPreviewImage(indexPath: IndexPath) -> UIImage {
        return getCellImage(indexPath: indexPath)
    }
    
    func getSectionCount() -> Int {
        return 4
    }
    
    func getCellCount(Section: Int) -> Int {
        switch Section {
        case 0:
            return imageSizeLessThan100KB.count
        case 1:
            return imageSizeLessThan250KB.count
        case 2:
            return imageSizeLessThan500KB.count
        case 3:
            return imageSizemMoreThan500KB.count
        default:
            return 0
        }
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    func clearArraysForNewSearch() {
        imageUrlsArray.removeAll()
        imageSizeLessThan100KB.removeAll()
        imageSizeLessThan250KB.removeAll()
        imageSizeLessThan500KB.removeAll()
        imageSizemMoreThan500KB.removeAll()
    }
    
    func sendSearchResults(Results: [Result]) {
        clearArraysForNewSearch()
        for result in Results {
            imageUrlsArray.append(contentsOf: result.screenshotUrls)
        }
        MainInteractor?.downloadImages(Array: imageUrlsArray)
        DispatchQueue.main.async { [weak self] in
            self?.MainView?.performDataRefresh()
        }
    }
    
    func sendDownloadedImage(Image: UIImage) {
        guard let imageSize = MainInteractor?.calculateImageSize(Image: Image) else { return }
        switch imageSize {
        case 0...100:
            imageSizeLessThan100KB.append(Image)
        case 100...250:
            imageSizeLessThan250KB.append(Image)
        case 250...500:
            imageSizeLessThan500KB.append(Image)
        default:
            imageSizemMoreThan500KB.append(Image)
        }
        DispatchQueue.main.async { [weak self] in
            self?.MainView?.performDataRefresh()
        }
        
    }
    
    func getSectionHeaderTitle(Section: Int) -> String {
        switch Section {
        case 0:
            return "0-100KB Images"
        case 1:
            return "100-250KB Images"
        case 2:
            return "250-500KB Images"
        case 3:
            return "500 and more KB Images"
        default:
            return "Unknown Section"
        }
    }
}


