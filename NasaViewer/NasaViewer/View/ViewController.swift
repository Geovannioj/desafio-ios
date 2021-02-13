//
//  ViewController.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var netMa = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netMa.parseData()
        print(LocalizableStrings.projectName.localized())
    }


}

