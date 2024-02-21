//
//  SecondViewController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 15.01.24.
//

import UIKit

class AllEarthquakeController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let viewModel2 = EartquakeViewModel()
    @IBOutlet weak var AllEarthquakeCell: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel2.getlast1DayEartquakes()
        viewModel2.success = {
            self.AllEarthquakeCell.reloadData()
        }
        AllEarthquakeCell.delegate = self
        AllEarthquakeCell.dataSource = self
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel2.eartquakes.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagnitudeCell", for: indexPath) as? MagnitudeCell else {
            return UITableViewCell()
        }
        let eartquakes = viewModel2.eartquakes[indexPath.row]
        cell.magnitudeLabel.text = "\(eartquakes.properties?.mag ?? 0)"
        cell.placeLabel.text = eartquakes.properties?.place
        cell.timeLabel.text = "\(formattedTime(for: eartquakes))"
        if let magnitude = eartquakes.properties?.mag {
                if magnitude >= 3.5 {
                    cell.magnitudeLabel.textColor = UIColor.red
                } else if magnitude >= 2.0 && magnitude < 3.5 {
                    cell.magnitudeLabel.textColor = UIColor.green
                } else {
                    cell.magnitudeLabel.textColor = UIColor.blue
                }
            } else {
                cell.magnitudeLabel.textColor = UIColor.black
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEarthquake = viewModel2.eartquakes[indexPath.row]
        let alertController = UIAlertController(title: "Eartquakes Details", message: "Location: \(selectedEarthquake.properties?.place ?? "Unknown Place")\nMagnitude: \(selectedEarthquake.properties?.mag ?? 0)", preferredStyle: .actionSheet)
        let goToWebsiteAction = UIAlertAction(title: "More Information ", style: .default) { _ in
                if let urlStr = selectedEarthquake.properties?.url,
                   let url = URL(string: urlStr) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(goToWebsiteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
     }
    private func formattedTime(for feature: EarthquakeFeature) -> String {
           guard let time = feature.properties?.time else {
               return "Unknown Time"
           }
           let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           dateFormatter.timeZone = TimeZone(identifier: "UTC")
           return dateFormatter.string(from: date)
       }
    }

