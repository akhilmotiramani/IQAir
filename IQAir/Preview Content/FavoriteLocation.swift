//
//  FavoriteLocation.swift
//  IQAir
//
//  Created by Akhil Motiramani on 9/16/23.
//

import Foundation
struct FavoriteLocation: Identifiable {
    let id = UUID()
    let name: String
    let city: String
    let state: String
    let country: String
}


