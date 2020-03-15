//
//  ContentView.swift
//  Bullseye
//
//  Created by Simone Tissi on 14/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible : Bool = false
    @State var whoIsVisible : Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to my first app!")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
                Button(action: {
                    print("Bottom pressed")
                    self.alertIsVisible = true
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
                }
                .alert(isPresented: $alertIsVisible){() ->
                    Alert in
                        return Alert(title: Text("Hello world"), message: Text("My First pop up!"), dismissButton: .default(Text("Awesome")))
                }
            }
            Button(action: {
                self.whoIsVisible = true
            }) {
                Text("Knock Knock!")
            }
            .alert(isPresented: $whoIsVisible){() ->
                Alert in
                    return Alert(title: Text("Who's there?"), message: Text("Stocazzo!"), dismissButton: .default(Text("Bye!")))
            }        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
