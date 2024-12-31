//
//  Data.swift
//  work
//
//  Created by ii on 01.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI

let bodyParts = [BodyParts(id:1, name:"Chest"),
                 BodyParts(id:2, name:"Shoulders"),
                 BodyParts(id:3, name:"Arms"),
                 BodyParts(id:4, name:"Back"),
                 BodyParts(id:5, name:"Abs"),
                 BodyParts(id:6, name:"Legs"),
                 BodyParts(id:7, name:"Full Body")]
                 
                
struct BodyParts : Identifiable {
 var id: Int
 var name: String
 }
