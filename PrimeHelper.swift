import Foundation

struct PrimeHelper {
    
    static func isPrime(_ number: Int) -> Bool {
        if number < 2 {
            return false
        }
        
        if number == 2 {
            return true
        }
        
        if number % 2 == 0 {
            return false
        }
        
        let limit = Int(Double(number).squareRoot())
        
        if limit < 3 {
            return true
        }
        
        for divisor in stride(from: 3, through: limit, by: 2) {
            if number % divisor == 0 {
                return false
            }
        }
        
        return true
    }
}
