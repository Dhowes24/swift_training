//
//  EditCards.swift
//  Flashzilla
//
//  Created by Derek Howes on 5/20/22.
//

import SwiftUI

struct EditCards: View {
    @Binding var cards: [Card]
    @Environment(\.dismiss) var dismiss
    
    @State private var prompt = ""
    @State private var answer = ""
    
    @State private var isShowingAddScreen = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Button("Dismiss") {
                        saveData()
                        dismiss()
                    }
                    Spacer()
                    Button("Add Card") {
                        isShowingAddScreen = true
                    }
                }
                List{
                    ForEach(cards, id: \.self) { card in
                        Text(card.prompt)
                            .swipeActions {
                                Button {
                                    if let index = cards.firstIndex(of: card) {
                                        cards.remove(at: index)
                                    }
                                } label: {
                                    Label("Remove Card", systemImage: "trash.fill")
                                }
                                .tint(.red)
                            }
                    }
                }
            }
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $isShowingAddScreen) {
            NavigationView{
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.white)
                            .shadow(radius: 10)
                        
                        VStack {
                            TextField("Prompt", text: $prompt)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            TextField("Answer", text: $answer)
                                .font(.title)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(width: 450, height: 250)
                }.toolbar {
                    Button("Save") {
                        isShowingAddScreen = false
                        let card = Card(prompt: prompt, answer: answer)
                        cards.append(card)
                        saveData()
                        prompt = ""
                        answer = ""
                    }.padding()
                }
            }
            
        }
        
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
     }
}

