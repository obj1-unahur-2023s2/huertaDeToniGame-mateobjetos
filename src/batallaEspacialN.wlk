import wollok.game.*
import navesN.*
import elementosN.*

object batallaEspacial {
	method iniciarJuego(){
		self.generarPantalla()
	}
	
	method generarPantalla(){
		game.height(12)
		game.width(20)	
		game.title("Batalla Espacial")
		game.boardGround("fondojuego.png")
	}
	
}
