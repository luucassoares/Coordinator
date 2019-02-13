//
//  ViewCodeViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 13/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

class ViewCodeViewController: UIViewController {


    var nameLabel = UILabel()
    var surnameLabel = UILabel()
    var newView = UIView()
    var stackView = UIStackView()
    var button = UIButton()
    var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //new view config
        view.addSubview(newView)
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        newView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.backgroundColor = .red
        
        //config nameLabel
        nameLabel.text = "Lucas"
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center
        
        //config surname
        surnameLabel.text = "Soares"
        surnameLabel.numberOfLines = 0
        surnameLabel.font = UIFont.systemFont(ofSize: 17)
        surnameLabel.textAlignment = .center
        
        //config stackView
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(surnameLabel)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: newView.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: newView.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        
        //config button
        button.setTitle("Animate", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button.layer.cornerRadius = 3
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8).isActive = true
        
        //config addbutton
        addButton.setTitle("Add Label", for: .normal)
        addButton.backgroundColor = .purple
        addButton.setTitleColor(.white, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        addButton.layer.cornerRadius = 3
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8).isActive = true
    }
    
    
    @objc func buttonTap() {
        UIView.animate(withDuration: 0.3, animations: {
            self.surnameLabel.isHidden.toggle()
            self.newView.layer.cornerRadius = self.surnameLabel.isHidden ? 50 : 0
            self.newView.layer.borderWidth = self.surnameLabel.isHidden ? 2 : 0
            self.newView.layer.borderColor = self.surnameLabel.isHidden ? UIColor.blue.cgColor : UIColor.red.cgColor
            self.nameLabel.text = self.surnameLabel.isHidden ? "Animou:)" : "Lucas"
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func addButtonTap() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Label número: \(stackView.arrangedSubviews.count + 1)"
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
    }
 
}
