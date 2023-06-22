import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            ContentView().tabItem {
                Image(systemName: "book.closed")
                Text("Меню")
            }
            OrderView().tabItem {
                Image(systemName: "square.and.pencil")
                Text("Заказы")
            }
            FavouriteFood().tabItem {
                Image(systemName: "suit.heart")
                Text("Избранное")
            }
        }.accentColor(.green)
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        AppView().environmentObject(order)
    }
}
