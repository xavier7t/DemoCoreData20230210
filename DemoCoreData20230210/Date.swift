//
//  Date.swift
//  DemoCoreData20230210
//
//  Created by Xavier on 2/10/23.
//

import Foundation

extension Date {
    func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
