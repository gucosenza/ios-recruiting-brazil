//
//  Network.swift
//  Movs
//
//  Created by gustavo.cosenza on 21/06/20.
//  Copyright © 2020 Gustavo. All rights reserved.
//

import Foundation

class Network {
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["content-type":"application/json;charset=utf-8"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private let session = URLSession(configuration: configuration)
    
    func loadRest(url: URL, completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .noResponse)
                    return
                }
                if response.statusCode == 200 {
                    completionHandler(data, nil)
                    return
                } else {
                    completionHandler(nil, .responseStatusCode(code: response.statusCode))
                }
            } else {
                completionHandler(nil, .taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
}
