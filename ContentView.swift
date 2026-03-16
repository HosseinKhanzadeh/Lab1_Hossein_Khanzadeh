import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Prime Number Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Decide whether the number shown is prime.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text("17")
                .font(.system(size: 72, weight: .bold))
            
            HStack(spacing: 20) {
                
                Button("Prime") {
                    
                }
                .frame(width: 120, height: 50)
                .background(Color.green.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Not Prime") {
                    
                }
                .frame(width: 120, height: 50)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            Spacer()
            
            VStack {
                Text("Correct: 0")
                Text("Wrong: 0")
            }
            .font(.headline)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
