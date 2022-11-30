//
//  ContentView.swift
//  Memorize
//
//  Created by Sergey on 17.11.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach (viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                }
                HStack{
                    Text(viewModel.score)
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                .font(.largeTitle)
            }
            .foregroundColor(viewModel.currentTheme.color)
            .padding(.horizontal)
            .navigationTitle(viewModel.currentTheme.name)
            .toolbar {
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
