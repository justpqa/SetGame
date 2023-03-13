//
//  SetGameApp.swift
//  SetGame
//
//  Created by Anh Phan on 2/15/23.
//

import SwiftUI

@main
struct MySetGameApp: App {
    private let game = SetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: game)
        }
    }
}
