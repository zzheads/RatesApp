//
//  Currency.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import SwiftyXMLParser

enum Currency: String, Codable {
    case usd = "USD"
    case eur = "EUR"
    
    var id: String {
        switch self {
        case .usd   : return "R01235"
        case .eur   : return "R01239"
        }
    }
    
    var parse: (XMLString) -> Rate? {
        return { (string: XMLString) in
            guard let xml = try? XML.parse(string) else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            guard
                let dateString = xml["ValCurs"].attributes["Date"],
                let date = dateFormatter.date(from: dateString),
                let valueString = xml["ValCurs", "Valute"].filter({ $0.attributes["ID"] == self.id }).first?["Value"].text,
                let value = Double(valueString.replacingOccurrences(of: ",", with: "."))
                else {
                    return nil
            }
            return Rate(date: date, currency: self, value: value)
        }
    }
}




