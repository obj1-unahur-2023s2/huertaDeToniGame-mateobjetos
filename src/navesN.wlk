import elementosN.*
import wollok.game.*

class Nave inherits Elemento {
	var vidas = 3
	
	method perderVida()
	
}

class Principal inherits Nave{
	
	override method colocarImagen(){
		image = "naveAliada.png"
	}
	
	method moverDerecha(){
		if (position.x() < game.width()-1){
			position = position.right(1)
		}
	}
	
	method moverIzquierda(){
		if (position.x() > 0){
			position = position.left(1)
		}	
	}
	
	method disparar(){
		const ataque = new Disparo()
		game.addVisual(ataque)
		ataque.avanzar()
	}
	
	override method avanzar(){
		keyboard.right().onPressDo({self.moverDerecha()})
		keyboard.left().onPressDo({self.moverIzquierda()})
		keyboard.space().onPressDo({self.disparar()})
	}
	
	method agarrarVida(){
		
	}
}

class Enemiga inherits Nave{
	
	override method colocarImagen(){
		image = "naveEnemiga.png"
	}
	
	override method colocarPosicion(){
		position = self.positionAleatoria()
	}
}