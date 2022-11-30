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
            color: ColorsOfTheme.Red.create
        ),
        Theme(
            name: "Smiles",
            emojis: ["😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘"],
            numberOfCardPairs: 5,
            color: ColorsOfTheme.Gold.create
        ),
        Theme(
            name: "Animals",
            emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊"],
            numberOfCardPairs: 5,
            color: ColorsOfTheme.LimeGreen.create
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
    
    var score: String
    {
        return String(model.score)
    }
        
    init() {
        let randomTheme = themes.randomElement()!
        let emojis = randomTheme.emojis.shuffled()
        
        self.model = Self.createMemoryGame(theme: randomTheme, emojis: emojis)
        self.currentTheme = randomTheme
    }
    
    // MARK: Intent(s)
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame ()->Void {
        currentTheme = themes.randomElement()!
        let emojis = currentTheme.emojis.shuffled()
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme, emojis: emojis)
    }
    
    enum ColorsOfTheme: String {
       case Red
       case Gold
       case LimeGreen

        var create: Int {
           switch self {
              case .Red:
                return 0xFF0000
            case .Gold:
                return 0xFFD700
            case .LimeGreen:
                return 0x008000
           }
        }
      }
    
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfCardPairs: Int
        var color: Color
        
        init (name: String, emojis: [String], numberOfCardPairs: Int, color: Int ) {
            self.name = name
            self.emojis = emojis
            self.numberOfCardPairs = min(numberOfCardPairs, emojis.count)
            self.color = colorFromHex(hex: color )
        }
    }
    static func colorFromHex(hex: Int) -> Color {
        return Color(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }

}
