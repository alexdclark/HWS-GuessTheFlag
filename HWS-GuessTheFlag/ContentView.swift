//
//  ContentView.swift
//  HWS-GuessTheFlag
//
//  Created by Alexander Clark on 11/11/21.
//

import SwiftUI

struct ContentView: View {
    
    //Setting up variables to store State
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    //Randomizing the correct answer of the 3 Flags
    @State private var correctAnswer = Int.random(in: 0...2)
    
    //Storing correct countries in a shuffled array
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var body: some View {
        
        //Declaring a Z Stack for use as the whole view
        ZStack{
            
            //Defining a Radial Gradient that ignore the safe area
            RadialGradient(stops: [
                //Setting up custom colors
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                //Setting center of gradient as top of screen
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            
            //Setting up a VStack for Instructions and Flags
            VStack{
                //Setting up a VStack with 15 Spacing for instructions on how to play the game
                VStack(spacing: 15){
                    //Printing instructions for the game
                    Text("Tap the flag of").foregroundColor(.black).font(.subheadline.weight(.heavy))
                    //Printing the country that needs to be guessed
                    Text(countries[correctAnswer]).foregroundColor(.black).font(.largeTitle.weight(.semibold))
                }
                
                //For each random print the flag!
                ForEach(0..<3){ number in Button {
                    flagTapped(number)
                } label: {
                    //Print Image for each country
                    Image(countries[number])
                        .renderingMode(.original)
                    //Put them in a pill shape
                        .clipShape(Capsule())
                    //Add Shadow
                        .shadow(radius:5)
                    //And Padding
                        .padding()
                }
                    
                }
                
                //Definding Frame with Max Width of screen
            }.frame(maxWidth: .infinity)
            //Setting Vertical Padding of 20
                .padding(.vertical, 20)
            //Setting tranparent background
                .background(.regularMaterial)
            //Clip Shape with Corner Radius of 20
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
            //Creating an alert that is shown when showingScore is true
        }.alert(scoreTitle, isPresented: $showingScore) {
            //Creating Button to continue on click trigger askQuestion Function
            Button("Continue", action: askQuestion)
            //Put message on alert with Score passing score into string
        } message:{
            Text("Your score is \(score)" )
        }
    }
    
    //Creating function for when Flag is tapped
    func flagTapped(_ number: Int){
        
        //If Score is 8 or -8 the round is over print Round is over and call Reset function to reset Score
        if (score % 8 == 0 && score != 0){
            scoreTitle = "The round is over"
            reset()
        }
        
        //If correct Flag is selected increment score by 1 and print message
        else if number == correctAnswer {
            scoreTitle = "Correct that flag is \(countries[number])"
            score+=1
        }
        
        //Else they selected the incorrect Flag. Correct them and deduct from score.
        else{
            scoreTitle = "Wrong that flag is \(countries[number])"
            score-=1
        }
        
        //Set ShowingScore to True to cause Alert to appear
        showingScore = true
        
    }
    
    //Creating function for Asking a Question
    func askQuestion(){
        //Shuffle Country Array
        countries.shuffle()
        //Suffle correctAnswer
        correctAnswer = Int.random(in: 0...2)
    }
    
    //Creating function for Reseting Score to 0
    func reset(){
        score = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
