//
//  ContentRow.swift
//  work
//
//  Created by ii on 01.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI

struct ContentRow: View {
    var name: String
    var body: some View {
        VStack{
            Image(name).padding(.leading, 90.0)
            Text(name).padding(.leading, 90.0)

        }
    }
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(name: "Chest")
    }
}
