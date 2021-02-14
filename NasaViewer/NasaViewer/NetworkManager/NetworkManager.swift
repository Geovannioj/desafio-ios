//
//  NetworkManager.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import Alamofire

enum ResultStatus {
    case success
    case failure
}

protocol NetworkManagerProtocol {
    func requestData(dateStr: String, completionHandler: @escaping ((ResultStatus,AstronomyModel?) -> Void))
    func downloadImage(from url: URL, tableView: UITableView) -> Data
    
}

class NetworkManager: NetworkManagerProtocol {
    
    var result: AstronomyModel?
    
    func requestData(dateStr: String = "2021-02-11", completionHandler: @escaping ((ResultStatus,AstronomyModel?) -> Void)) {
        
        let parameters = ["api_key": "DEMO_KEY",
                          "date": dateStr]
        
        AF.request("https://api.nasa.gov/planetary/apod?",
                   method: .get,
                   parameters: parameters).responseDecodable(of: AstronomyModel.self) { (response) in
                    guard let astronomyContent = response.value else { completionHandler(.failure, nil); return }
            self.result = astronomyContent
            completionHandler(.success, astronomyContent)
            
                    
        }
    }

    func getUrlData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, tableView: UITableView) -> Data {
        var imageData: Data?
        
        getUrlData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            imageData = data
        }
        tableView.reloadData()
        return imageData ?? Data()
    }
}
