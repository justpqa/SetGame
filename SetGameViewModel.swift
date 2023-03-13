//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Anh Phan on 2/19/23.
//

import Foundation

class SetGame: ObservableObject {
    
    typealias Card = SetGameModel.SetCard
    
    private static let color = ["pink", "green", "orange"]
    private static let shape = ["Circle", "Square", "Triangle"]
    private static let numShape = ["1","2", "3"]
    
    @Published private var theModel = SetGameModel(shapelist: shape, colorlist: color, numlist: numShape)
    
    var cards: Array<Card> {
        return theModel.cards
    }
    
    var lose: Bool? {
        return theModel.lose
    }
    
    var win: Bool? {
        return theModel.win
    }
    
    var score: Int {
        return theModel.score
    }
    
    func choose(_ card: Card) {
        //objectWillChange.send() // send to the world that the object will change
        theModel.choose(card)
    }

}
