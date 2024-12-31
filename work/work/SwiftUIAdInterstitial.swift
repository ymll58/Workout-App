//
//  SwiftUIAdInterstitial.swift
//  work
//
//  Created by ii on 09.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit
    
final class Interstitial:NSObject, GADInterstitialDelegate{
    // Google's adUnitID for testing purposes
    var interstitial:GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    // SHOWAD method to show video ad when something is triggered
    func showAd(){
        if self.interstitial.isReady{
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        LoadInterstitial()
    }
}
