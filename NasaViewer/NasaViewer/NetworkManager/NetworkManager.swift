//
//  NetworkManager.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    var result: AstronomyModel?
    
    let JSON = """
{
    "copyright": "Astro Anarchy",
    "date": "2021-02-11",
    "explanation": "In brush strokes of interstellar dust and glowing gas, this beautiful skyscape is painted across the plane of our Milky Way Galaxy near the northern end of the Great Rift and the constellation Cygnus the Swan. Composed over a decade with 400 hours of image data, the broad mosaic spans an impressive 28x18 degrees across the sky. Alpha star of Cygnus, bright, hot, supergiant Deneb lies at the left. Crowded with stars and luminous gas clouds Cygnus is also home to the dark, obscuring Northern Coal Sack Nebula and the star forming emission regions NGC 7000, the North America Nebula and IC 5070, the Pelican Nebula, just left and a little below Deneb. Many other nebulae and star clusters are identifiable throughout the cosmic scene. Of course, Deneb itself is also known to northern hemisphere skygazers for its place in two asterisms, marking a vertex of the Summer Triangle, the top of the Northern Cross.",
    "hdurl": "https://apod.nasa.gov/apod/image/2102/00Cygnus_Visual_colors.jpg",
    "media_type": "image",
    "service_version": "v1",
    "title": "Cygnus Mosaic 2010 - 2020",
    "url": "https://apod.nasa.gov/apod/image/2102/00Cygnus_Visual_colors1100.jpg"
}
"""
    func requestData(dateStr: String = "2021-02-11") {
        
        let parameters = ["api_key": "DEMO_KEY",
                          "date": dateStr]
        
        AF.request("https://api.nasa.gov/planetary/apod?",
                   method: .get,
                   parameters: parameters).responseDecodable(of: AstronomyModel.self) { (response) in
            guard let astronomyContent = response.value else { return }
            self.result = astronomyContent
                    
        }
    }

    public func parseData() {
        let decoder = JSONDecoder()
        let jsonData = JSON.data(using: .utf8)!
        
        if let jsonResult = try? decoder.decode(AstronomyModel.self, from: jsonData) {
            self.result = jsonResult
        } else {
            print("Error parsing JSON")
        }
        
    }
}
