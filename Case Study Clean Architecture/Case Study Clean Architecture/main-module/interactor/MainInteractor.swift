//
//  MainInteractor.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

final class MainInteractor: NSObject, PresenterToInteractorMainProtocol {
    var MainPresenter: InteractorToPresenterMainProtocol?
    
    lazy var concurrencyQueue:OperationQueue = {
        let queue = OperationQueue()
        queue.name = Constants.queueName
        queue.maxConcurrentOperationCount = Constants.maxConcurrentOperationCount
        return queue
    }()
    
    var activeDownloads = [String]()
    var unsuccesfullDownloads = [String]()
    
    func apiCall(Keyword: String) {
        let url = prepareUrl(keyword: Keyword, limit: Constants.defaultApiSearchLimit)
        NetworkRequests().requestAndParse(url: url ,
                                          object: ResultModel.self) { [weak self] resultModel in
            let results = resultModel.results
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.activeDownloads.removeAll()
                self.MainPresenter?.sendSearchResults(Results: results)
            }
        }
    }
    
    func downloadImages(array: [String]) {
        for url in array {
            let formattedUrl:URL = URL(string: url)!
            activeDownloads.append(url)
            concurrencyQueue.addOperation {
                let configuration = URLSessionConfiguration.default
                configuration.httpMaximumConnectionsPerHost = Constants.httpMaximumConnectionsPerHost
                let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
                session.downloadTask(with: formattedUrl).resume()
            }
        }
        concurrencyQueue.addOperation { [unowned self] in
            self.retryDownloads()
        }
    }
    
    func retryDownloads() {
        if unsuccesfullDownloads.count != 0 {
            activeDownloads = unsuccesfullDownloads
            unsuccesfullDownloads = []
            downloadImages(array: activeDownloads)
        }
    }
    
    func calculateImageSize(Image: UIImage) -> Int {
        guard let imageData = Image.pngData() else { return 0 }
        let sizeInKB = Int(imageData.count / 1024) //Due to 1024 Byte equals to 1 kb.
        return sizeInKB
    }
    
    func prepareUrl(keyword:String, limit: Int = Constants.defaultApiSearchLimit) -> URL {
        let queryParams: [String: String] = [
            "media": Constants.mediaValue,
            "limit": String(limit),
            "term": keyword
        ]

        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.setQueryItems(with: queryParams)
        let resultUrl = urlComponents.url!
        return resultUrl
    }
}

extension MainInteractor: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location),
              let image = UIImage(data: data) else { return }
        MainPresenter?.sendDownloadedImage(Image: image)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let imageUrl = task.originalRequest?.url?.relativeString else { return }
        DispatchQueue.main.async { [weak self] in
            self?.unsuccesfullDownloads.append(imageUrl)
        }
    }
}

private enum Constants {
    static let host: String = "itunes.apple.com"
    static let scheme: String = "https"
    static let path: String = "/search"
    static let mediaValue: String = "software"
    static let queueName: String = "download"
    static let httpMaximumConnectionsPerHost: Int = 3
    static let maxConcurrentOperationCount: Int = 3
    static let defaultApiSearchLimit: Int = 5
    static let defaultDelayForDownloadTasks: Double = 0.1
}


fileprivate extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
