//
//  LocationTableViewCell.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 05/11/2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    static let identifier = "LocationTableViewCell"
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(location: String) {
        locationNameLabel.text = location
    }
}
