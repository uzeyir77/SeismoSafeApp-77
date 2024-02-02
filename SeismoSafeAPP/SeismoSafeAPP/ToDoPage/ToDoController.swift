//
//  ToDoController.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 26.01.24.
//

import UIKit

class ToDoController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let viewModel = ToDoViewModel()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.safetyData?.earthquakeSafety.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionView", for: indexPath) as? ToDoCollectionViewCell
        let safetyData = viewModel.safetyData?.earthquakeSafety[indexPath.item]
            cell?.titleLabel.text = safetyData?.title
            cell?.subtitleLabel.text = safetyData?.subtitle
            return cell!
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedSafetyItem = viewModel.safetyData?.earthquakeSafety[indexPath.item] {
            showSafetyData(for: selectedSafetyItem)
        }
    }
    func showSafetyData(for safetyItem: SafetyDetail) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(identifier: "ToDoDetailsController") as? ToDoDetailsController {
            detailVC.safetyItem = safetyItem
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }



    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        viewModel.parseJsonFile()
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ToDoCollectionView", bundle: nil), forCellWithReuseIdentifier: "ToDoCollectionView")
    }
    

    
}
