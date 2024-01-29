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
        viewModel2.success =  {[weak self ] in
            self?.AllEarthquakeCell.reloadData() }
        viewModel2.error = { [weak self ] errorMessages in
            print("Error:\(errorMessages)")
        }
        AllEarthquakeCell.delegate = self
        AllEarthquakeCell.dataSource = self
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel2.eartquakes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagnitudeCell", for: indexPath) as? MagnitudeCell else{
                return UITableViewCell()
            }
            let eartquakes = viewModel2.eartquakes[indexPath.row]
            cell.magnitudeLabel.text = "\(eartquakes.properties?.mag ?? 0)"
            cell.placeLabel.text = eartquakes.properties?.place
            //cell.timeLabel.text = "\(formattedTime(for: eartquakes))"
            return cell
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

