//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/23/24.
//

import SwiftUI

struct EditCardsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var newPrompt: String = ""
    @State private var newAnswer: String = ""
    
    @State private var cards: [Card] = [Card]()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Save", action: addCard)
                }
                
                Section("Cards") {
                    ForEach(0..<cards.count, id: \.self) { cardIndex in
                        VStack(alignment: .leading) {
                            Text(cards[cardIndex].prompt)
                                .font(.headline)
                            Text(cards[cardIndex].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadCards)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func removeCard(at offset: IndexSet) {
        cards.remove(atOffsets: offset)
    }
    
    func loadCards() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveCards() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func addCard() {
        let trimmedPrompt: String = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer: String = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card: Card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveCards()
    }
}

#Preview {
    EditCardsView()
}
