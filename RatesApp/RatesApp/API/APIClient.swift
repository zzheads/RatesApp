//
//  APIClient.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import PromiseKit
import SwiftyXMLParser

class APIClient {
    static let `default` = APIClient(service: WebService.default)
    
    let service: WebService
    
    private init(service: WebService) {
        self.service = service
    }
    
    func getRates(_ currencies: [Currency], on date: Date) -> Promise<[Rate]> {
        return Promise<[Rate]>() { resolver in
            guard let resource = Rate.getRates(date) else {
                resolver.reject(APIError.badURL(date: date).error)
                return
            }
            self.service.fetch(resource)
                .done { xml in
                    let rates = currencies.compactMap({ $0.parse(xml) })
                    resolver.fulfill(rates)
                }
                .catch { error in
                    resolver.reject(error)
                }
        }
    }
}
