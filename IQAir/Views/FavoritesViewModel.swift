//
//  FavoritesViewModel.swift
//  IQAir
//
//  Created by Akhil Motiramani on 9/16/23.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        List {
            ForEach(favoritesViewModel.favorites) { favorite in
                Text("\(favorite.name), \(favorite.city), \(favorite.state), \(favorite.country)")
            }
        }
        .navigationBarTitle("Favorites")
    }
}

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteLocation] = []

    func addFavorite(location: FavoriteLocation) {
        favorites.append(location)
    }

    func removeFavorite(location: FavoriteLocation) {
        if let index = favorites.firstIndex(where: { $0.id == location.id }) {
            favorites.remove(at: index)
        }
    }
}

