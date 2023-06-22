import SwiftUI

struct FavouriteFood: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView{
            List{

            }.navigationTitle("Избранное").listStyle(GroupedListStyle())
        }
    }
}

struct FavouriteFood_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        FavouriteFood().environmentObject(order)
    }
}
