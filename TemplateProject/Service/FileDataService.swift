//
//  File.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 02/02/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

final class FileDataService : CurrencyServicePublisher {
    func fetchConverter() -> AnyPublisher<Converter, ErrorResult> {
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample") else {
            return Fail(outputType: Converter.self, 
                        failure: ErrorResult.custom(string: "No file or data")
                )
                .eraseToAnyPublisher()
        }

        return Just(data)
            .decode(type: Converter.self, decoder: JSONDecoder())
            .mapError { error in 
                ErrorResult.parser(string: "Unable to parse data")
            }
            .eraseToAnyPublisher()
    }
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
