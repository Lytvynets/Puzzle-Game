//
//  ViewController.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Buttons
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PLAY", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    lazy var gameRulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GAME RULES", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SETTINGS", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PRIVACY POLICY", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        //   button.addTarget(self, action: #selector(endScreenButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Background
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "image 5")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "image 13")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: Actions
    @objc func playButtonAction() {
        let vc = LevelsViewController()
        vc.modalPresentationStyle = .fullScreen
        // vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    
    @objc func settingsButtonAction() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //    @objc func endScreenButtonAction() {
    //        let vc = LevelEndScreen(time: 175, roundWon: 1)
    //        vc.result = .win
    //        vc.modalPresentationStyle = .fullScreen
    //        self.present(vc, animated: true)
    //    }
    
}
