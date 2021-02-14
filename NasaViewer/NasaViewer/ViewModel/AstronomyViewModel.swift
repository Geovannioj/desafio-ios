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
    var networkManager: NetworkManagerProtocol { get }
    var imgData: Data? { get }
    
    func requestData(completionHandler: @escaping (ResultStatus) -> Void)
    func getFormattedDate() -> String
    func getTitle() -> String
    func getExplanation() -> String
    func getCopyright() -> String

}

class AstronomyViewModel: AstronomyViewModelProtocol {
    
    var astronomyModel: AstronomyModel?
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var imgData: Data?
    
    func requestData(completionHandler: @escaping (ResultStatus) -> Void) {
        networkManager.requestData(dateStr: "2021-02-14") { [weak self] (resultStatus, model) in
            if resultStatus == .success {
                self?.astronomyModel = model
                let url = URL(string: model?.url ?? String())
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    self?.imgData = data
                    self?.astronomyModel? = model!
                    completionHandler(.success)
                }
            } else {
                completionHandler(.failure)
                print("ERROR on thre request")
            }
        }
    }
    
    func getCopyright() -> String {
        return astronomyModel?.copyright ?? String()
    }
    
    func getExplanation() -> String {
        return astronomyModel?.explanation ?? String()
    }
    
    func getTitle() -> String {
        return astronomyModel?.title ?? String()
    }
    
    func getFormattedDate() -> String {
        var outputDate = String()
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterInput.date(from: "2016-02-29") {
            outputDate = dateFormatterOutput.string(from: date)
            print(dateFormatterOutput.string(from: date))
        } else {
            print("There was an error decoding the string")
            outputDate = "########"
        }
        
        return outputDate
    }
}
