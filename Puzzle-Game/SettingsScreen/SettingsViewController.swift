//
//  SettingsViewController.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    let shadows = CustomizeShadows()
    
    lazy private var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "SETTINGS"
        label.textColor = .white
        label.font = UIFont(name: "Marker felt", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "image 5")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 1"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var soundButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SOUND", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var soundOffButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var vibroButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VIBRO", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var vibroOffButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var rateUsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RATE US", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        //  button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(settingsLabel)
        view.addSubview(soundButton)
        view.addSubview(soundOffButton)
        view.addSubview(vibroButton)
        view.addSubview(vibroOffButton)
        view.addSubview(rateUsButton)
        
        shadowSettings()
        backgroundImageConstraint()
        backButtonConstraint()
        soundButtonConstraint()
        vibroButtonConstraint()
        rateUsButtonConstraint()
        fontButtonsSettings()
    }
    
    
    private func shadowSettings() {
        shadows.makeShadowForOne(object: settingsLabel, borderWidth: nil, borderColor: nil, shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1), shadowRadius: 2.0, Opacity: 2.0)
    }
    
    
    func fontButtonsSettings() {
        soundButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        soundOffButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        vibroButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        vibroOffButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
        rateUsButton.titleLabel?.font = UIFont(name: "Marker felt", size: 34)
    }
    
    
    func soundButtonConstraint(){
        NSLayoutConstraint.activate([
            soundButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 60),
            soundButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 10/15),
            soundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            soundButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
            soundOffButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            soundOffButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 60),
            soundOffButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/15),
            soundOffButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func vibroButtonConstraint(){
        NSLayoutConstraint.activate([
            vibroButton.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 15),
            vibroButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 10/15),
            vibroButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            vibroButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
            vibroOffButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            vibroOffButton.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 15),
            vibroOffButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/15),
            vibroOffButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
        ])
    }
    
    
    func rateUsButtonConstraint(){
        NSLayoutConstraint.activate([
            rateUsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateUsButton.topAnchor.constraint(equalTo: vibroButton.bottomAnchor, constant: 15),
            rateUsButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.89),
            rateUsButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.082),
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
    
    
    func backButtonConstraint(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
    }
    
    
    @objc func backButtonAction() {
        self.dismiss(animated: true)
    }
    
}
