//
//  UserInput.swift
//  work
//
//  Created by ii on 07.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct UserInput: View {
    
    
    enum ActiveAlert {
        case first, second
    }

    @State var weight:String=""
    @State var height:String=""
    @State var fatmass:String=""
    let db = Firestore.firestore()
    let currentdate=Date()
    let formatter = DateFormatter()
    @State private var checkinput = false
    @State private var activeAlert: ActiveAlert = .first
     let ident=UIDevice.current.identifierForVendor?.uuidString
    var body: some View {
        
    
        
        Form{
            Section(header: Text("Weight(Kg):").bold().font(.system(size:35)).foregroundColor(Color.black)){

                TextField("Kg",text:$weight)
                    .keyboardType(.decimalPad)
            }
            
           Section(header: Text("Height(cm):").bold().font(.system(size:35)).foregroundColor(Color.black)){
            
            TextField("cm", text:$height)
                              .keyboardType(.decimalPad)
                      }
            Section(header: Text("Body Fat Mass(%):").bold().font(.system(size:35)).foregroundColor(Color.black)){
                       TextField("%", text:$fatmass)
                               .keyboardType(.decimalPad)
            }
     
            Section{
                
             
                Button(action: {                     
                if  ( Double(self.weight) != nil && Double(self.height) != nil && Double(self.fatmass) != nil )
                {
                    self.checkinput = true
                    self.activeAlert = .first
                }
                else
                {
                    self.activeAlert = .second
                       self.checkinput = true
    
                    
                }
                
                
                if(self.activeAlert == .first){
                self.formatter.dateFormat = "dd-MM-yy HH:mm:ss"
                let myString = self.formatter.string(from: Date())
                    let messageRef = self.db.collection("PID").document(self.ident!).collection("measures")
                    messageRef.document(myString).setData([
                    "Weight": self.weight,
                    "Height": self.height,
                    "Fat mass":self.fatmass,
                    "Date":self.currentdate
                    ]) { err in
                                        if let err = err {
                                                  print("Error writing document: \(err)")
                                              } else {
                                                print("pid // Document successfully written!")
                                              }
                                          }
   
                }
                     })  {

                 HStack {
                        Spacer()
                        Text("Submit")
                            .font(.headline)
                            
                        Spacer()
                    }
                         
                }.padding(.vertical, 10.0)
                
                .padding(.horizontal, 50)
                
              .alert(isPresented: $checkinput) {
                switch activeAlert{
                case .first:
                    return Alert(title: Text("Alert"), message: Text("Submitted successfully !"), dismissButton: .default(Text("OK")))
                case .second:
                    return Alert(title: Text("Alert"), message: Text("Input contains Invalid Symbols"), dismissButton: .default(Text("Retry")))                }
                                     
                }

                
                
            }
            
            
                    }
        
        
    
    
    
    }

}


struct UserInput_Previews: PreviewProvider {
    static var previews: some View {
        UserInput()
    }
}
