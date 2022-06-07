//
//  HomePage.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 06/06/2022.
//

import Foundation
import SwiftUI

struct HomePage: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
