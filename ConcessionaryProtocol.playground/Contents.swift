import UIKit

/// Car Brand Enumeration.
/// - audi: Audi brand, string raw value: "Audi".
/// - mercedes: Mercedes brand, string raw value: "Mercedes".
/// - volvo: Volvo brand, string raw value: "Volvo".
enum carBrand: String {
    case audi = "Audi"
    case mercedes = "Mercedes"
    case volvo = "Volvo"
}

/// Sort Order Enumeration.
/// - asc: Ascendent order.
/// - desc: Descendent order.
enum sortOrder {
    case asc
    case desc
}

/// Dealership Properties and Actions.
protocol DealershipProtocol {
    var brand: carBrand { get set }
    var catalog: Array<Car> { get set }
    
    func add(newCars: Array<Car>)
    func showCatalog()
    func sortCatalog(order: sortOrder) -> Array<Car>
}

/// Basic Car Structure.
struct Car {
    /// Car Model.
    var model: String
    
    /// Car Price.
    var price: Double
    
    /// Car Initialization Method.
    /// - Parameter model: String Car Model Name.
    /// - Parameter price: Double Car Price.
    init(model: String, price: Double) {
        self.model = model
        self.price = price
    }
    
    /// Description About this Car Structure.
    func description() {
        print("Car Model \(self.model), Starting at: \(self.price)€")
    }
}

/// Customizable Dealership Model, Following the DealershipProtocol.
class Dealership: DealershipProtocol {
    /// Dealership Name.
    var name: String
    
    /// Dealership initialization Method.
    /// - Parameter name: String Dealership Name.
    /// - Parameter brand: carBrand Dealerhip Brand.
    init(name: String, brand: carBrand) {
        self.name = name
        self.brand = brand
    }
    
    // DealershipProtocol Implementation.
    /// Dealership Brand.
    var brand: carBrand
    /// Dealership Catalog.
    lazy var catalog: Array<Car> = []
    
    /// Method for Add New Cars in to the Dealership.
    /// - Parameter newCars: Cars Array.
    func add(newCars: Array<Car>) {
        newCars.forEach { (car) in
            self.catalog.append(car)
        }
    }
    
    /// Print on Console the Catalog Cars Description.
    /// If the Catalog is Empty, this Method does not Show Any Car Description.
    func showCatalog() {
        guard !self.catalog.isEmpty else {
            print("This Dealership does not have any Vehicle")
            return
        }
        
        print("--\(self.name) Catalog, Your \(self.brand.rawValue) Dealership--")
        self.catalog.forEach { (coche) in
            coche.description()
        }
    }
    
    /// Short the Dealership Catalog following the sortOrder Enumeration.
    /// - Parameter order: Sort Order Enumeration.-
    func sortCatalog(order: sortOrder) -> Array<Car> {
        return self.catalog.sorted{ (el1, el2) -> Bool in
            order == sortOrder.asc ? el1.price < el2.price : el1.price > el2.price
        }
    }
}

let dealership = Dealership.init(name: "Fresneda", brand: .volvo)
dealership.add(newCars:
    [
        Car.init(model: "V60", price: 30000),
        Car.init(model: "V90", price: 50000),
        Car.init(model: "XC40", price: 40000)
    ]
)
dealership.showCatalog()

print("\n--Sorted ASC--")
dealership.sortCatalog(order: .asc ).forEach { (car) in
    car.description()
}

print("\n--Sorted DES--")
dealership.sortCatalog(order: .desc ).forEach { (car) in
    car.description()
}
