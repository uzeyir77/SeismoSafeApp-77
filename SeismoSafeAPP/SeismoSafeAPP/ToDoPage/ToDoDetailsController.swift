//
//  ToDoDetailsController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 31.01.24.
//

import UIKit

class ToDoDetailsController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailImageField: UIImageView!

    @IBOutlet weak var detailLabelField: UILabel!
    var safetyItem: SafetyDetail?

        override func viewDidLoad() {
            super.viewDidLoad()
            showSafetyDetails()
        }
        func showSafetyDetails() {
            guard let safetyItem = safetyItem else { return }
            
            detailTitleLabel.text = safetyItem.title
            detailLabelField.text = safetyItem.details.joined(separator: "\n")
            detailImageField.image = UIImage(named: safetyItem.imageURL!)
            
            if let imageURL = safetyItem.imageURL, let url = URL(string: imageURL) {
                
            }
        }
    }
    
    


