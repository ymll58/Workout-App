//
//  SwiftUIAdBanner.swift
//  work
//
//  Created by ii on 09.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
//
// App-ID : ca-app-pub-6270111527001444~6294354227
// Unit-ID : ca-app-pub-6270111527001444/5724983364

import SwiftUI
import GoogleMobileAds
import UIKit

//converts UIKIT controllerview to swiftui
final private class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        // Google's adUnitId for testing purposes
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
      
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
