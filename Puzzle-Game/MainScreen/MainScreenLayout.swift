//
//  MainScreenLayout.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

extension MainViewController {
    
    func setup() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(playButton)
        view.addSubview(gameRulesButton)
        view.addSubview(settingsButton)
        view.addSubview(privacyPolicyButton)
        
        backgroundImageConstraint()
        logoImageConstraint()
        playButtonConstraint()
        gameRulesButtonConstraint()
        settingsButtonConstraint()
        privacyPolicyButtonConstraint()
        fontSettings()
    }
    
    
    func fontSettings() {
        playButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        gameRulesButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        settingsButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        privacyPolicyButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
    }
    
    
    func playButtonConstraint(){
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.89),
            playButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func gameRulesButtonConstraint(){
        NSLayoutConstraint.activate([
            gameRulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameRulesButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 16),
            gameRulesButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.89),
            gameRulesButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func settingsButtonConstraint(){
        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: gameRulesButton.bottomAnchor, constant: 16),
            settingsButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.89),
            settingsButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func privacyPolicyButtonConstraint(){
        NSLayoutConstraint.activate([
            privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyPolicyButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 16),
            privacyPolicyButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.89),
            privacyPolicyButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func backgroundImageConstraint(){
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func logoImageConstraint(){
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
