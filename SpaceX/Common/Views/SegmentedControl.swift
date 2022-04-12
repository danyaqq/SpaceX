//
//  SegmentedControl.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import Foundation
import UIKit

@IBDesignable
public class SegmentedControl: UIControl {
    
    @IBInspectable public var animationDuration: CGFloat = 0.3
    
    public var titlesFont: UIFont = .systemFont(ofSize: 14, weight: .semibold) {
        didSet {
            updateView()
        }
    }
    
    public var selectedSegmentIndex = 0
    {
        didSet {
            self.setSelectedIndex(to: selectedSegmentIndex)
        }
    }
    
    public var roundedControl: Bool = true {
        didSet {
            self.updateView()
        }
    }
    
    @IBInspectable public var selectedColor: UIColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var unselectedColor: UIColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1) {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable internal var buttonTitles: [String] = [] {
        didSet {
            updateView()
        }
    }
    
    internal var buttons = [UIButton]()
    
    internal var thumbView: UIView = {
        return UIView()
    }()
    
    private func resetViews() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func updateView() {
        resetViews()
        
        addSubview(thumbView)
        
        setButtonsWithText()
        layoutButtonsOnStackView()
        
        self.clipsToBounds = false
    }
    
    public func setSegmentedWith<T>(items: T) {
        if let collection = items as? [String] {
            self.buttonTitles = collection
        }
    }
    
    private func layoutButtonsOnStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3)
        ])
    }
    
    private func setButtonsWithText() {
        
        guard !self.buttonTitles.isEmpty else { return }
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = titlesFont
            button.setTitleColor(unselectedColor, for: .normal)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 7.8
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
            
        }
        buttons[selectedSegmentIndex].setTitleColor(selectedColor, for: .normal)
        buttons[selectedSegmentIndex].layer.borderColor = selectedColor.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        layer.cornerRadius = 7.8
    }
}

import Foundation
import UIKit

extension SegmentedControl {
    
    internal func performAction() {
        sendActions(for: .valueChanged)
    }
    
    @objc internal func buttonTapped(button: UIButton) {
        for (btnIndex, btn) in self.buttons.enumerated() {
            if btn == button {
                selectedSegmentIndex = btnIndex
            }
        }
        self.performAction()
    }
    
    @objc internal func setSelectedIndex(to index: Int) {
        let selectedBtn = self.buttons[index]
        
        for (_, btn) in self.buttons.enumerated() {
            
            btn.setTitleColor(unselectedColor, for: .normal)
            btn.layer.borderColor = unselectedColor.cgColor
            
            if btn == selectedBtn {
                btn.setTitleColor(selectedColor, for: .normal)
                btn.backgroundColor = .white
                
            } else {
                btn.backgroundColor = .clear
            }
        }
    }
    
}


#if DEBUG
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController,context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        TestSegmentedControl()
    }
}
@available(iOS 13.0, *)
struct MyTestViewControllerPreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .previewDisplayName("iPhone 12")
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
        }
        
    }
} #endif


class TestSegmentedControl: UIViewController {
    
    lazy var segm: ChoosingUnitView = {
        let view = ChoosingUnitView()
        view.segmentedItems = ["ON", "OFF"]
        view.selectedItemIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(segm)
        
        
        segm.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segm.widthAnchor.constraint(equalToConstant: 115).isActive = true
        segm.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        segm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
