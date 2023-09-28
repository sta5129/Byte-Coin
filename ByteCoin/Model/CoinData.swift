//
//  CoinData.swift
//  ByteCoin
//
//  Created by Samarah Anderson on 5/9/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

//Struct that conforms to the decodable protocol that decodes the JSON
struct CoinData: Decodable {
    let rate: Double
}

