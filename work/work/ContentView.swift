//
//  ContentView.swift
//  work
//
//  Created by ii on 01.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {

    
    var body: some View {
      
        NavigationView{
            List{
                //section :was written to create the footer
                ForEach(bodyParts) {
                bodyPart in
               
                if(bodyPart.name=="Chest"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                  ContentRow(name: bodyPart.name)
            
              }
                }
                 else if(bodyPart.name=="Shoulders"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                            ContentRow(name: bodyPart.name)
                        }
                    }
                else if(bodyPart.name=="Arms"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                        ContentRow(name: bodyPart.name)
                    }
                }

                else if(bodyPart.name=="Back"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                                       ContentRow(name: bodyPart.name)
                                   }
                               }
                else if(bodyPart.name=="Abs"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                                           ContentRow(name: bodyPart.name)
                                       }
                                   }
                else if(bodyPart.name=="Legs"){
                    NavigationLink(destination : GeneralView(str :bodyPart.name)){
                                    ContentRow(name: bodyPart.name)
                    }
                               }
                else if(bodyPart.name=="Full Body"){
                    NavigationLink(destination : GeneralView(str: bodyPart.name)){
                                                      ContentRow(name: bodyPart.name)
                                                  }
                                              }
                
                
                }
            }.navigationBarTitle(Text("APEX Workout"), displayMode: .inline)
                        
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
