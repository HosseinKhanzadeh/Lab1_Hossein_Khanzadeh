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
    
    private var summaryMessage: String {
        "Correct answers: \(correctAnswers)\nWrong answers: \(wrongAnswers)"
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                
                VStack(spacing: 6) {
                    Text("Prime Number Game")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(primaryAccentColor)
                    
                    Text("Decide whether the number shown is prime.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding(.top, 16)
                
                Text("Time Left: \(timeRemaining)s")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(timerBadgeColor)
                    .clipShape(Capsule())
                    .shadow(color: timerBadgeColor.opacity(0.4), radius: 3, x: 0, y: 2)
                
                VStack(spacing: 16) {
                    Text("\(currentNumber)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(primaryAccentColor)
                    
                    Text("Is this number prime?")
                        .font(.headline)
                        .foregroundColor(primaryAccentColor.opacity(0.9))
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 32)
                .background(cardBackgroundColor)
                .cornerRadius(24)
                .shadow(color: primaryAccentColor.opacity(0.18), radius: 8, x: 0, y: 4)
                
                HStack(spacing: 20) {
                    
                    Button {
                        checkPrimeSelection()
                    } label: {
                        Text("Prime")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                    }
                    .background(primeButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(color: primeButtonColor.opacity(0.35), radius: 6, x: 0, y: 3)
                    .disabled(showSummaryAlert)
                    .opacity(showSummaryAlert ? 0.6 : 1.0)
                    
                    Button {
                        checkNotPrimeSelection()
                    } label: {
                        Text("Not Prime")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                    }
                    .background(secondaryButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(color: secondaryButtonColor.opacity(0.35), radius: 6, x: 0, y: 3)
                    .disabled(showSummaryAlert)
                    .opacity(showSummaryAlert ? 0.6 : 1.0)
                }
                .padding(.horizontal, 8)
                
                HStack(spacing: 8) {
                    if let wasLastAnswerCorrect {
                        Image(systemName: wasLastAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(wasLastAnswerCorrect ? .green : .red)
                        
                        Text(feedbackMessage)
                            .foregroundColor(wasLastAnswerCorrect ? .green : .red)
                            .font(.headline)
                            .fontWeight(.semibold)
                    } else {
                        Text(" ")
                    }
                }
                .frame(height: 32)
                
                Spacer()
                
                HStack(spacing: 16) {
                    VStack(spacing: 6) {
                        Text("Correct")
                            .font(.subheadline)
                            .foregroundColor(primaryAccentColor)
                        Text("\(correctAnswers)")
                            .font(.title2).bold()
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 6) {
                        Text("Wrong")
                            .font(.subheadline)
                            .foregroundColor(primaryAccentColor)
                        Text("\(wrongAnswers)")
                            .font(.title2).bold()
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(cardBackgroundColor)
                .cornerRadius(20)
                .shadow(color: primaryAccentColor.opacity(0.12), radius: 6, x: 0, y: 3)
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 20)
        }
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
            Text(summaryMessage)
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

// MARK: - Palette Helpers

private extension ContentView {
    var backgroundColor: Color {
        // #F1D8F8
        Color(red: 241 / 255, green: 216 / 255, blue: 248 / 255)
    }
    
    var primaryAccentColor: Color {
        // #533E89
        Color(red: 83 / 255, green: 62 / 255, blue: 137 / 255)
    }
    
    var primeButtonColor: Color {
        // #AC694D
        Color(red: 172 / 255, green: 105 / 255, blue: 77 / 255)
    }
    
    var secondaryButtonColor: Color {
        // Using #533E89 as a strong secondary action
        Color(red: 83 / 255, green: 62 / 255, blue: 137 / 255)
    }
    
    var timerBadgeColor: Color {
        // #D6B643
        Color(red: 214 / 255, green: 182 / 255, blue: 67 / 255)
    }
    
    var cardBackgroundColor: Color {
        // Softer card treatment based on #F1D8F8
        Color(red: 241 / 255, green: 216 / 255, blue: 248 / 255).opacity(0.9)
    }
}

#Preview {
    ContentView()
}
