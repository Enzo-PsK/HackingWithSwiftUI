//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Enzo Borges on 30/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var round = 1
    
    var body: some View {
        ZStack {
            RadialGradient( stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color:Color(red: 0.76, green: 0.15,blue: 0.26), location: 0.3)]
                            , center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .customTitleStyle()
                VStack (spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(score)")
                }
                .alert("Game Over", isPresented: $showingGameOver){
                    Button("New Game", action: resetGame)
                }message :{
                    Text("That's it! Your final score is: \(score)")
                }
                Spacer()
                Spacer()
                Text("Round: \(round)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }.padding(20)
        }
        
    }
    func resetGame(){
        score = 0
        round = 0
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! This flag is from \(countries[number])"
        }
        showingScore = true
        if(round == 8){
            showingGameOver = true
            return
        }
    }
    func askQuestion() {
        round += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct FlagImage : View{
    var imageName: String
    var body: some View{
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct customTitleModifier : ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.white)
    }
}
extension View{
    func customTitleStyle() -> some View{
        modifier(customTitleModifier())
    }
}

#Preview {
    ContentView()
}
