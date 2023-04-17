//
//  ThankYouView.swift
//  LapseClone
//
//  Created by George Leadbeater on 17/04/2023.
//

import SwiftUI

struct ThankYouView: View {
    // MARK: - Properties
    
    @EnvironmentObject private var theme: Theme
    @State var scale: Double = 1
    @State var blurRadius: Double = 0
    @State var swaying = false
    
    // MARK: - UI Elements
    
    var body: some View {
        VStack {
            Text(L10n.dThankYouTitle)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, theme.spacing.extraLarge)
            Text(L10n.dThankYouDescription)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
            Spacer()
            Image(asset: Asset.Images.lapse)
                .frame(width: Constants.imageDimensions, height: Constants.imageDimensions)
                .blur(radius: blurRadius)
                .scaleEffect(scale)
                .rotationEffect(.degrees(swaying ? -Constants.swayFactor : Constants.swayFactor), anchor: swaying ? .bottomLeading : .bottomTrailing)
                .onAppear {
                    withAnimation(
                        Animation
                            .easeInOut(duration: Constants.animationDuration)
                            .repeatForever(autoreverses: true)
                    ) {
                        scale = Constants.scaleFactor
                        blurRadius = Constants.blurRadius
                        swaying.toggle()
                    }
                }
            Spacer()
        }
        .background(.black)
    }
}

// MARK: - PreviewProvider

struct ThankYouView_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouView()
            .environmentObject(Theme())
    }
}

// MARK: - Constants

extension ThankYouView {
    private struct Constants {
        static let imageDimensions: Double = 60
        static let scaleFactor: Double = 0.98
        static let swayFactor: Double = 2
        static let blurRadius: Double = 5
        static let animationDuration: Double = 2
    }
}
