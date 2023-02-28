//
//  LevelsViewController.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

class LevelsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var shadows = CustomizeShadows()
    
    var levelsArray = [LevelModel(puzzleId: 0, puzzleImage: UIImage(named: "imagelvl1")!),
                       LevelModel(puzzleId: 1, puzzleImage: UIImage(named: "imageLvl2")!),
                       LevelModel(puzzleId: 2, puzzleImage: UIImage(named: "imageLvl3")!),
                       LevelModel(puzzleId: 3, puzzleImage: UIImage(named: "imageLvl4")!),
                       LevelModel(puzzleId: 4, puzzleImage: UIImage(named: "imageLvl5")!),
                       LevelModel(puzzleId: 5, puzzleImage: UIImage(named: "imageLvl6")!),
                       LevelModel(puzzleId: 6, puzzleImage: UIImage(named: "imageLvl7")!),
                       LevelModel(puzzleId: 7, puzzleImage: UIImage(named: "imageLvl8")!),
                       LevelModel(puzzleId: 8, puzzleImage: UIImage(named: "imageLvl9")!),
                       LevelModel(puzzleId: 9, puzzleImage: UIImage(named: "imageLvl10")!),
                       LevelModel(puzzleId: 10, puzzleImage: UIImage(named: "imageLvl11")!),
                       LevelModel(puzzleId: 11, puzzleImage: UIImage(named: "imageLvl12")!),
    ]
    
    
    private let levelsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    lazy private var levelsLabel: UILabel = {
        let label = UILabel()
        label.text = "LEVELS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Knewave-Regular", size: 34)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(levelsLabel)
        view.addSubview(levelsCollectionView)
        collectionViewSettings()
        collectionViewLayout()
        backgroundImageConstraint()
        backButtonConstraint()
        
        levelsLabel.attributedText = NSAttributedString(string: "LEVELS", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: -9,
            .font: UIFont(name: "Knewave-Regular", size: 34)!
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! levelsCell
        cell.layer.cornerRadius = 20
        cell.referenceImage.image = levelsArray[indexPath.item].puzzleImage
        cell.numberOfLevelLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl1
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 1:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl2
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 2:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl3
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        default:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl4
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    private func collectionViewSettings() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 3.5, height:  view.frame.width / 3.5)
        levelsCollectionView.setCollectionViewLayout(layout, animated: true)
        levelsCollectionView.delegate = self
        levelsCollectionView.dataSource = self
        levelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        levelsCollectionView.register(levelsCell.self, forCellWithReuseIdentifier: "cell")
        levelsCollectionView.backgroundColor = .clear
    }
    
    
    private func collectionViewLayout() {
        NSLayoutConstraint.activate([
            levelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            levelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            levelsCollectionView.topAnchor.constraint(equalTo: levelsLabel.bottomAnchor, constant: 30),
            levelsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
    
    private func backgroundImageConstraint(){
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func backButtonConstraint(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            levelsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            levelsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelsLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            levelsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
        ])
    }
    
    
    //MARK: - Actions
    @objc func backButtonAction() {
        self.dismiss(animated: true)
    }
    
}
