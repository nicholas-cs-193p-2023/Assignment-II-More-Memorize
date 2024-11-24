//
//  MemoryGameTheme.swift
//  Memorize 2
//
//  Created by Nicholas Alba on 7/23/24.
//

import Foundation
import SwiftUI

struct MemoryGameTheme<CardContent> where CardContent: Equatable {
    var color: Color
    var cardContents: [CardContent]
    var name: String
    var numberOfPairsOfCards: Int
}
