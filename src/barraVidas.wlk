import wollok.game.*
import elementos.*



object barraDeVidas {
	const property tipo = "interface"
	var property image = "4_vidas.png"
	var property position = game.at(1,game.height() - 1)
	method validarLugarLibre(){return true}
	method validarMovimiento(){return true}
	method vida(personaje) {return personaje.vidas()}
	method barra(personaje){
		if (self.vida(personaje) == 4) {
			self.image("4_vidas.png")
			game.addVisual(self)
		}
		else if(self.vida(personaje)==3) {
			self.image("3_vidas.png")
			game.addVisual(self)
		}
		else if(self.vida(personaje)==2) {
			self.image("2_vidas.png")
			game.addVisual(self)
		}
		else{
			self.image("1_vidas.png")
			game.addVisual(self)			
		}
	}
}

///////////////////////PUNTAJE///////////////////////////
///////////////////////////////////////////////////////A REVISAR PORQUE NECESITAMOS MAS QUE DOS UNIDADES
class Numeros{
	const property tipo = "interface"
	var property position = game.at(7,game.height() - 1)
	method colisionAccion(){}
	method validarLugarLibre(){return true}
	method validarMovimiento(){return true}
}

class Decena inherits Numeros{
	var property elementoActual
	var property image = numberConvert.getNumber(elementoActual)
	
	
	method actualiza(){
		self.image(numberConvert.getNumber(elementoActual))
	}
}

class Unidad inherits Numeros(position = position.right(1)){
	var property elementoActual
	var property image = numberConvert.getNumber(elementoActual)
	
	method actualiza(){
		self.image(numberConvert.getNumber(elementoActual))
	}
}

class Numero inherits Numeros {
	var property decena
	var property unidad

	method actualiza(cosa){
		decena.elementoActual(cosa)
		unidad.elementoActual(cosa)

		unidad.actualiza()
		decena.actualiza()

	}
	
	method mostrar(){
		
		game.addVisual(decena)
		game.addVisual(unidad)
	}
}


object numberConvert {
	method getNumber(numero){
		return "nro" + numero + ".png"
	}
}