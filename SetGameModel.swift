//
//  SetGame.swift
//  SetGame
//
//  Created by Anh Phan on 2/19/23.
//

import Foundation
import SwiftUI

struct SetGameModel {
    private(set) var cards: Array<SetCard>
    private(set) var lose: Bool? = nil
    private(set) var win: Bool? = nil
    // var score: Int = 0
    
    var score: Int = 0
    var firstIndex: Int? = nil
    var secondIndex: Int? = nil
    // its method
    mutating func choose(_ card: SetCard) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatch1 = firstIndex, let potentialMatch2 = secondIndex {
                cards[chosenIndex].isFaceUp = true
                if checkSet(cards[potentialMatch1], cards[potentialMatch2], cards[chosenIndex]) {
                    cards[potentialMatch1].isMatched = true
                    cards[potentialMatch2].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 1
                }
                firstIndex = nil
                secondIndex = nil
                let notMatched = cards.filter({$0.isMatched == false})
                if !Continue(c: notMatched) {
                    lose = true
                }
                if score == 9 {
                    win = true
                }
            } else if firstIndex != nil {
                secondIndex = chosenIndex
                cards[chosenIndex].isFaceUp = true
            } else {
                for inx in cards.indices {
                    cards[inx].isFaceUp = false
                }
                firstIndex = chosenIndex
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // Need a function to check if the remaining cards can make at least a set
    private func Continue(c: Array<SetCard>) -> Bool {
        for i1 in c.indices {
            for i2 in c.indices {
                for i3 in c.indices {
                    if checkSet(c[i1], c[i2], c[i3]) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    private func checkSet(_ card1: SetCard,_ card2: SetCard,_ card3: SetCard) -> Bool {
        // If any features has 2 cards with the same value and one card with different value => not a set
        let colorSet = Set([card1.shape, card2.shape, card3.shape])
        let shapeSet = Set([card1.color, card2.color, card3.color])
        let numSet = Set([card1.num, card2.num, card3.num])
        if (colorSet.count == 2) || (shapeSet.count == 2) || (numSet.count == 2) {
            return false
        } else {
            return true
        }
    }
    
    // how to set our card
    init(shapelist: [String], colorlist: [String], numlist:[String]) {
        cards = Array<SetCard>()
        let count = shapelist.count * colorlist.count * numlist.count
        let lstproperties = permutations([shapelist, colorlist, numlist])
        for inx in 0..<count {
            cards.append(SetCard(shape: lstproperties[inx][0], color: lstproperties[inx][1], num: lstproperties[inx][2], id: inx))
        }
        cards.shuffle()
    }
    
    private func permutations<T>(_ arrays: [[T]]) -> [[T]] {
        guard let first = arrays.first else { return [] }
        if arrays.count == 1 { return first.map { [$0] } }
        let rest = permutations(Array(arrays.dropFirst()))
        return first.flatMap { item in
            rest.map { [item] + $0 }
        }
    }
    
    struct SetCard: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        //var isSeen: Bool = false
        let shape: String
        let color: String
        let num: String
        let id: Int
    }
    
}
