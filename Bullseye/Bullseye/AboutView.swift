//
//  AboutView.swift
//  Bullseye
//
//  Created by Simone Tissi on 16/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let bgColor = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct HeadingStyle : ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold" , size: 30))
                .padding([.top, .bottom], 20)
        }
    }
    
    struct TextViewStyle : ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold" , size: 16))
                .padding(.bottom, 20)
                .padding([.trailing, .leading], 60)
        }
    }
    
    var body: some View {
        Group{
            VStack{
                Text("🎯BullsEye🎯").modifier(HeadingStyle())
                Text("This is BullsEye, the game where you can win points and earn fame by dragging a slider.").modifier(TextViewStyle())
                Text("Place the slider as close as possible to the target. The closer you are, the more points you score.").modifier(TextViewStyle())
                Text("Enjoy!").modifier(TextViewStyle())
            }
            .navigationBarTitle("About BullsEye")
            .background(bgColor)
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
       AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
