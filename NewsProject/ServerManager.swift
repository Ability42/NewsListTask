//
//  ServerManager.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ServerManager: NSObject {

    static let sharedManager = ServerManager()
    
    
    func testRequest(source: String, completionHandler: @escaping (Data) -> ()) {
        
        let targetURL = URL.init(string: source)
        var request = URLRequest.init(url: targetURL!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(Data())
            } else {
                completionHandler(data!)
            }
        }.resume()
        
    }

}
