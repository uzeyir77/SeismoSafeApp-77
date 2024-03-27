//
//  AboutController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 22.02.24.
//

import UIKit

class AboutController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func gotoMap(_ sender: Any) {
        let secondViewController = MapViewController()
        let navigationController = UINavigationController(rootViewController: secondViewController)
        self.present(navigationController, animated: true)
    }

}
