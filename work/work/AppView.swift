//
//  AppView.swift
//  work
//
//  Created by ii on 08.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var inter = Interstitial()
   
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                  Image(systemName: "list.dash")
                    .font(.title)
                    Text("Exercices")
            }
                UserInput()
                .tabItem{
                    Image(systemName: "square.and.pencil")
                               .font(.title)
                               Text("Measures")
            }
            BarGraphView()
            .tabItem{
                Image(systemName: "calendar")
                    .font(.title)
                    Text("Charts")
                
                
            }
            MoreView()
                .tabItem{
                Image(systemName: "square.grid.4x3.fill")
                            .font(.title)
                Text("More")
            }
            
            
            
        }
    
    
    
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
