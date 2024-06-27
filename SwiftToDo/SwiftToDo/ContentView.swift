//
//  ContentView.swift
//  SwiftToDo
//
//  Created by Doğukan Ürker on 27.06.2024.
//

import SwiftUI

// The main view of the application
struct ContentView: View {

    // State variables to manage input text and the list of to-dos
    @State private var inputText: String = ""
    @State private var displayTodo: [String] = UserDefaults.standard.stringArray(forKey: "displayTodo") ?? []
    
    var body: some View {
        VStack { // Arranges elements vertically
            
            HStack { // Arranges elements horizontally
                // Text field for entering new to-dos
                TextField("New todo", text: $inputText)
                    .padding() // Adds padding around the text field
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Applies a rounded border style
                
                // Button to add a new to-do
                Button(action: {
                    // Adds the input text to the to-do list if it's not empty
                    if !inputText.isEmpty {
                        displayTodo.append(inputText)
                        inputText = "" // Clears the input text field
                        saveDisplayTexts() // Saves the updated to-do list
                    }
                }) {
                    // Displays a plus icon
                    Image(systemName: "plus")
                        .foregroundColor(.purple) // Sets the icon color to purple
                }
            }
            
            // List to display the to-dos
            List {
                // Iterates over the to-do list
                ForEach(displayTodo, id: \.self) { text in
                    HStack { // Arranges elements horizontally within each list item
                        Text(text) // Displays the to-do text
                            .padding() // Adds padding around the text
                        Spacer() // Adds space between the text and the button
                        // Button to mark a to-do as done
                        Button(action: {
                            // Removes the to-do from the list if found
                            if let index = displayTodo.firstIndex(of: text) {
                                displayTodo.remove(at: index)
                                saveDisplayTexts() // Saves the updated to-do list
                            }
                        }) {
                            // Displays a checkmark icon
                            Image(systemName: "checkmark")
                                .foregroundColor(.purple) // Sets the icon color to purple
                        }
                        .buttonStyle(BorderlessButtonStyle()) // Makes the button style borderless
                    }
                }
            }
        }
        .padding() // Adds padding around the main VStack
    }
    
    // Saves the to-do list to UserDefaults
    private func saveDisplayTexts() {
        UserDefaults.standard.set(displayTodo, forKey: "displayTodo")
    }
}

// Preview provider for the ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
