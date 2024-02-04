//
//  MagnitudeCell.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 29.01.24.
//

import UIKit

class MagnitudeCell: UITableViewCell {

   
    @IBOutlet weak var magnitudeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
