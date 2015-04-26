//
//  CurrentValues.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 23/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

struct Constants {
    let tableViewTitles: [String] = ["Data Rate (kb/s)", "Gigabytes per Day", "Number of Days", "Number of Months", "Number of Years"]
    let hardDriveCapacities: [(string: String, int: Int)] = [("1 TB", 1000), ("2 TB", 2000), ("3 TB", 3000), ("4 TB", 4000), ("6 TB", 6000)]
    let frameRates: [Int] = [1, 2, 4, 6, 8, 10, 12, 16, 20, 25]
    let resolutions: [(name: String, value: Int)] = [("QCIF", 176 * 144), ("CIF", 352 * 240), ("2CIF", 704 * 240), ("4CIF", 704 * 480), ("720p" , 1280 * 720), ("1080p", 1920 * 1080)]
    let resolutionMultipliers: [Double] = [0.25, 1, 2, 4, 8, 20]
    let baseDataRates: [Double] = [32, 48, 96, 128, 192, 224, 256, 384, 448, 512]
}