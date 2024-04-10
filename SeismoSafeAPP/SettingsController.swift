//
//  SettingsController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 27.03.24.
//

import UIKit
import FloatingPanel

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource,FloatingPanelControllerDelegate {
    var fpc: FloatingPanelController!
    
    @IBOutlet weak var tableView: UITableView!
    let sections = ["About Us", "Support", "Share", "Join Us on Facebook"]
            
        override func viewDidLoad() {
            super.viewDidLoad()
                
            fpc = FloatingPanelController()
            fpc.delegate = self
            
            let contentVC = AboutController()
            fpc.set(contentViewController: contentVC)
            fpc.addPanel(toParent: self)

            
            tableView.dataSource = self
            tableView.delegate = self
        }
    
    override func viewWillAppear(_ animated: Bool) {
        fpc.hide(animated: true)

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
                fpc.show(animated: true) {
                    
                }
            case "Support":
                break
            case "Share":
                break
            case "Join Us on Facebook":
                openFacebookPage()
            default:
                break
            }
        }
        func openFacebookPage() {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let goToWebsiteAction = UIAlertAction(title: "Open in Facebook ", style: .default) { _ in
                if let url = URL(string: "https://www.facebook.com/profile.php?id=61557523366371") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(goToWebsiteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }

 

