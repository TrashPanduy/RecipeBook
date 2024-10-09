//
//  ContentView.swift
//  Recipe Book
//
//  Created by Michael Owen on 9/16/24.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        //Navigation Bar at bottom. liks to View with Img & Text being whats displayed as icons
        TabView{
            mainPage().tabItem(){
                Image(systemName: "book.circle.fill")
                Text("Recipes")
            }
            
            shoppingList().tabItem(){
                Image(systemName: "list.number")
                Text("Shopping List")
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
