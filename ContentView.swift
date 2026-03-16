import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var currentNumber: Int = 0
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var attemptCount: Int = 0
    @State private var feedbackMessage: String = ""
    @State private var wasLastAnswerCorrect: Bool? = nil
    @State private var timeRemaining: Int = 5
    @State private var showSummaryAlert: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Prime Number Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Decide whether the number shown is prime.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Time Left: \(timeRemaining)s")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.12))
                .cornerRadius(12)
            
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
                .disabled(showSummaryAlert)
                
                Button("Not Prime") {
                    checkNotPrimeSelection()
                }
                .frame(width: 120, height: 50)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(showSummaryAlert)
            }
            
            HStack(spacing: 8) {
                if let wasLastAnswerCorrect {
                    Image(systemName: wasLastAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(wasLastAnswerCorrect ? .green : .red)
                    
                    Text(feedbackMessage)
                        .foregroundColor(wasLastAnswerCorrect ? .green : .red)
                        .fontWeight(.semibold)
                } else {
                    Text(" ")
                }
            }
            .font(.headline)
            .frame(height: 30)
            
            Spacer()
            
            VStack(spacing: 8) {
                Text("Score")
                    .font(.headline)
                
                Text("Correct: \(correctAnswers)")
                Text("Wrong: \(wrongAnswers)")
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.12))
            .cornerRadius(16)
            
        }
        .padding()
        .onAppear {
            generateRandomNumber()
        }
        .onReceive(timer) { _ in
            guard !showSummaryAlert else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                handleTimeout()
            }
        }
        .alert("Round Summary", isPresented: $showSummaryAlert) {
            Button("OK") {
                prepareNextRoundAfterSummary()
            }
        } message: {
            Text("Correct answers: \(correctAnswers)\nWrong answers: \(wrongAnswers)")
        }
    }
    
    private func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    private func checkPrimeSelection() {
        handleAnswer(userThinksPrime: true)
    }
    
    private func checkNotPrimeSelection() {
        handleAnswer(userThinksPrime: false)
    }
    
    private func handleAnswer(userThinksPrime: Bool) {
        let actualIsPrime = PrimeHelper.isPrime(currentNumber)
        
        if userThinksPrime == actualIsPrime {
            correctAnswers += 1
            feedbackMessage = "Correct!"
            wasLastAnswerCorrect = true
        } else {
            wrongAnswers += 1
            feedbackMessage = "Wrong!"
            wasLastAnswerCorrect = false
        }
        
        attemptCount += 1
        checkForSummary()
        
        timeRemaining = 5
        generateRandomNumber()
    }
    
    private func handleTimeout() {
        wrongAnswers += 1
        feedbackMessage = "Time's up!"
        wasLastAnswerCorrect = false
        
        attemptCount += 1
        checkForSummary()
        
        timeRemaining = 5
        generateRandomNumber()
    }
    
    private func checkForSummary() {
        if attemptCount > 0 && attemptCount % 10 == 0 {
            showSummaryAlert = true
        }
    }
    
    private func prepareNextRoundAfterSummary() {
        feedbackMessage = ""
        wasLastAnswerCorrect = nil
        timeRemaining = 5
        generateRandomNumber()
    }
}

#Preview {
    ContentView()
}
