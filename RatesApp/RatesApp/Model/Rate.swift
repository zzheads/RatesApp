//
//  Rate.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

struct Rate {
    let date    : Date
    let currency: Currency
    let value   : Double

    static func getRates(_ date: Date) -> URL? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return URL(string: "https://www.cbr.ru/scripts/XML_daily.asp?date_req=\(dateFormatter.string(from: date))")
    }
}
