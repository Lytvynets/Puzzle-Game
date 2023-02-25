//
//  CustomizeShadows.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 24.02.2023.
//

import Foundation
import UIKit

class CustomizeShadows {
    func makeShadowForOne<T: UIView>(object: T, borderWidth: CGFloat?, borderColor: CGColor?, shadowColor: CGColor, shadowRadius: CGFloat, Opacity: Float) {
        object.layer.borderWidth = borderWidth ?? 0
        object.layer.borderColor = borderColor
        object.layer.masksToBounds = true
        object.layer.shadowColor = shadowColor
        object.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        object.layer.shadowRadius = shadowRadius
        object.layer.shadowOpacity = Opacity
    }
}
