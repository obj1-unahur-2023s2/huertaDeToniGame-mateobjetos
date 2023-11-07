import wollok.game.*

class Elemento {
	var image = null
	var position = null
	
	method image() = image
	
	method position() = position
	
	method aparecer(){
		game.addVisualCharacter(self)
		self.efectoChoque()
	}	
	method mover(){
		game.onTick(250, "elemento", {self.avanzarSiNoHayObstaculo()})
	}
	
	method desaparecer(principal, unElemento){
		game.removeVisual(self)
		principal.sumarPuntaje(unElemento.puntaje())
	}
	
	method efectoChoque(){
		game.onCollideDo(self, {elemento => elemento.desaparecer()})
		self.mover()
	}
	
	method avanzarSiNoHayObstaculo(){
		position = position.down(1)
		if(position.x() > game.width()){
			game.removeTickEvent("elemento")
			self.desaparecer(principal, unElemento)
		}
	}
}


/////////////////////////PRINCIPAL/////////////////////////
//////////////////////////////////////////////////////////
object principal inherits Elemento{
	var vidas = 4
	var puntaje = 0
	
	method puntaje() = puntaje
	
	
	method vidas() = vidas
	
	override method aparecer(){
		image = "naveAliada.png"
		position = game.origin()
		game.addVisualCharacter(self)
		self.efectoChoque()
	}
	
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
		ataque.mover()
	}
	
	override method mover(){
		keyboard.right().onPressDo({self.derecha()})
		keyboard.left().onPressDo({self.izquierda()})
		keyboard.space().onPressDo({self.disparar()})
	}
	
	method agregarVida(){
		vidas = 4.min(vidas+1)
	}
	
	method perderVida(){
		vidas = 0.max(vidas-1)
		if (vidas == 0){
			self.perderJuego()
		}
	}
	override method efectoChoque(){
		game.onCollideDo(self, {elemento => elemento.perderVida()})
	}
	
	override method desaparecer(principal, unElemento){
		game.removeVisual(self)
	}
	
	method perderJuego(){
		game.clear()
		game.height(12)
		game.width(20)	
		game.title("Batalla Espacial")
		game.boardGround("fondojuego.png")
	}
	method sumarPuntaje(unElemento){
		puntaje += unElemento.puntaje()
	}
}
////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////


class Piedra inherits Elemento{
	const puntaje = 500
	method puntaje() = puntaje
}

class VidaExtra inherits Elemento{
	
}

class Vida inherits VidaExtra{
	override method aparecer(){
		game.addVisualCharacter(self)
	}
}

class Disparo inherits Elemento{
	
	
	override method avanzarSiNoHayObstaculo(){
		position = position.up(1)
		if(position.x() > game.width()){
			game.removeTickEvent("elemento")
			self.desaparecer(principal, unElemento) ///NO SE PORQUE TOMA COMO MAL EL PARAMETRO
		}
	}
}

class Nave inherits Elemento {
	
}
class Enemiga inherits Nave{
	const puntaje = 1000
	method puntaje() = puntaje
}

class EnemigaPoderosa inherits Nave{
	var vida = 2
	const puntaje = 2000
	method vida() = vida
	method puntaje() = puntaje	
	override method efectoChoque(){
		game.onCollideDo(self, {elemento => elemento.perderVida()})
		self.mover()
		}
	method perderVida(){
		vida -= 1
		if(vida == 0){
			self.desaparecer(principal, unElemento)
		}
	}
}

object disparoImg{
	
	method imagen() = "icons8-bala-16.png"
}
