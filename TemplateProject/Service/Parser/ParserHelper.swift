//
//  ParserHelper.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

final class ParserHelper {
    static func parse<T: Decodable>(data: Data) -> AnyPublisher<T, Error> {
        return Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
