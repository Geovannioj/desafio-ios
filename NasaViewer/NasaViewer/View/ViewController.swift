//
//  ViewController.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var netMa = NetworkManager()
    
    var astronomy: AstronomyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AstronomyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        netMa.parseData()
        astronomy = netMa.result
        netMa.requestData()
        
//        print(netMa.result?.copyright)
//        print(netMa.result?.date)
//        print(netMa.result?.explanation)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AstronomyTableViewCell else { return UITableViewCell() }
        
        cell.title.text = astronomy.title
        cell.dateContent.text = astronomy.date
        //PEGAR IMAGEM DO LINK
        cell.imageView?.image = UIImage()
        cell.copyrightContent.text = astronomy.copyright
        cell.explanation.text = astronomy.explanation
        
        return cell
    }
    
    
}

