import SwiftUI

struct ContentView: View {
    
    @State private var currentNumber: Int = 0
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Prime Number Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Decide whether the number shown is prime.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text("\(currentNumber)")
                .font(.system(size: 72, weight: .bold))
            
            HStack(spacing: 20) {
                
                Button("Prime") {
                    checkPrimeSelection()
                }
                .frame(width: 120, height: 50)
                .background(Color.green.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Not Prime") {
                    checkNotPrimeSelection()
                }
                .frame(width: 120, height: 50)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            Spacer()
            
            VStack {
                Text("Correct: \(correctAnswers)")
                Text("Wrong: \(wrongAnswers)")
            }
            .font(.headline)
            
        }
        .padding()
        .onAppear {
            generateRandomNumber()
        }
    }
    
    private func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    private func checkPrimeSelection() {
        if PrimeHelper.isPrime(currentNumber) {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
    }
    
    private func checkNotPrimeSelection() {
        if !PrimeHelper.isPrime(currentNumber) {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
    }
}

#Preview {
    ContentView()
}
