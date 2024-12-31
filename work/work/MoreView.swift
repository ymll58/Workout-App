//
//  MoreView.swift
//  work
//
//  Created by ii on 10.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI







struct MoreView: View {
    
    
    
    
    @State var showingPopupA = false
    @State var showingPopupB = false
    @State var showingPopupC = false
    @State var showingPopupD = false
    @State var rating = UserDefaults.standard.integer(forKey: "Rate")
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    var inter = Interstitial()
    @State private var alertstate = false
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    
    var body: some View {
        
        
        
        VStack {
            
            HStack{
                Button(action: {
                    self.showingPopupA.toggle()
                })
                {                   Text("Rate Us").font(.system(size: 20))
                    .foregroundColor(.blue)
                    .bold()
                    
                    
                }.popover(isPresented: self.$showingPopupA) {
                    VStack{
                        Text("Did you like our App ?")
                        HStack {
                            if self.label.isEmpty == false {
                                Text(self.label)
                            }
                            ForEach(1..<self.maximumRating + 1) { number in
                                self.image(for: number)
                                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                                    .onTapGesture {
                                        self.rating=number
                                        
                                }
                            }
                        }
                        Spacer().frame(height: 30)
                        Button(action: {
                            self.alertstate = true
                            UserDefaults.standard.set(self.rating, forKey: "Rate")
                            
                        })
                        {
                            Text("Send").font(.system(size: 15)).padding()
                                .background(Color.blue)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding(5)
                               
                            
                        }.alert(isPresented: self.$alertstate) {
                            Alert(title: Text("Rating"), message: Text("Submitted successfully !"), dismissButton: Alert.Button.default(Text("OK"), action:{
                                self.showingPopupA.toggle()
                            }))
                        }
                        
                        
                    }
                }
            }.frame(minWidth: 0, maxWidth: 250)
                .padding()
                .foregroundColor(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue,lineWidth : 5)
            )
            
            Spacer().frame(height: 20)
            HStack{
                Button(action: {
                    self.showingPopupB.toggle()
                })
                {
                    Text("About Us").font(.system(size: 20))
                        .foregroundColor(.blue)
                        .bold()
                    
                }.popover(isPresented: self.$showingPopupB) {
                    VStack{
                        Text("This App was developped by 3 students of the University of applied sciences Mittelhessen (THM):\n Adnane Samlali\n Youssef Mellouli\n Khaled Trabelsi")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .bold()
                    
                        
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .center)
                        .background(Color.gray)
                }
            }.frame(minWidth: 0, maxWidth: 250)
                .padding()
                .foregroundColor(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue,lineWidth : 5))
            
            Spacer().frame(height: 20)
            HStack{
                Button(action: {
                    self.showingPopupC.toggle()
                })
                {
                    Text("Contact Us").font(.system(size: 20))
                        .foregroundColor(.blue)
                        .bold()
                    
                }.popover(isPresented: self.$showingPopupC) {
                    VStack{
                        Text("You can reach us here :\n\n adnane.samlali@mni.thm.de\n youssef.mellouli@mni.thm.de\n khaled.trabelsi@mni.thm.de")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .bold()
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .center)
                        .background(Color.gray)
                }
            }.frame(minWidth: 0, maxWidth: 250)
                .padding()
                .foregroundColor(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue,lineWidth : 5))
            
            
            Spacer().frame(height: 20)
            HStack{
                Button(action: {
                    self.showingPopupD.toggle()
                })
                {
                    Text("Version").font(.system(size: 20))
                        .foregroundColor(.blue)
                        .bold()
                    
                }.popover(isPresented: self.$showingPopupD) {
                    VStack{
                        Image("120")
                        Text("v1.0.0")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                        
                        Text("Apex Workout").font(.system(size: 25)).foregroundColor(Color(.init(red: 45.0/255.0, green: 188.0/255.0, blue: 227.0/255.0, alpha: 1))).bold()
                        
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .center)
                        .background(Color.gray)
                }
                
            }.frame(minWidth: 0, maxWidth: 250)
                .padding()
                .foregroundColor(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue,lineWidth : 5));
            
            Spacer().frame(height: 20)
            
                       HStack{
                            Button(action: {
                                          self.inter.showAd()
                                          })
                            {
                               Text("Support Us").font(.system(size: 20))
                                .foregroundColor(.blue)
                               .bold()
                               
                           }
                           
                       }.frame(minWidth: 0, maxWidth: 250)
                       .padding()
                       .foregroundColor(Color.blue)
                       .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue,lineWidth : 5))
                    
            HStack{
            Banner()
            }.padding(.top, 275)
            
        }
    }
    
}

