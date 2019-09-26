//
//  Error+Extension.swift
//  Weather
//
//  Created by Preeti Rani on 25/09/19.
//  Copyright © 2019 Rani. All rights reserved.
//

import Foundation
extension Error {
    var code: Int { return (self as NSError).code }
    var description: String { return (self as NSError).description }
}
