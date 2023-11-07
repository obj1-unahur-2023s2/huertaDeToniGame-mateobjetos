import wollok.game.*
import elementos.*
import barraVidas.*


object batallaEspacial {
	method iniciarJuego(){
		self.generarPantalla()
		principal.aparecer()
		barraDeVidas.barra(principal)
		principal.mover()
		game.onCollideDo(principal, {p=>p.perderVida()})
		self.generarMarcador()
		self.generarPiedras()
		self.generarNavesEnemigas()
		self.generarVidasExtra()
		self.generarEnemigoPoderoso()
	}
	
	method generarPantalla(){
		game.height(12)
		game.width(20)	
		game.title("Batalla Espacial")
		game.boardGround("fondojuego.png")
		musica.play()
	}
	
	method generarPiedras(){
		game.onTick(3500,"aparecer piedras", {new Piedra(image = "icons8-meteorite-48.png", position = self.positionAleatoria()).aparecer()})
	}
	
	method generarNavesEnemigas(){
		game.onTick(3000,"aparecer naves enemigas", {new Enemiga(image = "naveEnemiga.png" , position = self.positionAleatoria()).aparecer()})
	}
	
	method generarVidasExtra(){
		game.onTick(8000,"aparecer vidas extras", {new VidaExtra(image = "icons8-me-gusta-64.png", position = self.positionAleatoria()).aparecer()})
	}
	method generarEnemigoPoderoso(){
		game.onTick(6500,"aparecer naves enemigas", {new EnemigaPoderosa(image = "icons8-space-fighter-80.png", position = self.positionAleatoria()).aparecer()})
	}
	
	method positionAleatoria() = game.at((0.randomUpTo(game.width())), 10)
	
	//////////////////GENERAR NUMEROS///////////////////////
	method generarMarcador(){
		const unidadPuntaje = new Unidad(elementoActual = principal.puntaje(),position = game.at(8,game.height()-1))
		const decenaPuntaje = new Decena(elementoActual = principal.puntaje(),position = game.at(0,0))
		const numeroPuntaje = new Numero(decena = unidadPuntaje, unidad = decenaPuntaje)
		numeroPuntaje.mostrar()	
		}
	}

object musica{
	var property mus = game.sound("musicaJuego (online-audio-converter.com).mp3")
	method play(){
		mus.shouldLoop(true)
		game.schedule(500, { mus.play()} )
	}
	method pause(){
		mus.pause()
	}
	method resume(){
		mus.resume()
	}
		
}

