import wollok.game.*

class Elemento {
	var image = null
	var position = null
	
	method colocarImagen()
	
	method colocarPosicion()
	
	method image() = image
	
	method position() = position
	
	method aparecer(){
		self.colocarImagen()
		self.colocarPosicion()
		game.addVisualCharacter(self)
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
	
	method aparecerYAvanzar(){
		self.aparecer()
		self.avanzar()
	}
	
	method positionAleatoria() = game.at((0.randomUpTo(game.width())), 10)
}


class Piedra inherits Elemento{
	
	override method colocarImagen(){
		image = "icons8-meteorite-48.png"
	}
	
	override method colocarPosicion(){
		position = self.positionAleatoria()
	}

}

class VidaExtra inherits Elemento{
	
	override method colocarImagen(){
		image = "icons8-me-gusta-64.png"
	}
	
}

class Vida inherits VidaExtra{
	
	method colocarVidaEn(x, y){
		position = game.at(x,y)
	}
}

class Disparo inherits Elemento{
	
	override method colocarImagen(){
		image = "icons8-bala-16.png"
	}
	
	override method colocarPosicion(){
		position = position.up(1)
	}
}

