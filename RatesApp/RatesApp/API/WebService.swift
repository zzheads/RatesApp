//
//  WebService.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire
import PromiseKit

typealias XMLString = String

class WebService {
    static let `default` = WebService()
    
    private init() {}
    
    func fetch(_ url: URL) -> Promise<XMLString> {
        return Promise<XMLString>() { resolver in
            Alamofire.request(url).responseString { response in
                switch response.result {
                case .success(let string)   : resolver.fulfill(string)
                case .failure(let error)    : resolver.reject(error)
                }
            }
        }
    }
}
