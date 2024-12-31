//
//  ContentDetail.swift
//  work
//
//  Created by ii on 01.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct GeneralView: View {
    @ObservedObject var datas = getData()
    
    init(str: String) {
        datas.retrieve(str: str)
    }
        var body: some View{
            
        // navigates to description of exercice
                List(datas.data){
                    exercice in
                    NavigationLink(destination: ContentDescription(exercice : exercice)){
                        GeneralRow(exercice: exercice)
                }
            
                }
    }
}

struct URLImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State private var scale: CGFloat = 1.0
    @State private var currentAmount: CGFloat = 0
       @State private var finalAmount: CGFloat = 1


    init(url: String) {
        imageLoader = ImageLoader()
        imageLoader.loadImage(url: url)
    
    
    }

    var body: some View {
        
        Image(uiImage:
            imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
            .resizable()
            .frame(width: 250, height: 140.0)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                 .scaleEffect(finalAmount + currentAmount)
                   .gesture(
                       MagnificationGesture()
                           .onChanged { amount in
                               self.currentAmount = amount - 1
                           }
                           .onEnded { amount in
                               self.finalAmount += self.currentAmount
                               self.currentAmount = 0
                           }
                   )
    }
}
class ImageLoader: ObservableObject {
    @Published var data: Data?

    func loadImage(url: String) {
        let imageRef = Storage.storage().reference(forURL: url)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}



struct ContentDescription: View {
     
    var exercice: Exercice
    var body: some View {
        
        
        VStack{
            Spacer()
            URLImage(url: exercice.pic)
            Spacer()
            Text(exercice.description)
            
                Spacer()
                .navigationBarTitle(exercice.title)
            Banner()
        
        }
        }
}

//outputs list of exercices
struct GeneralRow: View {

    var exercice: Exercice
     

    var body: some View {
    
        VStack{
            Text(exercice.title) //ID
        }.navigationBarTitle("APEX Workout", displayMode: .inline)
    }
}





class getData : ObservableObject{
    
    @Published var data = [Exercice]()
       
        func retrieve(str: String){
        let db = Firestore.firestore()
        
        db.collection(str).getDocuments { (querySnapshot: QuerySnapshot?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else {
    for document in querySnapshot!.documents {
    let id = document.documentID
        
        let description=document.get("name") as! String
        let title = document.get("id") as! String
        let pic=document.get("pic") as! String
        self.data.append(Exercice(id: id ,title: title, description:description,pic :pic))
    }
        }
    }

 }
}


struct Exercice : Identifiable {
           var id: String
    var title: String // id in database
    var description:String // name in database
    var pic:String
}

struct ContentDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView(str: "Chest")
    }
}
