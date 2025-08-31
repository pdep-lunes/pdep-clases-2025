object bobEsponja{

	var energia = 1000
	var dinero = 10000
	var nivelDeFelicidad = 100

	method estaListo() =  true

	method comerCangreburguer(){
		energia =+ 1000 * nivelDeFelicidad
  }

  method propina() {
    if (energia > 600) {
      return energia * 10
    } else {
      return 100
    }
  }

}

object patricio {
  var dinero = 0
  var masaMuscular = 40
	
  method comerCargreburger() {
		masaMuscular += 10
  }

  method propina() = dinero
}

object calamardo {
	var dinero = 5000
	var horasDeSuenio = 5
	
  method estaListo() = horasDeSuenio.even() 
  method comerCangreburguer(){}

  method propina() = 0

}

object donCangrejo{
  var dinero = 1000000
  var dineroGastadoEnPerlita = 500000

  method llevarseComision(precio){
    const mitadDePrecio = precio.div(2)
    dinero += mitadDePrecio
    dineroGastadoEnPerlita += mitadDePrecio
  }


}

object crustaceoCascarudo{
	var empleado = calamardo
	const precioCangreburger = 1000
	var nivelDeLimpieza = 100

	method  estaListoParaAbrir(){
		return empleado.estaListo() && self.estaLimpio()
  }

  method estaLimpio() = nivelDeLimpieza.between(50, 95)

  method cobrarCangreburger(personaje){
    donCangrejo.llevarseComision(self.precioFinal(personaje))
    personaje.comerCangreburger()
  }
  method precioFinal(personaje){
    return  precioCangreburger + personaje.propina()
  }

  method empleado(nuevoEmpleado){
    empleado = nuevoEmpleado
  }
}

