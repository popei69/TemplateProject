//
//  Converter.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Converter {
    
    let base : String
    let date : String
    
    let rates : [CurrencyRate]
}

extension Converter: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.base = try container.decode(String.self, forKey: .base)
        self.date = try container.decode(String.self, forKey: .date)
        
        self.rates = try container.decode([String: Double].self, forKey: .rates)
            .compactMap { CurrencyRate(currencyIso: $0.key, rate: $0.value) }
    }
}
