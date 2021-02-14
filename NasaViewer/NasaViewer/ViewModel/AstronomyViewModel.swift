//
//  AnatomyViewModel.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

protocol AnatomyViewModelProtocol {
    var astronomyModel: Bindable<AstronomyModel>? { get }
    
    func formatDate() -> String
}

class AnatomyViewModel: AnatomyViewModelProtocol {

    
    var astronomyModel: Bindable<AstronomyModel>?
    
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26") {
            print(dateFormatterPrint.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
        
        return String()
    }
}
