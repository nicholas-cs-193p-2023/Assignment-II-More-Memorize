//
//  MemoryGame.swift
//  Memorize 2
//
//  Created by Nicholas Alba on 7/22/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var seenCards: Set<String> = [] { 
        didSet {
            print("Seen Cards: \(seenCards)")
        }
    }
    var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            let leftCard = Card(content: content, id: "\(pairIndex + 1)a")
            let rightCard = Card(content: content, id: "\(pairIndex + 1)b")
            cards += [leftCard, rightCard]
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyOnceFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) else { return }
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyOnceFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    var scoreDecrement = 0
                    if seenCards.contains(cards[chosenIndex].id) {
                        scoreDecrement += 1
                    }
                    if seenCards.contains(cards[potentialMatchIndex].id) {
                        scoreDecrement += 1
                    }
                    score -= scoreDecrement
                    seenCards.insert(cards[chosenIndex].id)
                    seenCards.insert(cards[potentialMatchIndex].id)
                }
            } else {
                indexOfTheOneAndOnlyOnceFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        // print(cards)
    }
    
    struct Card: CustomStringConvertible, Equatable, Identifiable {
        // Not needed. :)
        // static func == (lhs: Card, rhs: Card) -> Bool {
        //     return lhs.isFaceUp == rhs.isFaceUp &&
        //     lhs.isMatched == rhs.isMatched &&
        //     lhs.content == rhs.content
        // }
        
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
        var description: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
