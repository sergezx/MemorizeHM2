//
//  MemoryGame  .swift
//  Memorize
//
//  Created by Sergey on 21.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score: Int

     
    mutating func choose (_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched
        {
            if let potentioalMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentioalMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentioalMatchIndex].isMatched = true
                    score+=2
                } else {
                    if cards[choosenIndex].isAlreadyBeenSeen {
                        score-=1
                    }
                    if cards[potentioalMatchIndex].isAlreadyBeenSeen {
                        score-=1
                    }
                    cards[choosenIndex].isAlreadyBeenSeen = true
                    cards[potentioalMatchIndex].isAlreadyBeenSeen = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            cards[choosenIndex].isFaceUp.toggle()

        }
//        print("\(cards)")
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numBerOfPairsCars x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
//            print("\(content)")
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp : Bool = false
        var isMatched : Bool = false
        var content : CardContent
        var isAlreadyBeenSeen : Bool = false
        var id: Int
    }
}
