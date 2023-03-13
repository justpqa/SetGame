//
//  ContentView.swift
//  SetGame
//
//  Created by Anh Phan on 2/15/23.
//
import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGame
    
    var body: some View {
        VStack {
            Text("Welcome to Set Game!")
            Text("Your score: " + String(viewModel.score))
            HStack {
                Text("No more set can be formed. You lose!").opacity(noti1(viewModel.lose))
                Text("You win!").opacity(noti2(viewModel.win))

            }
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card) // can make this a viewBuilder to make it either opacity 0 or 1
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .padding(.horizontal)
        .foregroundColor(.purple)
    }
    
    private func noti1(_ bool1: Bool?) -> Double {
        if bool1! {
            return 1
        }
        return 0
    }
    
    private func noti2(_ bool2: Bool?) -> Double {
        if bool2! {
            return 1
        }
        return 0
    }
    
}


struct CardView: View {
    let shape1 = Circle()
    let shape2 = Square()
    let shape3 = Triangle()
    /*
    var col: String
    var shape: String
    var numShape: String
    @State var chosen = false
    */
    let card: SetGame.Card
    // @State var chosen = false
    
    private func convertColor(s: String) -> Color {
        if s == "pink" {
            return Color.pink
        } else if s == "green" {
            return Color.green
        } else {
            return Color.orange
        }
    }
    
    // make this one allow for either border color or fill
    @ViewBuilder
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                cardShape.fill().foregroundColor(.white)
                cardShape.stroke(lineWidth: 3)
                if card.shape == "Circle" {
                    VStack (alignment: .center) { ForEach(0..<Int(card.num)!, id: \.self)
                        { _ in shape1.padding(5).opacity(0.5).foregroundColor(convertColor(s: card.color))}
                    }
                } else if card.shape == "Square" {
                    VStack (alignment: .center) { ForEach(0..<Int(card.num)!, id: \.self)
                        { _ in shape2.padding(5).opacity(0.5).foregroundColor(convertColor(s: card.color))}
                    }
                } else {
                    VStack (alignment: .center) { ForEach(0..<Int(card.num)!, id: \.self)
                        { _ in shape3.padding(5).opacity(0.5).foregroundColor(convertColor(s: card.color))}
                    }
                }
            } else {
                cardShape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGame())
    }
}
