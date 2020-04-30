//
//  String+Extension.swift
//  Covid19
//
//  Created by Federico Nieto on 20/04/2020.
//  Copyright © 2020 Federico Nieto. All rights reserved.
//

import Foundation

extension String {
    
    func flagEmoji() -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in self.utf16 {
            usv.append(UnicodeScalar(base + Int(i)) ?? UnicodeScalar(0))
        }
        return String(usv)
    }
    
}
