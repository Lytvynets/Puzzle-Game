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
    
    
    //MARK: - Gradient
    var gradientPlayButton: CAGradientLayer! {
        didSet {
            gradientPlayButton.startPoint = CGPoint(x: 1, y: 1)
            gradientPlayButton.endPoint = CGPoint(x: 1, y: 0)
            gradientPlayButton.colors = [#colorLiteral(red: 0.703831017, green: 0.1428215206, blue: 0.5742830038, alpha: 1).cgColor, #colorLiteral(red: 0.976688683, green: 0.212975353, blue: 0.7945819497, alpha: 1).cgColor,]
        }
    }
    
    var gradientGameRulesButton: CAGradientLayer! {
        didSet {
            gradientGameRulesButton.startPoint = CGPoint(x: 1, y: 1)
            gradientGameRulesButton.endPoint = CGPoint(x: 1, y: 0)
            gradientGameRulesButton.colors = [#colorLiteral(red: 0.703831017, green: 0.1428215206, blue: 0.5742830038, alpha: 1).cgColor, #colorLiteral(red: 0.976688683, green: 0.212975353, blue: 0.7945819497, alpha: 1).cgColor,]
        }
    }
    
    var gradientSettingsButton: CAGradientLayer! {
        didSet {
            gradientSettingsButton.startPoint = CGPoint(x: 1, y: 1)
            gradientSettingsButton.endPoint = CGPoint(x: 1, y: 0)
            gradientSettingsButton.colors = [#colorLiteral(red: 0.703831017, green: 0.1428215206, blue: 0.5742830038, alpha: 1).cgColor, #colorLiteral(red: 0.976688683, green: 0.212975353, blue: 0.7945819497, alpha: 1).cgColor,]
        }
    }
    
    var gradientPrivacyPolicyButton: CAGradientLayer! {
        didSet {
            gradientPrivacyPolicyButton.startPoint = CGPoint(x: 1, y: 1)
            gradientPrivacyPolicyButton.endPoint = CGPoint(x: 1, y: 0)
            gradientPrivacyPolicyButton.colors = [#colorLiteral(red: 0.703831017, green: 0.1428215206, blue: 0.5742830038, alpha: 1).cgColor, #colorLiteral(red: 0.976688683, green: 0.212975353, blue: 0.7945819497, alpha: 1).cgColor,]
        }
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        gradientPlayButton = CAGradientLayer()
        gradientPlayButton.cornerRadius = 25
        
        gradientGameRulesButton = CAGradientLayer()
        gradientGameRulesButton.cornerRadius = 25
        
        gradientSettingsButton = CAGradientLayer()
        gradientSettingsButton.cornerRadius = 25
        
        gradientPrivacyPolicyButton = CAGradientLayer()
        gradientPrivacyPolicyButton.cornerRadius = 25
        
        playButton.layer.insertSublayer(gradientPlayButton, at: 0)
        gameRulesButton.layer.insertSublayer(gradientGameRulesButton, at: 0)
        settingsButton.layer.insertSublayer(gradientSettingsButton, at: 0)
        privacyPolicyButton.layer.insertSublayer(gradientPrivacyPolicyButton, at: 0)
    }
    
    
    override func viewDidLayoutSubviews() {
        gradientPlayButton.frame = CGRect(x: 0, y: 0, width: self.playButton.bounds.size.width, height: self.playButton.bounds.size.height)
        gradientGameRulesButton.frame = CGRect(x: 0, y: 0, width: self.gameRulesButton.bounds.size.width, height: self.gameRulesButton.bounds.size.height)
        gradientSettingsButton.frame = CGRect(x: 0, y: 0, width: self.settingsButton.bounds.size.width, height: self.settingsButton.bounds.size.height)
        gradientPrivacyPolicyButton.frame = CGRect(x: 0, y: 0, width: self.privacyPolicyButton.bounds.size.width, height: self.gameRulesButton.bounds.size.height)
        
        
        
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
