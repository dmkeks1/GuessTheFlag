//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dominik Zehe on 09.06.24.
//

import SwiftUI

struct ContentView: View {
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"] // made that constant so that we can reset the array to this here if we start a new game
    @State private var countries = allCountries.shuffled() // shuffles the list of arrays
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var roundsPlayed = 0
    @State private var round8Alert = false
    @State private var correctAnswer = Int.random(in: 0...2) //randomizes which of the flags the correct answer will be
    var body: some View {
        
        
        ZStack{
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea() // BACKGROUND
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number]) //shows image of the asked flag - image assignment comes from number in the array - f.e. number 2 in the array can be france, so the image "France" will be shown (image) needs to have the name set to france then
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) { //zeigt punktestand nach einer frage - isPresented -> zeige alert an WENN die variable auf true gesetzt wird
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Game over!", isPresented: $round8Alert) { //zeigt endergebnis an - isPresented -> zeige alert an WENN die variable auf true gesetzt wird
            Button("Start Again", action: newGame)
        } message: {
            Text("Your final score was \(score).")
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
        } else {
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
            
        }
        
        
        if roundsPlayed == 8 {
            round8Alert = true //zeigt endergebnis an
        } else {
            showingScore = true //zeigt punktestand nach einer frage
        }

        
    }
    func askQuestion() {
        countries.remove(at: correctAnswer) // remove the correct answer from the pool
        countries.shuffle() //shuffles array again
        correctAnswer = Int.random(in: 0...2)
        roundsPlayed += 1
        
    }
    
    func newGame() {
        roundsPlayed = 0
        score = 0
        countries = Self.allCountries // resets array to all flags
        askQuestion()
    }
}

#Preview {
    ContentView()
}

