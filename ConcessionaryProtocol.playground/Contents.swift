import UIKit


enum marcaEnum: String {
    case audi = "Audi"
    case mercedes = "Mercedes"
    case volvo = "Volvo"
}

enum sortOrder {
    case asc, desc
}

protocol ConcesionarioProtocol {
    var marca: marcaEnum { get set }
    var catalogo: Array<Coche> { get set }
    
    func setCoche(_coches: Array<Coche>)
    func mostrarCatalogo()
    func sortCatalogo(order: sortOrder) -> Array<Coche>
}

class Coche {
    var modelo: String
    var precio: Double

    init(_modelo: String, _ _precio: Double) {
        self.modelo = _modelo
        self.precio = _precio
    }
    
    func description() {
        print("Coche modelo \(self.modelo), desde: \(self.precio)€")
    }
}

class Concesionario: ConcesionarioProtocol {
    var nombre: String
    
    init(_nombre: String, _marca: marcaEnum) {
        self.nombre = _nombre
        self.marca = _marca
        self.catalogo = Array()
    }
    
    // PROTOCOL
    var marca: marcaEnum
    var catalogo: Array<Coche>
    
    func setCoche(_coches: Array<Coche>) {
        _coches.forEach { (nuevoCoche) in
            self.catalogo.append(nuevoCoche)
        }
    }
    
    func mostrarCatalogo() {
        print("--Catálogo del concesionario \(self.nombre), tu concesionario \(self.marca.rawValue)--")
        self.catalogo.forEach { (coche) in
            coche.description()
        }
    }
    
    func sortCatalogo(order: sortOrder) -> Array<Coche> {
        return self.catalogo.sorted{ (el1, el2) -> Bool in
            order == sortOrder.asc ? el1.precio < el2.precio : el1.precio > el2.precio
        }
    }
}

let concesionario = Concesionario.init(_nombre: "Fresneda", _marca: .volvo)
concesionario.setCoche(_coches:
    Array.init(
        arrayLiteral:
        Coche.init(_modelo: "V60", 30000),
        Coche.init(_modelo: "V90", 50000),
        Coche.init(_modelo: "XC40", 40000)
    )
)
concesionario.mostrarCatalogo()

print("\n--Sorted ASC--")
concesionario.sortCatalogo(order: .asc ).forEach { (coche) in
    coche.description()
}

print("\n--Sorted DES--")
concesionario.sortCatalogo(order: .desc ).forEach { (coche) in
    coche.description()
}
