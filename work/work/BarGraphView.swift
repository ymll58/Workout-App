//
//  BarGraphView.swift
//  work
//
//  Created by ii on 08.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore




struct BarGraphView: View {
 
    @ObservedObject var datas = getGraphData()
    var body: some View {

        List(){
                Section(header: Text("BMI & Weight Graph").bold().font(.system(size:25)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .center)){
                    ChartLegend()
                ForEach(datas.data){
                i in BarGraph(weight: i.weight, height: i.height,id: i.id)
               
                   
                }
                }
            Spacer().frame(height:500)
            Banner()
        }
      
       
        }
        }
   


struct BarGraph : View {

    var weight: String
    var height: String
    var id = ""
    var body: some View{
    
         
        
            
        
        HStack {
            VStack(alignment: .leading, spacing: 4){
            Text(id).foregroundColor(Color.black.opacity(0.5)).font(.system(size : 15))
                HStack{
            Rectangle().fill(Color.red).frame(width: getBarLength(), height: 10 )
                    Text(weight).foregroundColor(Color.black.opacity(0.5)).font(.system(size: 15))
                }
            
                HStack{
                    Rectangle().fill(Color.blue).frame(width: getBMIBarLength(), height: 10 )
                    Text(getBMI()).foregroundColor(Color.black.opacity(0.5)).font(.system(size: 15))
                }
            }
            }
        
    }
    func getBarLength() -> CGFloat{
        var w : CGFloat = 0
        if let n = NumberFormatter().number(from: weight) {  //converts string to CGFloat
            w = CGFloat(truncating: n)
        }
        return 100 / 50 * w
    }
    
    func getBMI() -> String{
    
        var w : CGFloat = 0
        var h : CGFloat = 0
        var res : CGFloat = 0
       if let n = NumberFormatter().number(from: weight) {  //converts string to CGFloat
            w = CGFloat(truncating: n)
        }
        if let m = NumberFormatter().number(from: height) {  //converts string to CGFloat
            h = CGFloat(truncating: m)
        }
        res =  w / pow((h/100), 2)
        let bmi = String(format: "%.2f", res)

        return bmi

    }
    
    func getBMIBarLength() -> CGFloat{
        var b : CGFloat = 0
        if let n = NumberFormatter().number(from: getBMI()){
            b = CGFloat(truncating: n)
        }
        return 100 / 50 * b
    }
}


class getGraphData : ObservableObject{

    @Published var data = [BarGraphList]()
    //92565309-28A4-430B-8BD7-5A9E1D8F862E
    init(){
        let db = Firestore.firestore()
        let ident=UIDevice.current.identifierForVendor?.uuidString
 
        db.collection("PID").document(ident!).collection("measures").addSnapshotListener { querySnapshot, error in
              guard let snapshot = querySnapshot else {
                  print("Error fetching snapshots: \(error!)")
                  return
              }
              snapshot.documentChanges.forEach { diff in
                  if (diff.type == .added) {
                        let id = diff.document.documentID
                    let height = diff.document.get("Height") as? String ?? "no height"
                    let fmass = diff.document.get("Fat mass") as? String ?? "no mass"
                    let weight = diff.document.get("Weight") as? String ?? "no weight"
                    self.data.append(BarGraphList(id:id,fmass: fmass, height: height,weight: weight))
                    print("added: (data)  (name) (wineToAdd.rating)  (wineToAdd.state) id:\(String(describing: ident))")
                    }
                
       
            }
          
        }

    
    }
}
struct ChartLegend : View{
    var body :some View{
        
        HStack{
            Rectangle().fill(Color.red).frame(width: 5, height: 5)
            Text("Weight in Kg")
        Spacer()
        
            Rectangle().fill(Color.blue).frame(width: 5, height: 5)
            Text("BMI in Kg/m²")
        }
}
}

struct BarGraphList : Identifiable {
    var id: String
   var fmass: String
    var height: String
    var weight: String
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarGraphView()
    }
}
