//
//  EmojiMemoryGame.swift
//  Memorize 2
//
//  Created by Nicholas Alba on 7/22/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    init() {
        let randomTheme = EmojiMemoryGame.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(fromTheme: randomTheme)
        theme = randomTheme
    }
    
    @Published private(set) var theme: MemoryGameTheme<String>
    @Published private var model: MemoryGame<String>
    
    var score: Int {
        model.score
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    private static let themes = [
//        MemoryGameTheme(color: .orange, cardContents: ["🎃", "👻", "🕷️", "🕸️", "😈", "🙀", "☠️", "🧙", "💀", "😱", "🍭", "👹"], name: "Halloween", numberOfPairsOfCards: 8),
//        MemoryGameTheme(color: Color(hex: 0x7e121d), cardContents: ["🎅", "🧝", "🎄", "🎁", "🦌", "🍷", "☃️", "❄️", "🕯️", "🍪", "⭐", "🎶" ], name: "Christmas", numberOfPairsOfCards: 8),
//        MemoryGameTheme(color: .blue, cardContents: ["🏳️‍🌈", "🏳️‍⚧️", "🇧🇹", "🇵🇸", "🇪🇬", "🇨🇳", "🇰🇵", "🇰🇷", "🇲🇽", "🇦🇲", "🇱🇦", "🇹🇭"], name: "Flags", numberOfPairsOfCards: 8),
//        MemoryGameTheme(color: .yellow, cardContents: ["😄", "🥰", "😎", "😛", "😳", "🙄", "🤠", "🥳", "🙃", "🧐", "😑", "🥱"], name: "Faces", numberOfPairsOfCards: 8),
//        MemoryGameTheme(color: .green, cardContents: ["🐙", "🐶", "🐸", "🦊", "🦑", "🦄", "🐼", "🦀", "🐋", "🐉", "🐊", "🦆", "🦈", "🦭", "🐷", "🐻", "🦒", "🐁"], name: "Animals", numberOfPairsOfCards: 12),
        MemoryGameTheme(color: Color(hex: 0xffbc002d), cardContents: ["日", "一", "大", "年", "中", "会", "人", "本", "月", "長", "国", "出", "上", "生", "東", "十", "三", "同", "手", "見", "市", "力", "米", "前", "合", "立", "京", "間", "体", "学", "目", "後", "新", "明", "心", "正", "言", "山", "定"], name: "Kanji", numberOfPairsOfCards: 20)
    ]
    
    
    private static func createMemoryGame(fromTheme theme: MemoryGameTheme<String>) -> MemoryGame<String> {
        assert(theme.numberOfPairsOfCards <= theme.cardContents.count)
        let cardContents = theme.cardContents.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            cardContents[pairIndex]
        }
    }
    
    private static func randomTheme() -> MemoryGameTheme<String> {
        let randomIndex = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        return EmojiMemoryGame.themes[randomIndex]
    }
    
    // MARK: Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let randomTheme = EmojiMemoryGame.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(fromTheme: randomTheme)
        theme = randomTheme
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: alpha
        )
    }
}
