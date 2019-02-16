//
//  TextFieldMobile2You.swift
//  Mobile2you
//
//  Created by Mobile2You on 20/12/2017.
//  Copyright © 2017 Mobile2You. All rights reserved.
//

import UIKit
import MaterialComponents
import TLCustomMask
import RxSwift

enum TextFieldType {
    case CPF
    case CNPJ
    case NAME
    case CEP
    case PHONE // PHONE OR CELLPHONE
    case DATE
    case EMAIL
    case MASK
    case PASSWORD
    case MONEY
    case NUMERIC
    case MATCHING
    case CREDIT_CARD_DATE
    case CREDIT_CARD_NUMBER
    case BIRTHDAY // verifica se é maior que 0
    case BIRTHDAY_AGE_ADULT // verifica se é == 18 anos
    case BIRTHDAY_MAX_AGE_AND_MINAGE
    case BIRTHDAY_MIN_AGE
    case BIRTHDAY_MAX_AGE
}

enum TextFieldLayouType: Int {
    case OUTLINED
    case UNDERLINE
    case NO_LINES
}

class NewTextField: MDCTextField {
    
    // MARK: - Constants
    private let MIN_LENGTH_PASSWORD = 6
    private let MASK_CPF = "$$$.$$$.$$$-$$"
    private let MASK_CNPJ = "$$.$$$.$$$/$$$$-$$"
    private let MASK_CEP = "$$$$$-$$$"
    private let MASK_CELLPHONE = "($$) $$$$$-$$$$"
    private let MASK_PHONE = "($$) $$$$-$$$$"
    private let MASK_CREDIT_CARD_NUMBER = "$$$$ $$$$ $$$$ $$$$ $$$$ $$$$"
    private let MASK_CREDIT_CARD_DATE = "$$/$$"
    private let MASK_DATE = "$$/$$/$$$$"
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textInputController = MDCTextInputControllerUnderline(textInput: self)
        self.clearButtonMode = .never
        self.textInputController?.normalColor = UIColor.black
        self.textInputController?.activeColor = UIColor.black
        self.textInputController?.floatingPlaceholderActiveColor = UIColor.black
        self.textInputController?.errorColor = UIColor.red
        self.textInputController?.textInputFont = UIFont.boldSystemFont(ofSize: 15
        )
        self.delegate = self
    }
    
    // MARK: - Properties
    var textFieldType: TextFieldType? {
        didSet {
            self.didSetType()
        }
    }
    
    var isBoldText: Bool = true {
        didSet {
            if isBoldText {
                self.font = UIFont.boldSystemFont(ofSize: 15.0)
            } else {
                self.font = UIFont.systemFont(ofSize: 15.0)
            }
        }
    }
    
    var textFieldLayoutType: TextFieldLayouType = .OUTLINED {
        didSet {
            if textFieldLayoutType == .OUTLINED {
                self.textInputController = MDCTextInputControllerOutlined(textInput: self)
                self.borderView?.isHidden = false
                self.underline?.isHidden = true
            } else if textFieldLayoutType == .UNDERLINE {
                self.textInputController = MDCTextInputControllerUnderline(textInput: self)
                self.borderView?.isHidden = true
                self.underline?.isHidden = false
            } else {
                self.textInputController = MDCTextInputControllerUnderline(textInput: self)
                self.borderView?.isHidden = true
                self.underline?.isHidden = true
            }
        }
    }
    
    @IBInspectable var isOutlined: Bool = true {
        didSet {
            if isOutlined {
                self.textFieldLayoutType = .OUTLINED
            } else {
                self.textFieldLayoutType = .UNDERLINE
            }
        }
    }
    
    private var maskString: String? {
        didSet {
            if let m = maskString {
                self.customMask.formattingPattern = m
            }
        }
    }
    
    // Mensagem de erro
    lazy var errorMessage = "Campo inválido"
    lazy var emptyMessage = "Campo vazio"
    
    // Número máximo de caracteres. Default = 100
    lazy var maxLength: Int = 100
    
    // Idade mínima. Usado em campos de data onde existe uma idade mínina
    var minAge: Int?
    
    // Idade máxima. Usado em campos de data onde existe uma idade máxima
    var maxAge: Int?
    
    // Exibe o R$ antes do numero
    var hasCurrencySymbolForMoney = true
    
    // TextField utilizado para verificar se o .text é igual a self.text. Usado normalmente em campo de confirmar senha
    var textFieldToMatch: UITextField?
    
    // Bloco de validação customizado. Substitui a validação do type
    var validateBlock: (() -> Bool)?
    
    private var textInputController: MDCTextInputControllerBase?
    private lazy var customMask = TLCustomMask()
    
    
    func setup(textFieldType: TextFieldType, customErrorMessage: String? = nil, customValidateBlock: (() -> Bool)? = nil) {
        self.textFieldType = textFieldType
        if let errorMsg = customErrorMessage { self.errorMessage = errorMsg }
        if let block = customValidateBlock { self.validateBlock = customValidateBlock }
    }
    
    // MARK: - Setup
    private func getEyeView() -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let btn = UIButton.init(frame: v.frame)
        if self.isSecureTextEntry {
            btn.setImage(UIImage(named: "eye_closed"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "eye_opened"), for: .normal)
        }
        
        btn.addTarget(self, action: #selector(didTapEyeIcon), for: .touchUpInside)
        v.addSubview(btn)
        return v
    }
    
    func setTextfieldFontSize(size : Int){
        self.textInputController?.textInputFont = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    func isValid() -> Bool {
        
        if let customValidationBlock = validateBlock {
            return customValidationBlock()
        }
        
        guard let type = self.textFieldType else { return true }
        
        switch type {
        case .CPF:
            return self.text?.isValidCPF() == true
            
        case .CNPJ:
            return self.text?.isValidCNPJ() == true
            
        case .NAME:
            return self.text?.isValidName() == true
            
        case .CEP:
            return self.text?.isValidCEP() == true
            
        case .PHONE:
            return self.text?.isValidPhone() == true
            
        case .DATE:
            return self.text?.isValidDate() == true
            
        case .EMAIL:
            return self.text?.isValidEmail() == true
            
        case .BIRTHDAY:
            return self.text?.isValidBirthday(minAge: nil, maxAge: nil) == true
            
        case .BIRTHDAY_AGE_ADULT:
            return self.text?.isValidBirthday(minAge: 18, maxAge: nil) == true
            
        case .BIRTHDAY_MAX_AGE_AND_MINAGE:
            return self.text?.isValidBirthday(minAge: self.minAge, maxAge: self.maxAge) == true
            
        case .BIRTHDAY_MIN_AGE:
            return self.text?.isValidBirthday(minAge: self.minAge, maxAge: nil) == true
            
        case .BIRTHDAY_MAX_AGE:
            return self.text?.isValidBirthday(minAge: nil, maxAge: self.maxAge) == true
            
        case .MASK:
            return (self.text?.count != nil) && (self.text?.count == self.maskString?.count)
            
        case .PASSWORD:
            return (self.text != nil) && self.text!.count >= MIN_LENGTH_PASSWORD
            
        case .MATCHING:
            return (self.text != nil) && (self.text == self.textFieldToMatch?.text)
            
        case .CREDIT_CARD_DATE:
            return self.text?.isValidCreditCardDate() == true
            
        case .CREDIT_CARD_NUMBER:
            return (self.text != nil) && (self.text!.count >= (16+3)) // 16 numeros + 3 espacos
            
        case .MONEY:
            return true
            
        case .NUMERIC:
            return true
            
        }
        
    }
    
    
    private func didSetType(){
        guard let type = self.textFieldType else { return }
        
        switch type {
        case .CPF:
            self.maskString = MASK_CPF
            self.keyboardType = .numberPad
            break
            
        case .CNPJ:
            self.maskString = MASK_CNPJ
            self.keyboardType = .numberPad
            break
            
        case .CEP:
            self.maskString = MASK_CEP
            self.keyboardType = .numberPad
            break
            
        case .PHONE:
            self.maskString = MASK_CELLPHONE
            self.keyboardType = .numberPad
            break
            
        case .CREDIT_CARD_NUMBER:
            self.maskString = MASK_CREDIT_CARD_NUMBER
            self.keyboardType = .numberPad
            break
            
        case .CREDIT_CARD_DATE:
            self.maskString = MASK_CREDIT_CARD_DATE
            self.keyboardType = .numberPad
            break
            
        case .DATE:
            fallthrough
        case .BIRTHDAY:
            fallthrough
        case .BIRTHDAY_AGE_ADULT:
            fallthrough
        case .BIRTHDAY_MAX_AGE_AND_MINAGE:
            fallthrough
        case .BIRTHDAY_MIN_AGE:
            fallthrough
        case .BIRTHDAY_MAX_AGE:
            self.maskString = MASK_DATE
            self.keyboardType = .numberPad
            break
            
        case .EMAIL:
            self.keyboardType = .emailAddress
            break
            
        case .MATCHING:
            self.isSecureTextEntry = true
            self.keyboardType = .default
            self.trailingViewMode = .always
            self.trailingView = getEyeView()
            break
            
        case .PASSWORD:
            self.isSecureTextEntry = true
            self.keyboardType = .default
            self.trailingViewMode = .always
            self.trailingView = getEyeView()
            break
            
        case .MONEY:
            self.keyboardType = .numberPad
            self.addTarget(self, action: #selector(moneyTextFieldDidChange), for: .editingChanged)
            break
        case .NUMERIC:
            self.keyboardType = .numberPad
            break
        case .NAME:
            self.keyboardType = .default
            break
        case .MASK:
            break
        }
    }
    
    @objc private func didTapEyeIcon() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.trailingView = getEyeView()
    }
    
    @objc private func moneyTextFieldDidChange(_ textField: UITextField) {
        if let amountString = self.text?.currencyInputFormatting(symbol: self.hasCurrencySymbolForMoney) {
            if(amountString == "") {
                self.text = self.hasCurrencySymbolForMoney ? "R$0,00" : "0,00"
            } else {
                self.text = amountString
            }
            self.sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Mask
    /**
     Insere a máscara no campo.
     */
    func setMask(mask m: String){
        self.maskString = m
    }
    
    /*
     Insere o texto com a máscara no campo.
     */
    func setTextWithMask(_ txt: String){
        self.text = customMask.formatString(string: txt)
        self.sendActions(for: .valueChanged)
    }
    
    //MARK: - Color
    /*
     Altera a cor da borda do TextField
     */
    func setTextFieldColor(textColor: UIColor = .white, normalColor: UIColor = UIColor.black, activeColor: UIColor = UIColor.black, floatingPlaceholderActiveColor: UIColor = UIColor.black) {
        self.textColor = textColor
        self.textInputController?.normalColor = normalColor
        self.textInputController?.activeColor = activeColor
        self.textInputController?.floatingPlaceholderActiveColor = floatingPlaceholderActiveColor
        self.textInputController?.floatingPlaceholderNormalColor = normalColor
    }
    
    // MARK: - Toolbar
    /**
     Insere os textFields próximos e anterior. Caso não exista um deles, mandar nil
     Será exibido uma toolbar para o usuário ir para o próximo/anterior clicando no botão
     */
    
    private var toolbar = UIToolbar()
    private var prevTF: UITextField?
    private var nextTF: UITextField?
    
    func setNextPrevToolbar(prev: UITextField?, next: UITextField?){
        self.prevTF = prev
        self.nextTF = next
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(inputToolbarDonePressed))
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let nextButton  = UIBarButtonItem(image: UIImage(named: "keyboardNextButton"), style: .plain, target: self, action: #selector(keyboardNextButton))
        nextButton.width = 50.0
        let previousButton  = UIBarButtonItem(image: UIImage(named: "keyboardPreviousButton"), style: .plain, target: self, action: #selector(keyboardPreviousButton))
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolbar
    }
    
    func removeToolbar(){
        self.inputAccessoryView = nil
    }
    
    @objc private func inputToolbarDonePressed(){
        self.resignFirstResponder()
    }
    
    @objc private func keyboardNextButton(){
        if let next = nextTF {
            next.becomeFirstResponder()
        }
        else {
            self.resignFirstResponder()
        }
    }
    
    @objc private func keyboardPreviousButton(){
        if let prev = prevTF {
            prev.becomeFirstResponder()
        }
        else {
            self.resignFirstResponder()
        }
    }
    
    
    // Mark: - VALIDACAO
    
    private func hasToValidate() -> Bool {
        if validateBlock != nil { return true }
        guard let type = textFieldType else { return false }
        switch type {
        case .EMAIL:
            return true
        case .PASSWORD:
            return true
        default:
            if self.maskString == nil {
                return false
            }
            return true
        }
        
    }
    
    func textFieldM2YshouldChange(textField: UITextField, range: NSRange, string: String) -> Bool {
        
        if self.textFieldType != nil && self.textFieldType! == .PHONE && textField.text != nil && textField.text!.count == 6 {
            if (textField.text!.charAt(index: 5) == "9") {
                self.maskString = MASK_CELLPHONE
            } else {
                self.maskString = MASK_PHONE
            }
        }
        
        if textField.text != nil && textField.text!.count >= maxLength && string != "" {
            return false
        }
        
        if self.maskString != nil {
            self.text = customMask.formatStringWithRange(range: range, string: string)
            self.sendActions(for: .valueChanged)
        } else {
            return true
        }
        
        //        if (hasToValidate()) {
        //            validate()
        //        }
        return false
    }
    
    let bag = DisposeBag()
    
    func validate() {
        if isValid() {
            // remove o erro
            self.textInputController?.setErrorText(nil, errorAccessibilityValue: nil)
        } else {
            self.textInputController?.setErrorText(self.text?.isEmpty == true ? self.emptyMessage : self.errorMessage, errorAccessibilityValue: nil)
        }
    }
    
    func setError(message: String) {
        self.textInputController?.setErrorText(message, errorAccessibilityValue: nil)
    }
    
    
}

// MARK: - UITextFieldDelegate
extension NewTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textFieldM2YshouldChange(textField: textField, range: range, string: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (self.nextTF != nil) {
            self.nextTF?.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        if (hasToValidate()) {
            validate()
        }
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (hasToValidate()) {
            validate()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textInputController?.setErrorText(nil, errorAccessibilityValue: nil)
    }
    
}
