//
//  AstronomyTableViewCell.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class AstronomyTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateContent: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var copyrightLbl: UILabel!
    @IBOutlet weak var copyrightContent: UILabel!
    @IBOutlet weak var explanation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
