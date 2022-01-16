//
//  ContentView.swift
//  insrt
//
//  Created by Ritesh Kanchi on 5/13/21.
//

import SwiftUI

struct ContentView: View {
    @State private var character: String = "👏"
    @State private var text: String =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    @FocusState private var stopTyping: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("Character")) {
                        TextField("add characters", text: $character)
                            .focused($stopTyping)
                        
                    }
                    Section(header: Text("Text")) {
                        TextEditor(text: $text)
                            .focused($stopTyping)
                        
                        
                    }
                    
                    Button(action: {
                        if let string = UIPasteboard.general.string {
                            text = string
                        }
                    }) {
                        Label("Paste", systemImage: "doc.on.clipboard")
                    }
                    
                    Button(action: {
                        text = ""
                    }) {
                        Label("Delete", systemImage: "delete.right")
                    }
                    
                    Section(header: Text("Result")) {
                        TextEditor(text: text != "" ? .constant("\(character) " + text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: " \(character) ") + " \(character)") : .constant(""))
                            .focused($stopTyping)
                        
                    }
                    Button(action: {
                        UIPasteboard.general.string = "\(character) " + text.replacingOccurrences(of: " ", with: " \(character) ") + " \(character)"
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("\(character) insrt \(character)")
                .navigationBarItems(trailing: Button(action: {
                    actionSheet(text: text != "" ? "\(character) " + text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: " \(character) ") + " \(character)" : "")
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                })
            }
            VStack {
                if stopTyping {
                    Button(action: {
                        withAnimation {
                            stopTyping = false
                        }
                        
                    }) {
                        Text("Cancel Typing")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
                
                
                Spacer()
            }
        }
    }
    func actionSheet(text: String) {
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
