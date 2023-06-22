import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    static let deliveryTimes = ["Утром","Полдник","Обед","Вечер"]
    static let paymentTypes = ["Начиными","Картой при получении"]
    static let tipAmounts = [0,10,15,20,25]
    static let deliverySpeeds = ["Обычная","Экспресс"]
    
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount =  1
    @State private var deliveryTime = 0
    @State private var deliverySpeed = 0
    @State private var showAlert = false
    
    var time:String{
        let times = String(CheckoutView.deliveryTimes[deliveryTime])
        return times
    }
    
    var deliveryCharge: Double {
        if CheckoutView.deliverySpeeds[deliverySpeed] == "Экспресс" {
            let total = Double(order.total)
            return total/100 * 20
        }
        else{
            return 0
        }
    }
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total/100 * Double(CheckoutView.tipAmounts[tipAmount])
        
       return total + tipValue + deliveryCharge
    }
    
    var body: some View {
        Form{
            Section{
                Picker("Вид оплаты", selection: $paymentType){
                    ForEach(0 ..< CheckoutView.paymentTypes.count){
                        Text(CheckoutView.paymentTypes[$0])
                    }
                }
//                Toggle(isOn: $addLoyaltyDetails.animation()){
//                    Text("Add DineIN Loyalty Card")
//                }
//                if addLoyaltyDetails{
//                    TextField("Add DineIN Card ID", text: $loyaltyNumber)
//                }
            }
            Section(header: Text("В какое время привезти заказ?").foregroundColor(.green)){
                Picker("", selection: $deliveryTime){
                    ForEach(0 ..< CheckoutView.deliveryTimes.count){
                        Text("\(CheckoutView.deliveryTimes[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Тип доставки").foregroundColor(.green)){
                Picker("", selection: $deliverySpeed){
                    ForEach(0 ..< CheckoutView.deliverySpeeds.count){
                        Text("\(CheckoutView.deliverySpeeds[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Text("Стоимость эскпресс заказа на 20% on больше").font(.caption).foregroundColor(.gray)
            }
            
            Section(header: Text("Добавить чаявые").foregroundColor(.green)){
                Picker("Процент:",selection: $tipAmount){
                    ForEach(0 ..< CheckoutView.tipAmounts.count){
                        Text("\(CheckoutView.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header:
                        Text("В итоге: \(totalPrice, specifier: "%.2f")").foregroundColor(.green).font(.largeTitle)
            ){
                Button(action:{self.showAlert.toggle()}){
                    HStack{
                        Image(systemName: "flame.fill")
                        Text("Подтвердить заказ")
                    }.padding(.leading, 100)
                }.foregroundColor(.green)
            }
            
        }.navigationBarTitle(Text("Оплата"), displayMode: .inline)
        .alert(isPresented: $showAlert){
            Alert(title: Text("Заказ принят"), message: Text("Общая стоимость заказа: \(totalPrice, specifier: "%.2f"), доставка будет совершена - \(time)- Спасибо за использование ORIMI"), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
