//
//  LevelEndScreen.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 24.02.2023.
//

import Foundation
import UIKit

class LevelEndScreen: UIViewController {
    
    enum Result {
        case win
        case luse
    }
    
    let shadows = CustomizeShadows()
    var result: Result = .win
    
    //MARK: Labels
    lazy private var timetLabel: UILabel = {
        let label = UILabel()
        label.text = "TIME: 00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Marker felt", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var bestTimetLabel: UILabel = {
        let label = UILabel()
        label.text = "BEST TIME: 00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Marker felt", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: images
    lazy var resultImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "imageEndScreen")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var resultImageView2: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Level completed")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var timeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Rectangle 5")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bestImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Rectangle 5")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Buttons
    lazy private var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var repeatButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 4"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(resultImageView)
        view.addSubview(resultImageView2)
        view.addSubview(timeImageView)
        view.addSubview(bestImageView)
        view.addSubview(timetLabel)
        view.addSubview(bestTimetLabel)
        view.addSubview(nextButton)
        view.addSubview(homeButton)
        view.addSubview(repeatButton)
        
        shadowsSettings()
        layoutSettings()
        
        switch result {
        case .win:
            resultImageView.image = UIImage(named: "imageEndScreen2")
            resultImageView2.image = UIImage(named: "Level completed")
            bestImageView.isHidden = false
            bestTimetLabel.isHidden = false
            
        case .luse:
            resultImageView.image = UIImage(named: "imageEndScreen")
            resultImageView2.image = UIImage(named: "level failed")
            bestImageView.isHidden = true
            bestTimetLabel.isHidden = true
        }
    }
    
    
    private func layoutSettings() {
        NSLayoutConstraint.activate([
            resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            resultImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
           
            resultImageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView2.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: -100),
            resultImageView2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            
            timeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeImageView.topAnchor.constraint(equalTo: resultImageView2.bottomAnchor, constant: 5),
            timeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            timetLabel.centerXAnchor.constraint(equalTo: timeImageView.centerXAnchor),
            timetLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            
            bestImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bestImageView.topAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 2),
            bestImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            bestTimetLabel.centerXAnchor.constraint(equalTo: bestImageView.centerXAnchor),
            bestTimetLabel.centerYAnchor.constraint(equalTo: bestImageView.centerYAnchor),
            
            homeButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 10),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            repeatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 5),
            
            nextButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    
    private func shadowsSettings() {
        shadows.makeShadowForOne(object: timetLabel,
                                 borderWidth: nil,
                                 borderColor: nil,
                                 shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
                                 shadowRadius: 2.0,
                                 Opacity: 2.0)
        shadows.makeShadowForOne(object: bestTimetLabel,
                                 borderWidth: nil,
                                 borderColor: nil,
                                 shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
                                 shadowRadius: 2.0,
                                 Opacity: 2.0)
    }
}
