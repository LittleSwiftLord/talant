import SwiftUI

struct ContentView: View {
    
    let menu = Bundle.main.decode([MenuSection].self
                                  , from: "menu.json")
    
    var body: some View {
        NavigationView{
            List{
                ForEach(menu){ section in
                    Section(header: Text(section.name).foregroundColor(.green)){
                       
                        ForEach(section.items){ item in
                        ItemRow(item: item)
                       }
                }
            }
            }
            .navigationTitle("Меню")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
