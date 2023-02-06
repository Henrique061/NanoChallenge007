//
//  DeckUtils.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation

class DeckUtils : ObservableObject {
    @Published var reshuffle : ShuffleModel? = nil
    @Published var draw: DrawModel? = nil
    
    /**
     * Faz a chamada API que retorna um deck totalmente novo e embaralhado.
     */
    func getShuffle(completion: @escaping (ShuffleModel) -> Void) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else {return}
        
        apiCallJson(url: url, object: ShuffleModel.self) { deckModel in
            self.reshuffle = deckModel as ShuffleModel
            completion(self.reshuffle ?? ShuffleModel(success: false, deck_id: "", shuffled: false, remaining: 0))
        }
    }
    
    /**
     * Faz a chamada API que reembaralha um deck já existente (deve passar o id do deck)
     */
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
    
    /**
     * Faz a chamada API para puxar uma quantidade de cartas de um deck. Deve passar o id do deck e a quantidade de cartas a ser puxada
     */
    func drawCard(deckId: String, drawCount: Int, completion: @escaping (DrawModel) -> Void) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=\(drawCount)") else {return}
        
        apiCallJson(url: url, object: DrawModel.self) { deckModel in
            self.draw = deckModel as DrawModel
            completion(self.draw ?? DrawModel(success: false, deck_id: "", cards: [], remaining: 0))
        }
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
                    completion(decodedDeck as T)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
