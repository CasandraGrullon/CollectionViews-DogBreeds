//
//  DogCell.swift
//  CollectionViews-DogBreeds
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import NetworkHelper
import ImageKit

class DogCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
        
    func configureCell(for dog: DogImage){
        dogImageView.getImage(with: dog) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.dogImageView.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.dogImageView.image = image
                }
            }
        }
    }
}
