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
    
    lazy var downloadsSession: URLSession = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600
        configuration.timeoutIntervalForResource = 600
        configuration.httpMaximumConnectionsPerHost = 3
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:self.concurrencyQueue)
        
        return session
    }()
    
    lazy var concurrencyQueue:OperationQueue = {
        let queue = OperationQueue()
        queue.name = "download"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    var activeDownloads = [String: Download]()
    
    func apiCall(Keyword: String) {
        NetworkRequests().requestAndParse(url: String(format: Constants.mainUrl, Keyword),
                                          object: ResultModel.self) { [weak self] resultModel in
            let results = resultModel.results
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                for download in self.activeDownloads where download.value.isDownloading {
                    download.value.downloadTask?.cancel()
                }
                self.MainPresenter?.sendSearchResults(Results: results)
            }
        }
    }
    
    func downloadImages(Array: [String]) {
        for url in Array {
            let formattedUrl:URL = URL(string: url)!
            let download = Download(url:url)
            download.downloadTask = self.downloadsSession.downloadTask(with: formattedUrl)
            download.downloadTask!.resume()
            download.isDownloading = true
            activeDownloads[download.url] = download
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {}
        }
    }
    
    func calculateImageSize(Image: UIImage) -> Int {
        guard let imageData = Image.pngData() else { return 0 }
        let sizeInKB = Int(imageData.count / 1024) //Due to 1024 Byte equals to 1 kb.
        return sizeInKB
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
            self?.activeDownloads[imageUrl]?.isDownloading = false
        }
    }
}

private enum Constants {
    static let mainUrl: String = "https://itunes.apple.com/search?media=software&limit=10&term=%@"
}
