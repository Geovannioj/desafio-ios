//
//  String.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: String(),
                                 comment: String())
    }
    
}
