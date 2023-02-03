//
//  DeckUtils.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation

class DeckUtils : ObservableObject {
    @Published var reshuffle : ShuffleModel? = nil
    

    func getShuffle(completion: @escaping (ShuffleModel) -> Void) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else {return}
    }
    
    func getReshuffle(deckId: String, completion: @escaping (ShuffleModel) -> ()) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deckId)/shuffle/") else {
            print("nao deu derto")
            return
        }
        
        apiCallJson(url: url, object: ShuffleModel.self) { deckModel in
            self.reshuffle = deckModel as ShuffleModel
            completion(self.reshuffle ?? ShuffleModel(success: false, deck_id: "", shuffled: false, remaining: 0))
        }
    }
    
    func drawCard(deckId: String, completion: @escaping (DrawModel) -> Void) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=2") else {return}
    }
    
    /**
     * Faz a chamada da API e a converte o JSON para o objeto, retornando o objeto deste tipo.
     * url: Passe a url da api nesse parâmetro.
     * object: Passe o modelo do tipo "Deck" que irá receber o JSON (no caso, ShuffleModel ou DrawModel)
     */
    private func apiCallJson<T:Deck>(url: URL, object: T.Type, completion: @escaping (T) -> ()) {
        // api call
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else { return }

            // convert to json
            do {
                let decodedDeck = try JSONDecoder().decode(object.self, from: data)
                
                DispatchQueue.main.async {
                    if object == ShuffleModel.self { completion(decodedDeck as T) }
                    else { print("draw aqui") }
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
