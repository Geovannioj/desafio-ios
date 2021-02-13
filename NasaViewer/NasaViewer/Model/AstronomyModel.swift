//
//  AstronomyModel.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

struct AstronomyModel: Codable {
    var copyright: String
    var date: String
    var explanation: String
    var hdurl: String
    var mediaType: String
    var serviceVersion: String
    var title: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
