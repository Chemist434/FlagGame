//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Only Daryan on 28/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Italy", "France", "UK", "Germany", "Estonia", "Nigeria", "Poland", "Spain", "Ireland", "Ukraine", "US"] .shuffled()
    @State private var correctAnswers = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = " "
    
    @State private var animiCount = 0.0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 1.0, green: 0.0, blue: 0.39), location: 0.3),
                .init(color: Color(red: 0.0, green: 0.0, blue: 0.0), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.black)
                
                VStack(spacing: 70){
                    VStack {
                        Text(" tap the flag of")
                            .font(.title.weight(.semibold))
                        Text(countries[correctAnswers])
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            withAnimation {
                                animiCount += 360
                            }
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 10)
                                .rotation3DEffect(.degrees(animiCount),axis: (x: 0, y: 1, z: 0))
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                
                Spacer()
                Spacer()
                
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("You score id ???")
        }
    }
    func flagTapped(_ number : Int){
        if number == correctAnswers{
            scoreTitle = "Correct"
        } else{
            scoreTitle = "Worng"
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswers = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// .frame(maxWidth: .infinity, maxHeight: .infinity)
