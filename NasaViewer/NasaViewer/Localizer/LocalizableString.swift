//
//  LocalizableString.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

enum LocalizableStrings: String {
    case projectName
    
    func localized() -> String {
        rawValue.localized()
    }
}
