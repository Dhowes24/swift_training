//
//  CardView.swift
//  Flashzilla
//
//  Created by Derek Howes on 5/20/22.
//

import SwiftUI

struct CardView: View {
    var card: Card
    @Binding var gotCorrect: Bool
    var removal: (() -> Void)? = nil
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @State private var fillColor = Color.white
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
            
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(fillColor)
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    if offset.width > 10 {
                        fillColor = Color.green
                    } else if offset.width < -10 {
                        fillColor = Color.red
                    } else {
                        fillColor = Color.white
                    }
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            gotCorrect = true
                            feedback.notificationOccurred(.success)
                        } else {
                            gotCorrect = false
                            feedback.notificationOccurred(.error)
                            offset = .zero
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}
