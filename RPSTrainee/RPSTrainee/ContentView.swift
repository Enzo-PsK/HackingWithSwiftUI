//
//  ContentView.swift
//  RPSTrainee
//
//  Created by Enzo Borges on 04/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGameover = false
    @State private var winResult = Bool.random()
    @State private var currentMove = Int.random(in: 0...2)
    @State private var playerMove = ""
    @State private var score = 0
    @State private var round = 1
    @State private var seconds = 0
    @State private var decimalSeconds = 0
    @State private var decimalSecondsTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    let moves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors","Rock"]
    let results = ["Win","Lose"]
    
    var body: some View {
        VStack(spacing:100) {
            Spacer()
            VStack(spacing:20){
                Text("Round: \(round)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("You need to \(winResult ? "Win":"Lose")")
                    .font(Font.title)
                Image("\(moves[currentMove])")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 80, height: 80)
            }
            HStack(spacing:20){
                ForEach(moves, id: \.self){ move in
                    Button(){
                        chooseMove(move)
                    }
                label: {
                    Image("\(move)")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 80, height: 80)
                        .border(.black)
                }
                    
                }}
            Spacer()
            VStack{
                Text("\(seconds).\(decimalSeconds) s")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .onReceive(decimalSecondsTimer, perform: { _ in
                        if(decimalSeconds == 9){
                            decimalSeconds = 0
                            seconds += 1
                            if (seconds == 200){
                                gameOver()
                            }
                        }else{
                            decimalSeconds += 1
                        }
                        
                    })
                Text("Score: \(score)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            .alert("Game Over",isPresented: $showingGameover){
                Button("Play Again"){
                    resetGame()
                }
            } message: {
                Text("""
                        Final Score: \(score)
                        Time: \(seconds).\(decimalSeconds)s
                    """)
            }
            Spacer()
        }
        .navigationTitle("Eu")
        .padding()
    }
    
    func gameOver(){
        decimalSecondsTimer.upstream.connect().cancel()
        showingGameover = true
    }
    
    func resetGame(){
        score = 0
        round = 0
        seconds = 0
        decimalSeconds = 0
        decimalSecondsTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
    
    func newRound(){
        let oldCurrentMove = currentMove
        let oldWinResult = winResult
        while(currentMove == oldCurrentMove){
            currentMove = Int.random(in: 0...2)
        }
        while(winResult == oldWinResult){
            winResult = Bool.random()
        }
        round += 1
    }
    
    func chooseMove(_ move: String){
        playerMove = move
        let scored = didPlayerScored(pcMove: moves[currentMove], playerMove: move)
        if(scored){
            score += 1
        }
        if(round < 10){
            newRound()
        } else{
           gameOver()
        }
        
    }
    
    func didPlayerScored(pcMove: String, playerMove:String) -> Bool{
        let pcMoveIndex = moves.firstIndex(of:pcMove)
        let playerMoveIndex = winningMoves.firstIndex(of:playerMove)
        let didPlayerWin = pcMoveIndex == playerMoveIndex
        
        //Tied game
        if(pcMove == playerMove) {return false}
        
        //player scores
        if(didPlayerWin == winResult){
            return true
        }
        else{
            return false
        }
    }
    
    
}

#Preview {
    ContentView()
}
