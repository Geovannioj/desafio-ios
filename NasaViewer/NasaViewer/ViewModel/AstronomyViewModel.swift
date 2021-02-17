//
//  AnatomyViewModel.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

protocol AstronomyViewModelProtocol {
    var astronomyModel: AstronomyModel? { get }
    var astros: [AstronomyModel]? { get }
    var networkManager: NetworkManagerProtocol { get }
    var imgData: Data? { get }
    
    func requestData(contentOf: String, completionHandler: @escaping (ResultStatus) -> Void)
    func getFormattedDate(inputDateStr: String) -> String
    func getSpecificDate(daysFromNow: Int) -> String
    
}

class AstronomyViewModel: AstronomyViewModelProtocol {
    
    var astronomyModel: AstronomyModel?
    var astros: [AstronomyModel]? = [AstronomyModel]()
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var imgData: Data?
    
    
    func requestData(contentOf: String, completionHandler: @escaping (ResultStatus) -> Void) {
        networkManager.requestData(dateStr: contentOf) { [weak self] (resultStatus, model) in
            if resultStatus == .success {
                self?.astronomyModel = model
                let url = URL(string: model?.url ?? String())
                DispatchQueue.global().async {
                    guard let url = url else { return }
                    let data = try? Data(contentsOf: url)
                    self?.imgData = data
                    self?.astronomyModel? = model!
                    self?.astros?.append(model!)
                    completionHandler(.success)
                }
            } else {
                completionHandler(.failure)
                print("ERROR on thre request")
            }
        }
    }
    
    func getFormattedDate(inputDateStr: String) -> String {
        var outputDate = String()
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterInput.date(from: inputDateStr) {
            outputDate = dateFormatterOutput.string(from: date)
            
        } else {
            print("There was an error decoding the string")
            outputDate = "########"
        }
        
        return outputDate
    }
    
    func getSpecificDate(daysFromNow: Int) -> String {
        
        let secondsInDay = 86400
        let secondsSince1970 = Date().timeIntervalSince1970
        let secondsToSubtract = TimeInterval(secondsInDay * daysFromNow)
        let secondsToGetDate = secondsSince1970 - secondsToSubtract
        
        let date = Date(timeIntervalSince1970: secondsToGetDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "yyyy-MM-dd"

        let outputDate = dateFormatterOutput.string(from: date)
        return outputDate
    }
    
}
