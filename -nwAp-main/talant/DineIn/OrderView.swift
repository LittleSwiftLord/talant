import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(order.items){ item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                
                Section{
                    NavigationLink(destination: CheckoutView()){
                        Text("Заказ")
                    }.disabled(order.items.isEmpty)
                }
            }.navigationTitle("Выбранные товары").listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton().foregroundColor(.green))
        }
    }
    
    func deleteItems(at offsets: IndexSet){
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
