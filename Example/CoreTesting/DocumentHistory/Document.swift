//
//  Document.swift
//  CoreTesting
//
//  Created by Georgios Sotiropoulos on 1/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

struct Document {
    let title: String
    let subtitle: String
    let type: Type
}

extension Document {
    enum `Type` {
        case received
        case clarify
        case validated
        case rejected
    }
}
