//
//  CurrencyService.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

protocol CurrencyServicePublisher : class {
    func fetchConverter() -> AnyPublisher<Converter, ErrorResult>
}
