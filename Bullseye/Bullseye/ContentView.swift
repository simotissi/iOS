//
//  ContentView.swift
//  Bullseye
//
//  Created by Simone Tissi on 14/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var valueSlider = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let ourAccentColor = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    
    
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Helvetica" , size: 18))
        }
    }
    
    struct ValueStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold" , size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    struct ButtonLargeTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Helvetica" , size: 18))
        }
    }
    struct ButtonSmallTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Helvetica" , size: 12))
        }
    }
    
    var body: some View{
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            
            // SLIDER row
            HStack{
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $valueSlider, in: 1...100).accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible){() ->
                Alert in
                return Alert(title: Text(alertTitle()), message: Text("This slider value is \(sliderValueRounded()).\n" + "You scored \(pointsForCurrentRound()) this round."),
                             dismissButton: .default(Text("Awesome")){
                                self.score = self.score + self.pointsForCurrentRound()
                                self.target = Int.random(in: 1...100)
                                self.round += 1
                            })
            }
            .background(Image("Button").modifier(Shadow()))
            Spacer()
            // Score row
            HStack{
                Button(action: {
                    self.resetGame()
                }){
                    HStack{
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button").modifier(Shadow()))
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                    
                }
                .background(Image("Button").modifier(Shadow()))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(ourAccentColor)
        .navigationBarTitle("BullsEye")
    }
    func resetGame(){
        score = 0
        round = 1
        valueSlider = 50.0
        target = Int.random(in: 1...100)
    }
    func amountOff() -> Int {
        return abs(target-sliderValueRounded())
    }
    func sliderValueRounded() -> Int {
        return Int(valueSlider.rounded())
    }
    func pointsForCurrentRound() -> Int {
        let diff = amountOff()
        if diff == 0 {
            return (100-amountOff()) + 100
        }else if diff == 1 {
            return (100-amountOff()) + 50
        } else{
            return 100-amountOff()
        }
    }
    
    func alertTitle() -> String{
        let diff = amountOff()
        let title: String
        if diff == 0{
            title = "Perfect!"
        }else if diff<=5 {
            title = "You almost made it!"
        }else{
            title = "Try again, loser!"
        }
        return title
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
