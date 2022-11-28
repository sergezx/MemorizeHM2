//
//  EmojiMemoryGame .swift
//  Memorize
//
//  Created by Sergey on 21.11.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    static let emojis = ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"]
    
    enum GameTheme {
        case vehicle
        case smiles
        case animals
        
        var emojis: [String] {
            switch self {
            case .vehicle: return ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"]
            case .smiles: return ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"]
            case .animals: return ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"]
            }
        }
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intent(s)
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
