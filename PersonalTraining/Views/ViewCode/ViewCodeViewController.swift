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
    var scrollView = UIScrollView()
    var container = UIView()
    var clearButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        
        //scrollview cofnig
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //container view config
        scrollView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        let containerHeight = container.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        containerHeight.priority = .defaultLow
        containerHeight.isActive = true
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        

        
        //new view config
        container.addSubview(newView)

        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        newView.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive = true
        newView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newView.backgroundColor = .red

        
        //clear butotn
        container.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        newView.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 15).isActive = true
        clearButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        clearButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).isActive = true
        clearButton.addTarget(self, action: #selector(removeAllLabels), for: .touchUpInside)
        clearButton.setTitle("Clear stack", for: .normal)
        clearButton.setTitleColor(UIColor.black, for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.layer.borderWidth = 1.0
        clearButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
//
        //config nameLabel
        nameLabel.text = "Label 1"
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center

        //config surname
        surnameLabel.text = "Label 2"
        surnameLabel.numberOfLines = 0
        surnameLabel.font = UIFont.systemFont(ofSize: 17)
        surnameLabel.textAlignment = .center

        //config stackView

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(surnameLabel)

        container.addSubview(stackView)
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
        container.addSubview(button)

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
        container.addSubview(addButton)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8).isActive = true
        container.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: addButton.bottomAnchor, multiplier: 1).isActive = true
//        NSLayoutConstraint(item: container, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: addButton, attribute: .bottom, multiplier: 1, constant: 20).isActive = true // funciona também
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    
    @objc func buttonTap() {
        UIView.animate(withDuration: 0.3, animations: {
            self.surnameLabel.isHidden.toggle()
            self.newView.layer.cornerRadius = self.surnameLabel.isHidden ? 50 : 0
            self.newView.layer.borderWidth = self.surnameLabel.isHidden ? 2 : 0
            self.newView.layer.borderColor = self.surnameLabel.isHidden ? UIColor.red.cgColor : UIColor.blue.cgColor
            self.nameLabel.text = self.surnameLabel.isHidden ? "Animou:)" : "Label 1"
            self.view.backgroundColor = self.surnameLabel.isHidden ? .yellow : .white
            self.newView.backgroundColor = self.surnameLabel.isHidden ? .blue : .red
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    @objc func addButtonTap() {
        for _ in 0...4 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "Label \(stackView.arrangedSubviews.count + 1)"
            label.textAlignment = .center
            self.stackView.addArrangedSubview(label)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
 
    @objc func removeAllLabels() {
        for view in stackView.arrangedSubviews {
            view.isHidden = true
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
       
        
    }
}
