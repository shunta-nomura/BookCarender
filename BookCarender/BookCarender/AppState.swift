import Foundation
 
class AppState: ObservableObject {
    @Published var isNavigateToLoginView = false
    @Published var isNavigateToPasswordResetView = false

}
