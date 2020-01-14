//
//  Dog.swift
//  CollectionViews-DogBreeds
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

typealias DogImage = String

struct Dog: Decodable {
    let message: [DogImage]
}

