//
//  SettingsController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 27.03.24.
//

import UIKit

class SettingsController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let sections = ["About Us", "Support", "Share"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSection = sections[indexPath.row]
        
        switch selectedSection {
        case "About Us":
            // About Us sayfasını göster
            break
        case "Support":
            // Support sayfasını göster
            break
        case "Share":
            // Share sayfasını göster
            break
        default:
            break
        }
    }
}
