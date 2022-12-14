//
//  NetworkRequests.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation

class NetworkRequests {
    func requestAndParse<T: Decodable>(url:URL, object: T.Type, completion: @escaping (T) -> Void) {
            URLSession.shared.dataTask(with: url) { data, response, taskError in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode),
                      let data = data else {
                    fatalError()
                }
                let decoder = JSONDecoder()
                guard let response = try? decoder.decode(object.self, from: data) else {
                    return
                }
                completion(response)
            }.resume()
    }
}
