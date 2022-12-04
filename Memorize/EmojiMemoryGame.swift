//
//  EmojiMemoryGame .swift
//  Memorize
//
//  Created by Sergey on 21.11.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    enum ThemeColors: String {
        case red
        case gold
        case limeGreen
        case deepPink
        case mediumVioletRed
        case orangeRed
        case darkMagenta
        case turquoise

        var create: Int {
           switch self {
           case .red:
               return 0xFF0000
           case .gold:
               return 0xFFD700
           case .limeGreen:
               return 0x008000
           case .deepPink:
               return 0xFF1493
           case .mediumVioletRed:
               return 0xC71585
           case .orangeRed:
               return 0xFF4500
           case .darkMagenta:
               return 0x8B008B
           case .turquoise:
               return 0x40E0D0
          }
        }
      }

    let themes = [
        Theme(
            name: "Vehicle",
            emojis: ["👻", "✈️", "🗿", "🚀", "🚅", "🛫", "🚔", "🏍", "⛱", "🚌", "🛺", "🛞", "🚲", "🚠", "🚟", "🚂", "🚇", "🚊", "⛵️", "🚁", "🛸", "🛳", "🏎"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.red.create
        ),
        Theme(
            name: "Faces",
            emojis: ["😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.gold.create
        ),
        Theme(
            name: "Animals",
            emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.limeGreen.create
        ),
        Theme(
            name: "Halloween",
            emojis: ["😈", "👿", "👻", "💀", "☠️", "👽", "🎃", "👀", "🕷", "🥸", "😱", "😤", "🙀", "🧛", "🕸", "🦖", "🦍", "🌚"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.deepPink.create
        ),
        Theme(
            name: "Flags",
            emojis: ["🏴‍☠️", "🏴‍☠️", "🏁", "🚩", "🇦🇿", "🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇺", "🇦🇹", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇮", "🇦🇴", "🇦🇩", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇮🇴", "🇦🇫", "🇧🇸", "🇧🇩", "🇧🇧", "🇧🇭", "🇧🇾", "🇧🇿", "🇧🇪", "🇧🇲", "🇧🇬", "🇧🇴", "🇧🇶", "🇧🇦", "🇧🇼", "🇧🇷", "🇧🇯"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.mediumVioletRed.create
        ),
        Theme(
            name: "Food",
            emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🫑", "🌶", "🌽", "🥕", "🫒", "🧄", "🧅", "🥔", "🥐", "🍠", "🥯", "🍞", "🥖", "🥨", "🧀", "🥚", "🍳", "🧈", "🥞", "🧇", "🥓", "🥩"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.orangeRed.create
        ),
        Theme(
            name: "Places",
            emojis: ["🗿", "🗽", "🗼", "🏰", "🏯", "🏟", "🎡", "🎢", "🎠", "⛲️", "🏖", "🏝", "🏜", "🌋", "⛰", "🏔", "🗻", "🏕", "🛖", "⛺️", "🗺", "🏞", "🌅", "🌄", "🌁"],
            numberOfCardPairs: 5,
                        colorCode: ThemeColors.turquoise.create
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
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame()->Void {
        currentTheme = themes.randomElement()!
        let emojis = currentTheme.emojis.shuffled()
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme, emojis: emojis)
    }
        
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfCardPairs: Int
        var color: Color
        
        init(name: String, emojis: [String], numberOfCardPairs: Int, colorCode: Int ) {
            self.name = name
            self.emojis = emojis
            self.numberOfCardPairs = min(numberOfCardPairs, emojis.count)
            self.color = colorFromHex(hex: colorCode )
        }
    }
    private static func colorFromHex(hex: Int) -> Color {
        Color(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }

}
