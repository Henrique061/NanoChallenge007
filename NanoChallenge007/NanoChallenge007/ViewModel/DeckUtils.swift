//
//  DeckUtils.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation

class DeckUtils : ObservableObject {
    @Published var reshuffle : ShuffleModel? = nil
    
    func getReshuffle(completion: @escaping (ShuffleModel) -> ()) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/lvqblg4m6zc8/shuffle/") else {
            print("nao deu derto")
            return
        }
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            let reshuffle = try! JSONDecoder().decode(ShuffleModel.self, from: data!)
            print(reshuffle)
            DispatchQueue.main.async {
                completion(reshuffle)
            }
        }.resume()
    }
}
