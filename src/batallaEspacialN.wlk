import wollok.game.*
import elementosN.*

object batallaEspacialN {
	method iniciarJuego(){
		self.generarPantalla()
		const player1 = new Principal(image = "naveAliada.png", position = game.origin())
		player1.aparecer()
		self.generarPiedras()
		self.generarNavesEnemigas()
		self.generarVidasExtra()
	}
	
	method generarPantalla(){
		game.height(12)
		game.width(20)	
		game.title("Batalla Espacial")
		game.boardGround("fondojuego.png")
	}
	
	method generarPiedras(){
		game.onTick(3500,"aparecer piedras", {new Piedra(image = "icons8-meteorite-48.png", position = self.positionAleatoria()).aparecer()})
	}
	
	method generarNavesEnemigas(){
		game.onTick(3500,"aparecer naves enemigas", {new Enemiga(image = "naveEnemiga.png" , position = self.positionAleatoria()).aparecer()})
	}
	
	method generarVidasExtra(){
		game.onTick(3500,"aparecer naves enemigas", {new VidaExtra(image = "icons8-me-gusta-64.png", position = self.positionAleatoria()).aparecer()})
	}
	
	method positionAleatoria() = game.at((0.randomUpTo(game.width())), 10)
}