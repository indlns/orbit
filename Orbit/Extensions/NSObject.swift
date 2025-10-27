//
//  NSObject.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import Foundation

extension NSObjectProtocol {
    @discardableResult
    func apply(_ closure: (Self) -> () ) -> Self {
    { closure(self) } ()
        return self
    }
}
