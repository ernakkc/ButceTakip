//
//  Formatter.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 3.08.2026.
//

import Foundation
import SwiftUI

var amountFormatter: NumberFormatter {
    let f = NumberFormatter()
    f.numberStyle = .decimal
    f.maximumFractionDigits = 2
    f.minimumFractionDigits = 0
    return f
}
