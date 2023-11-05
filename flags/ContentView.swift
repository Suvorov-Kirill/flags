//
//  ContentView.swift
//  flags
//
//  Created by Кирилл Суворов on 04.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["US", "United Kingdom", "Canada", "Germany", "Russia", "Bangladesh", "Brazil", "Greece", "Argentina", "Sweden"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack{
                    Text("Choose flag:")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .font(.title)
                        .foregroundStyle(.white)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                         flagTapped(number)
                        showingScore = true
                    }){
                        Image(countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(.black))
                            .shadow(color: .black, radius: 2 )
                    }
                }
                Text("score: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }.alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitle), message: Text("Score: \(score)"), dismissButton: .default(Text("Next round")) {
                    askQuestion()
                })
            })
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2 )
    }
    
    func flagTapped (_ num: Int) {
        if num == correctAnswer {
            scoreTitle = "Correct answer!"
            score += 1
        }
        else {
            scoreTitle = "Wrong answer! This is \(countries[num]) flag"
            score -= 1
        }
    }
    
}



#Preview {
    ContentView()
}
