//
//  ContentView.swift
//  2linhasdecodigo
//
//  Created by Tiago Pinheiro on 07/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                CustomTextInputField(searchText: $searchText, isSearching: $isSearching)
                
                ForEach((0..<20).filter({ "\($0)".contains(self.searchText) || searchText.isEmpty }), id: \.self) { num in
                    
                    HStack {
                        Text("\(num)")
                        Spacer()
                    }.padding()
                    Divider()
                        .background(Color(.systemGray3))
                        .padding(.leading)
                }
            }
            .navigationTitle("2 Linhas de Código")
        }
    }
}

struct CustomTextInputField: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Pesquisar aqui", text: $searchText)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray4))
            .cornerRadius(6.0)
            .padding(.horizontal)
            .onTapGesture(perform: {
                self.isSearching = true
            })
            .overlay (
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if (self.isSearching) {
                        Button(action: { self.searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            
            if (self.isSearching) {
                Button(action: {
                    self.searchText = ""
                    self.isSearching = false
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                }).transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .colorScheme(.dark)
    }
}
