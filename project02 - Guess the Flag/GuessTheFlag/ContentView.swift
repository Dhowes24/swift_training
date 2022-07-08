//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Derek Howes on 4/21/22.
//

import SwiftUI


struct rotateAnimation: ViewModifier {
    let rotateAmount: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(rotateAmount), axis: (x: 0, y: 0, z: 1))
    }
}

extension AnyTransition {
    static var rotate: AnyTransition {
        .modifier(active: rotateAnimation(rotateAmount: 360.0), identity: rotateAnimation(rotateAmount: 0))
    }
}

struct opacityAnimation: ViewModifier {
    let opacityAmount: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(opacityAmount)
            .scaleEffect(0.5)
    }
}

extension AnyTransition {
    static var makeOpac: AnyTransition {
        .modifier(active: opacityAnimation(opacityAmount: 0.25), identity: opacityAnimation(opacityAmount: 1))
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func TitleStyle() -> some View {
        modifier(ProminentTitle())
    }
}

extension Image {
    func FlagStyle() -> some View {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}


struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var guessedIndex = -1
    @State private var score = 0
    @State private var gameRound = 0
    
    
    @State private var selectionAnimation = false
    @State private var rotationAmount = 0
//    @State private var opacityAmount = 1.0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.green]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 60){
                Spacer()
                VStack(spacing: 30) {
                    Text("Tap the flag of \(countries[correctAnswer])")
                        .TitleStyle()
                    Text("\(selectionAnimation.description)")
                }
                ForEach(0..<3) { number in
                    
                    Button {
                        gameRound += 1
                        withAnimation {
                            guessedIndex = number

                            selectionAnimation.toggle()
                        }
                        flagTapped(number)
                    } label: {
                        if selectionAnimation && number == guessedIndex{
                            Image(countries[number])
                                .FlagStyle()
                                .transition(.rotate)
                            
                        }
                         else if number != guessedIndex{
                            Image(countries[number])
                                .FlagStyle()
                                .transition(.makeOpac)
                        }
//                        if !selectionAnimation {
//                            Image(countries[number])
//                                .FlagStyle()
//                        }
                        
                        
                    }
                    
                    
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                Text("Round: \(gameRound)")
                    .foregroundColor(.white)
                Spacer()
            }
            
        } .alert(isPresented: $showingScore, content: {
            getAlert()
        } )
        
    }
    
    func getAlert() -> Alert {
        if gameRound < 4 {
            return Alert(
                title: Text(scoreTitle),
                message: Text("That is \(countries[guessedIndex])'s flag"),
                dismissButton: .default(Text("Continue"), action: askQuestion)
            )
        } else {
            return Alert(
                title: Text("Finished!"),
                message: Text("You've Finished the Game!\n Final score of \(String(format: "%.2f", 100 * (Double(score) / Double(gameRound))))%"),
                dismissButton: .default(Text("Play Again"), action: {
                    score = 0
                    gameRound = 0
                    askQuestion()
                })
            )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Incorrect"
        }
        showingScore = true
    }
    
    func askQuestion() {
        selectionAnimation.toggle()
        guessedIndex = -1
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
