//
//  MemorizeApp.swift
//  Memorize 2
//
//  Created by Nicholas Alba on 7/22/24.
//

import SwiftUI

@main
struct MemorizeGame: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
