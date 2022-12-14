//
//  Download.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 28.11.2022.
//

import Foundation

class Download: NSObject {

    var url: String
    var isDownloading = false

    var downloadTask: URLSessionDownloadTask?
    var resumeData: Data?

    init(url: String) {
        self.url = url
    }
}
