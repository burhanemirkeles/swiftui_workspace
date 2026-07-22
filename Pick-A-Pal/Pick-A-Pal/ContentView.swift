//
//  ContentView.swift
//  Pick-A-Pal
//
//  Created by Infonal on 22.07.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd: String = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    
    private var saveURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("names.json")
    }
    
    private func saveNames() {
        do {
            let data = try JSONEncoder().encode(names)
            try data.write(to: saveURL)
            print("Saved!")
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    private func loadNames() {
        do {
            let data = try Data(contentsOf: saveURL)
            names = try JSONDecoder().decode([String].self, from: data)
            print("Loaded!")
        } catch {
            print("Failed to load: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Pick a Pal")
            }
            .font(.title)
            .bold()
            
            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
           
            List {
                ForEach(names, id: \.description) { name in
                    Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack {
                Button("Save List") {
                    saveNames()
                }
                .disabled(names.isEmpty)
                .buttonStyle(.bordered)
                
                Button("Load Last List") {
                    loadNames()
                }
                .buttonStyle(.bordered)
            }
            
            
            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    nameToAdd = nameToAdd.trimmingCharacters(in: .whitespacesAndNewlines)

                    let isNameAlreadyExists = names.contains(nameToAdd)

                    if !nameToAdd.isEmpty, !isNameAlreadyExists {
                        names.append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            
            Divider()

            Toggle("Remove when picked", isOn: $shouldRemovePickedName)

            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    
                    if shouldRemovePickedName {
                        names.removeAll { name in
                            return (name == pickedName)
                        }
                    }
                } else {
                    pickedName = " "
                }
            } label: {
                Text("Pick a Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
        .onChange(of: names) {
            saveNames()
        }
    }
}
#Preview {
    ContentView()
}
