import SwiftUI

struct NoFullAccessView: View {
    let settingsAction: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("TapCounter keyboard needs full access to function properly.")
                .multilineTextAlignment(.center)

            Text("Please go to device Settings -> TapCounter -> Keyboards -> Allow Full Access")
                .multilineTextAlignment(.center)

            Button("Go to Settings", action: settingsAction)
        }
        .padding([.leading, .trailing])
    }
}
