//
//  EmojiMemoryGame .swift
//  Memorize
//
//  Created by Sergey on 21.11.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    let themes = [
        Theme(
            name: "Vehicle",
            emojis: ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"],
            numberOfCardPairs: 5,
            color: "red"
        ),
        Theme(
            name: "Smiles",
            emojis: ["😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘"],
            numberOfCardPairs: 5,
            color: "yellow"
        ),
        Theme(
            name: "Animals",
            emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊"],
            numberOfCardPairs: 5,
            color: "green"
        ),
    ]
    
    static func createMemoryGame(theme: Theme, emojis: [String]) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published private(set) var currentTheme: Theme
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    init() {
        var randomTheme = themes.randomElement()!
        var emojis = randomTheme.emojis.shuffled()
        
        self.model = Self.createMemoryGame(theme: randomTheme, emojis: emojis)
        self.currentTheme = randomTheme
    }
    
    // MARK: Intent(s)
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame ()->Void {
        currentTheme = themes.randomElement()!
        var emojis = currentTheme.emojis.shuffled()
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme, emojis: emojis)
    }
    
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfCardPairs: Int
        var color: String
    }
}
