import wollok.game.*

class Elemento {
	var image
	var position 
	
	method image() = image
	
	method position() = position
	
	method aparecer(){
		game.addVisualCharacter(self)
		self.avanzar()
	}	
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method avanzar(){
		game.onCollideDo(self, {elemento => elemento.desaparecer()})
		game.onTick(250, "bola", {self.avanzarSiNoHayObstaculo()})
	}
	
	method avanzarSiNoHayObstaculo(){
		position = position.down(1)
		if(position.x() > game.width()){
			game.removeTickEvent("bola")
			self.desaparecer()
		}
	}
}


class Piedra inherits Elemento{

}

class VidaExtra inherits Elemento{
	
}

class Vida inherits VidaExtra{
	
	method colocarVidaEn(x, y){
		position = game.at(x,y)
	}
	
}

class Disparo inherits Elemento{
	
}

class Nave inherits Elemento {
	var vidas = 3
	
	method perderVida(){}
	
}

class Principal inherits Nave{
	
	method derecha(){
		if (position.x() < game.width() - 1){
			position = position.right(1)
		}
	}
	
	method izquierda(){
		if (position.x() > 0){
			position = position.left(1)
		}	
	}
	
	method disparar(){
		const ataque = new Disparo(image = disparoImg.imagen(), position = position.up(1))
		game.addVisual(ataque)
		ataque.avanzar()
	}
	
	override method avanzar(){
		keyboard.right().onPressDo({self.derecha()})
		keyboard.left().onPressDo({self.izquierda()})
		keyboard.space().onPressDo({self.disparar()})
	}
	
	method agarrarVida(){
		
	}
}


class Enemiga inherits Nave{
	
}

object disparoImg{
	
	method imagen() = "icons8-bala-16.png"
}


