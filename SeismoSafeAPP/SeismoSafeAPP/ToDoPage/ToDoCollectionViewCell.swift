//
//  ToDoCollectionView.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 30.01.24.
//

import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewToDo: UIView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var GoToDetailsButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
