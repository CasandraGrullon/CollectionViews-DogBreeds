//
//  ViewController.swift
//  CollectionViews-DogBreeds
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import NetworkHelper

// Collection View Cells are self-resizing by default
// Need to set "estimated size" from automatic --> none on size inspector


class DogViewController: UIViewController {

    @IBOutlet weak var dogCollectionView: UICollectionView!
    
    private var dogImages = [DogImage]() {
        didSet{
            DispatchQueue.main.async {
                self.dogCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogCollectionView.dataSource = self
        dogCollectionView.delegate = self
        dogCollectionView.backgroundColor = #colorLiteral(red: 1, green: 0.7220906615, blue: 0.8361660838, alpha: 1)
        loadData()
    }
    
    func loadData() {
        DogAPIClient.fetchDogs { [weak self] (result) in
            switch result{
            case .failure(let appError):
                print(appError)
            case .success(let dogs):
                self?.dogImages = dogs
            }
        }
    }
}

extension DogViewController: UICollectionViewDataSource {
    
    // this is to populate collection view with our data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? DogCell else {
            fatalError("could not downcast to dog cell")
        }
        let dogImage = dogImages[indexPath.row]
        cell.configureCell(for: dogImage)
        return cell
    }
}

extension DogViewController: UICollectionViewDelegateFlowLayout {
    
    // this is where we determine the size of the items, the appearance of layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // width of device
        let numberOfItems: CGFloat = 3 // number of items per row
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing // determining the total space taken by items
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems // width of item
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
