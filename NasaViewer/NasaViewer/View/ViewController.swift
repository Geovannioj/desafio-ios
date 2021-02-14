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
    
//    var netMa = NetworkManager()
    var astronomy: AstronomyModel?
    var viewModel: AstronomyViewModelProtocol? = AstronomyViewModel()
    var imgData: Data?
    let astronomyXibName = "AstronomyTableViewCell"
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        viewModel?.requestData(completionHandler: { (result) in
            if result == .success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        })
//        let date1 = viewModel?.getFormattedDate()
//        astronomy = netMa.result
        
//        netMa.requestData(dateStr: "2021-02-10") { [weak self] (resultStatus, model) in
//            if resultStatus == .success {
//                self?.astronomy = model
//                let url = URL(string: self?.astronomy?.url ?? String())
//                DispatchQueue.global().async {
//                    let data = try? Data(contentsOf: url!)
//                    self?.imgData = data
//
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                }
//                self?.tableView.reloadData()
//            } else {
//                print("ERROR on thre requst")
//            }
//        }
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: astronomyXibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AstronomyTableViewCell else { return UITableViewCell() }
        
        cell.title.text = viewModel?.getTitle()//astronomy?.title
        cell.dateContent.text = viewModel?.getFormattedDate()//astronomy?.date
        if let imgData = viewModel?.imgData {
            cell.imgView.image = UIImage(data: imgData)
        }
        cell.copyrightContent.text = viewModel?.getCopyright()//astronomy?.copyright
        cell.explanation.text = viewModel?.getExplanation()//astronomy?.explanation
        
        return cell
    }
    
    
}

