import wollok.game.*

class Disparo{
	var image = "icons8-bala-16.png"
	var position
			
	method image() = image
		
	method position() = position
		
	method avanzar(){
		game.onCollideDo(self, {algo => algo.desaparecer()})
		game.onTick(250, "bola", {self.avanzarSiNoHayObstaculo()})
	}
		
	method avanzarSiNoHayObstaculo(){
		position = position.up(1)
		
		if(position.x() > game.width()){
			game.removeTickEvent("bola")
			game.removeVisual(self)
		}
	}
	
		method desaparecer(){
		game.removeVisual(self)
	}
}

class Piedra{
	var image = "icons8-meteorite-48.png"
	var position 
	
	method image() = image
	method position() = position
		/*method positionAleatoria() = game.at(
			14,	0.randomUpTo(game.width()))*/
	method aparecer(){
			game.addVisualCharacter(self)
			self.avanzar()	
		}	
	method desaparecer(){
			game.removeVisual(self)
		}
	method avanzar(){
			game.onCollideDo(self, {algo => algo.desaparecer()})
			game.onTick(250, "bola", {self.avanzarSiNoHayObstaculo()})
	}
	method avanzarSiNoHayObstaculo(){
		position = position.down(1)
		if(position.x() > game.width()){
			game.removeTickEvent("bola")
			game.removeVisual(self)
		}
	}
	method perderVida(){
		self.desaparecer()
	}
}

class VidaExtra{
	const image = "icons8-me-gusta-64.png"
	var position 
	
	method image() = image
	
	method position() = position
		/*method positionAleatoria() = game.at(
			14,	0.randomUpTo(game.width()))*/
	
	method aparecer(){
		game.addVisualCharacter(self)
		self.avanzar()	
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
		
	method avanzar(){
		//game.onCollideDo(self, {elemento => elemento.desaparecer()})
		game.onTick(250, "bola", {self.avanzarSiNoHayObstaculo()})
	}
	
	method avanzarSiNoHayObstaculo(){
		position = position.down(1)
		
		if(position.x() > game.width()){
			game.removeTickEvent("bola")
			game.removeVisual(self)
		}
	}
		
	method perderVida(){
		self.desaparecer()
	}
}

class Vida{
	const image = "icons8-me-gusta-64.png"
	var position
	method position() = position
	
	method image() = image
	method vida1(){
		position = game.at(game.height()-1,0)
	}
	method vida2(){
		position = game.at(game.height()-1,1)
	}
	method vida3(){
		position = game.at(game.height()-1,2)
	}
	method aparecer(){
		game.addVisualCharacter(self)	
	}
	method desaparecer(){
		game.removeVisual(self)
	}
}
object vidaCartel{
	const image = "Sin título.png"
	const position = game.at(0,11)
	method image() = image
	method position() = position
	method aparecer(){
		game.addVisualCharacter(self)	
}

class Nave{
	var vidas = 3
	var image = "naveAliada.png"
	var position = game.origin()
	
	method image() = image 
	
	method position() = position
	
	method vidas() = vidas
	
	method perderVida(){}
	
	method aparecer(){
		game.addVisualCharacter(self)
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method avanzar()
		
}

class Principal inherits Nave{
	
	override method perderVida(){
		if(vidas == 3){
			vidas -= 1
			vida3.desaparecer()
		}
		if(vidas == 2){
			vidas -= 1
			vida2.desaparecer()
		}
		else{
			game.clear()
		}
	}
		
	method agarrarVida(){
		if(vidas == 1){
			vidas +=1
			const vida2 = new Vida(position=game.at(4,11)).aparecer()
		}
		if(vidas == 2){
			vidas +=1
			const vida3 = new Vida(position=game.at(5,11)).aparecer()
		}
	}
		
	method disparar(){
		const ataque = new Disparo(position= position.up(1))
		game.addVisual(ataque)
		ataque.avanzar()
	}
	
	
	method derecha(){
		if (position.x() < game.width()-1){
			position = position.right(1)
		}
	}
			
	method izquierda(){
		if (position.x() > 0){
			position = position.left(1)
		}	
	}
	override method avanzar(){
		keyboard.right().onPressDo({self.derecha()})
		keyboard.left().onPressDo({self.izquierda()})
		keyboard.space().onPressDo({self.disparar()})
	}
}
	
class Enemiga inherits Nave{
		
	method cambiarImagenAEnemiga(){
		image = "naveEnemiga.png"
	}
	
	override method aparecer(){
		self.cambiarImagenAEnemiga()
		position = self.positionAleatoria()
		super()
		self.avanzar()	
	}
		
	override method avanzar(){
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
	method positionAleatoria() = game.at((0.randomUpTo(game.width())), 10)
}

