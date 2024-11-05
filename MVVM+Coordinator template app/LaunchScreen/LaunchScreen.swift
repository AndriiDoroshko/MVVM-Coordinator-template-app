//
//  LaunchScreen.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            // Cloudy background image
            Image("clouds")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 20)
            
            // Content on top of the blurry background
            VStack {
                
            }
            .padding()
        }
    }
}
