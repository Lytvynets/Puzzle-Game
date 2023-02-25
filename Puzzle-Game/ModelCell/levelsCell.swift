//
//  levelsCell.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

class levelsCell: UICollectionViewCell {
    
    lazy var referenceImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var numberOfLevelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont(name: "Marker felt", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var numberOfLevelBackground: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(referenceImage)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(numberOfLevelBackground)
        contentView.addSubview(numberOfLevelLabel)
        backgroundImage.image = UIImage(named: "candy frame")
        numberOfLevelBackground.image = UIImage(named: "Ellipse 1")
        layoutSettings()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutSettings() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            referenceImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            referenceImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            referenceImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            referenceImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            numberOfLevelBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            numberOfLevelBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            numberOfLevelLabel.centerXAnchor.constraint(equalTo: numberOfLevelBackground.centerXAnchor),
            numberOfLevelLabel.centerYAnchor.constraint(equalTo: numberOfLevelBackground.centerYAnchor)
        ])
    }
}
