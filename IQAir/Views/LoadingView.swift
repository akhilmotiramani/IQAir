import SwiftUI  // Import the SwiftUI framework

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text("loading...")
            .padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the LoadingView
        LoadingView()
    }
}
