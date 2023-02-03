//
//  DeckUtils.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation

class DeckUtils : ObservableObject {
    /**
     * Faz a chamada da API e a converte o JSON para o objeto, retornando o objeto deste tipo.
     * url: Passe a url da api nesse parâmetro.
     * object: Passe o modelo do tipo "Deck" que irá receber o JSON (no caso, ShuffleModel ou DrawModel)
     */
    private func apiCallJson<T:Deck>(url: URL, object: T.Type) -> (any Deck)? {
        // api call
        var deckReturn: (any Deck)? = nil
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            // convert to json
            do {
                let decodedDeck = try JSONDecoder().decode(object.self, from: data)
                deckReturn = decodedDeck
            }
            catch {
                print(error)
            }
        }
        if deckReturn == nil { print("AVISO: o objeto solicitado para API está nulo, algo deu ruim. Confira o link certinho, e se está com o deck_id certinho também.") }
        
        return deckReturn ?? nil
    }
}
