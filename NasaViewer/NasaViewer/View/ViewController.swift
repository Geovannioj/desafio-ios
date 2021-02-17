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

    var astronomy: AstronomyModel?
    var viewModel: AstronomyViewModelProtocol? = AstronomyViewModel()
    var imgData: Data?
    var daysOffset: Int = 0
    let astronomyXibName = "AstronomyTableViewCell"
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        guard let todayDate = viewModel?.getSpecificDate(daysFromNow: 0) else { return }
        bindData(dataOfContent: todayDate)
    }
    
    func bindData(dataOfContent: String) {
        viewModel?.requestData(contentOf: dataOfContent, completionHandler: { (result) in
            if result == .success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {

            }
        })
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: astronomyXibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.astros?.count)! //self.astros?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AstronomyTableViewCell else { return UITableViewCell() }
        
        cell.title.text = viewModel?.astros?[indexPath.row].title
        cell.dateContent.text = viewModel?.getFormattedDate(inputDateStr: (viewModel?.astros?[indexPath.row].date)!)
        if let imgData = viewModel?.imgData {
            cell.imgView.image = UIImage(data: imgData)
        }
        cell.viewmodel = self.viewModel
        cell.copyrightContent.text = viewModel?.astros?[indexPath.row].copyright
        cell.explanation.text = viewModel?.astros?[indexPath.row].explanation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (viewModel?.astros?.count)! - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.daysOffset += 1
                guard let specificDay = self.viewModel?.getSpecificDate(daysFromNow: self.daysOffset) else { return }
                print("Requesting content of \(specificDay)")
            
                self.bindData(dataOfContent: specificDay)
            }
            
        }
    }
}

