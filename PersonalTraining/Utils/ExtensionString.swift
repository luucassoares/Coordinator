import UIKit

protocol Localizable {
    var localized: String { get }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension String: Localizable {
    /*
     Utilizado para pegar a localized da string na xib
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}

extension String {
    
    /**
     Dá um decode na String para enviar emojis para o backend
     */
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
    
    /**
     Dá um encode na String para receber emojis do backend
     */
    var encodeEmoji: String{
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue){
            return encodeStr as String
        }
        return self
    }
    
    /**
     Verifica se é um e-mail válido
     */
    func isEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        // return true se o email for válido
        return emailTest.evaluate(with: self)
    }
    
    /**
     Verifica se é uma data válida
     */
    func isValidDate() -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        let oldDateString = "01/01/1900"
        if let date = dateFormatterGet.date(from: self) {
            
            guard let oldDate = dateFormatterGet.date(from: oldDateString) else { return false }
            
            if date > Date() || oldDate > date {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    /**
     Verifica se um CPF é valido
     */
    private func isValid() -> Bool{
        let cpfRegEx = "^(\\d{3}.\\d{3}.\\d{3}-\\d{2})|(\\d{11})$"
        let cpfTest = NSPredicate(format:"SELF MATCHES %@", cpfRegEx)
        // return true se o cpf tiver regex válido
        return cpfTest.evaluate(with: self)
    }
    
    private func isNumberSequence() -> Bool {
        let sequenceRegex = "^([0-9])\\1*$"
        let sequenceTest = NSPredicate(format: "SELF MATCHES %@", sequenceRegex)
        //se for true, é sequencia de números (1111,2222,333..)
        return sequenceTest.evaluate(with: self)
    }
    
    func isCPF() -> Bool {
        if !isValid() {
            return false
        }
        if isNumberSequence() {
            return false
        }
        let toBeChecked = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        if(toBeChecked.count != 11){
            return false
        }
        var sum = 0
        for i in 0..<9 {
            let m = toBeChecked.charAt(index: i)
            sum += (10 - i) * Int(m)!
        }
        
        if(checkResto(sum: sum, toBeChecked: toBeChecked, positionToCheck: 9)) {
            sum = 0
            for i in 0..<10 {
                let m = toBeChecked.charAt(index: i)
                sum += (11 - i) * Int(m)!
            }
            if(checkResto(sum: sum, toBeChecked: toBeChecked, positionToCheck: 10)){
                return true
            }
        }
        return false
    }
    
    private func checkResto(sum: Int, toBeChecked: String, positionToCheck: Int) -> Bool {
        var resto = sum % 11
        if(resto < 2) {
            let numberStr = toBeChecked.charAt(index: positionToCheck)
            if(Int(numberStr) == 0) {
                return true
            }
        } else {
            resto = 11 - resto
            let numberStr = toBeChecked.charAt(index: positionToCheck)
            if(Int(numberStr) == resto) {
                return true
            }
        }
        return false
    }
    
    /**
     Verifica se é um CNPJ válido
     */
    func isCNPJ() -> Bool {
        let numbers = self.compactMap({Int(String($0))})
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[11] * 2 +
            numbers[10] * 3 +
            numbers[9] * 4 +
            numbers[8] * 5 +
            numbers[7] * 6 +
            numbers[6] * 7 +
            numbers[5] * 8 +
            numbers[4] * 9 +
            numbers[3] * 2 +
            numbers[2] * 3 +
            numbers[1] * 4 +
            numbers[0] * 5 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[12] * 2 +
            numbers[11] * 3 +
            numbers[10] * 4 +
            numbers[9] * 5 +
            numbers[8] * 6 +
            numbers[7] * 7 +
            numbers[6] * 8 +
            numbers[5] * 9 +
            numbers[4] * 2 +
            numbers[3] * 3 +
            numbers[2] * 4 +
            numbers[1] * 5 +
            numbers[0] * 6 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[12] && dv2 == numbers[13]
    }
    
    /**
     Transforma a string para data, e de data para o formato desejado
     */
    func toDateString(inputFormat: String, outputFormat: String) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = outputFormat
        
        if let dateObj = dateObj {
            return dateFormatter.string(from: dateObj)
        } else {
            return self
        }
    }
    
    /**
     Retorna o valor float
     */
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    /**
     Retorna o valor inteiro
     */
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    
    /**
     Retorna o valor double
     */
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    /**
     Retorna o valor bool
     */
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    /**
     Converte float para String (R$ XXX,XX)
     */
    static func floatToBRLFormat(value val: Float) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: val)) ?? ""
    }
    
    /**
     Com isso você pode fazer string[0...3] para pegar os caracteres de 0 até 3
     */
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    func charAt(index i: Int) -> String{
        return self[i..<i+1]
    }
    
    /**
     Máscara de dinheiro dinâmica (deixa a vírgula duas casas do final). Adicionar código abaixo na view controller
     */
    
    //    func setupTextField() {
    //        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    //    }
    //
    //    @objc func myTextFieldDidChange(_ textField: UITextField) {
    //
    //        if let amountString = textField.text?.currencyInputFormatting() {
    //            textField.text = amountString
    //        }
    //    }
    
    func currencyInputFormatting(symbol: Bool = true) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        if symbol {
            formatter.currencySymbol = "R$"
        } else {
            formatter.currencySymbol = ""
        }
        
        var amountWithPrefix = self
        
        // remove from String: “$”, “.”, “,”
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    
    /**
     Transforma a string em um Date
     */
    func toDate(format: String? = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /**
     Para pegar string do localizable num contexto statico.
     */
    
    static func localized(withKey key: String) -> String {
   
        return "need to implement"
    }
    
    
    
    
    /*
     * VALIDAÇÕES
     */
    func isValidEmail() -> Bool {
        if(self.isEmpty) {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        // return true if email for valid
        return emailTest.evaluate(with: self)
    }
    
    /*
     isValidPhone Regex Explanation
     ^ - Início da string.
     \( - Um abre parênteses.
     [1-9]{2} - Dois dígitos de 1 a 9. Não existem códigos de DDD com o dígito 0.
     \) - Um fecha parênteses.
     - Um espaço em branco.
     (?:[2-8]|9[1-9]) - O início do número. Representa uma escolha entre o [2-8] e o 9[1-9]. O | separa as opções a serem escolhidas. O (?: ... ) agrupa tais escolhas. Telefones fixos começam com dígitos de 2 a 8. Telefones celulares começam com 9 e têm um segundo dígito de 1 a 9. O primeiro dígito nunca será 0 ou 1. Celulares não podem começar com 90 porque esse é o prefixo para ligações a cobrar.
     [0-9]{3} - Os demais três dígitos da primeira metade do número do telefone, perfazendo um total de 4 ou 5 dígitos na primeira metade.
     \- - Um hífen.
     [0-9]{4} - A segunda metade do número do telefone.
     $ - Final da string.
     */
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^\\([1-9]{2}\\) (?:[2-8]|9[1-9])[0-9]{3}\\-[0-9]{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    
    func isValidCEP() -> Bool {
        return self.contains("-") ? self.count == 9 : self.count == 8
    }
    
    func isValidCPF() -> Bool {
        return self.isCPF()
    }
    
    func isValidCNPJ() -> Bool {
        return self.isCNPJ()
    }
    
    func isValidName() -> Bool {
        return self.count > 4
    }
    
    func isValidBirthday(minAge: Int?, maxAge: Int?) -> Bool {
        if self.count == 10 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let birthday = dateFormatter.date(from: self) ?? Date()
            let yearsOld = Date().years(from: birthday)
            
            if(minAge != nil && maxAge != nil) {
                return yearsOld >= minAge! && yearsOld <= maxAge!
            } else if (minAge != nil) {
                return yearsOld >= minAge!
            } else if (maxAge != nil) {
                return yearsOld <= maxAge!
            } else {
                return yearsOld > 0
            }
        }
        
        return false
    }
    
    func isEmpty() -> Bool {
        return self.count == 0
    }
    
    func isValidCreditCardDate() -> Bool{
        return isValidBirthday(minAge: 0, maxAge: nil)
    }
    
}

extension Optional where Wrapped == String {
    func isNullOrEmpty() -> Bool {
        return self == nil || self?.count == 0
    }
}
