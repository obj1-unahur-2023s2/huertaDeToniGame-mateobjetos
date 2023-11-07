import wollok.game.*

object batallaEspacialN {

    method iniciar() {
        self.generarPantalla()
        self.generarPiedras()
        self.generarNavesEnemigas()
        self.generarVidasExtra()
        tableroVidas.aparecer()
        navePrincipal.aparecerYMover()
		
    }
    
    method generarPantalla(){
		game.height(12)
		game.width(20)	
		game.title("Batalla Espacial")
		game.boardGround("fondojuego.png")
		musica.play()
	}
    
    method generarPiedras(){
		game.onTick(3500,"aparecer piedras", {new Piedra(image = "icons8-meteorite-48.png", position = self.positionAleatoria()).aparecerYMover()})
	}
	
	method generarNavesEnemigas(){
		game.onTick(3000,"aparecer naves enemigas", {new Nave(image = "naveEnemiga.png" , position = self.positionAleatoria()).aparecerYMover()})
	}
	
	method generarVidasExtra(){
		game.onTick(8000,"aparecer vidas extras", {new VidaExtra(image = "icons8-me-gusta-64.png", position = self.positionAleatoria()).aparecerYMover()})
	}

    method positionAleatoria() = game.at((0.randomUpTo(game.width())), 10)
    
    method terminarJuego(){
		game.clear()
		game.boardGround("game over.jpg")
	}	
}
	
object navePrincipal {
	var image = "naveAliada.png"
	var position = game.origin()
	var vidas = 4

	method vidas() = vidas
	method restarVidas(){
		vidas = vidas - 1
	} 
	method sumarVidas() {
		vidas = 4.max(vidas + 1)
	}
	method image() = image
	method position() = position
	
	method aparecer(){
		game.addVisualCharacter(self)
	}
    
    method efectoChoqueResta(){
    	self.restarVidas()
    	if(vidas == 0){
    		self.desaparecer()
    		batallaEspacialN.terminarJuego()
    	}
	}
	

	method efectoChoqueSuma(){
		self.sumarVidas()
	}
	
	method desaparecer(){
		game.removeVisual(self)
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
	
	method mover(){
		keyboard.right().onPressDo({self.derecha()})
		keyboard.left().onPressDo({self.izquierda()})
		keyboard.space().onPressDo({self.disparar()})
	}
	
	method disparar(){
		const ataque = new Disparo(image = disparoImg.imagen(), position = position.up(1))
		game.addVisual(ataque)
		ataque.mover()
	}
	
	method aparecerYMover(){
		self.aparecer()
		self.mover()		
	}
}

object tableroVidas{
	var image = "4_vidas.png"
	const position = game.at(8,game.height()-1)
	
	method image() = image
	method position() = position
	method aparecer(){
		game.addVisualCharacter(self)
	}	
	
	method cambiarImg(){
		if(navePrincipal.vidas() == 4){
			image = "4_vidas.png"
		}else if(navePrincipal.vidas() == 3){
			image = "3_vidas.png"
		}else if(navePrincipal.vidas() == 2){
			image = "2_vidas.png"
		}else if(navePrincipal.vidas() == 1){
			image = "1_vidas.png"
		}else{
			image = "0_vidas.png"
		}
    }
}

class Elemento{
	var image = null
	var position = null
	
	method cambiarImg(nuevaImagen){
		image = nuevaImagen
	}
	
	method position() = position
	
	method image() = image
	
	method aparecer(){
		game.addVisualCharacter(self)
	}	
	method mover(){
		game.onTick(250, "movimiento", {self.avanzarSiNoHayObstaculo()})
	}
	
	method avanzarSiNoHayObstaculo(){
		position = position.down(1)
		if(position.x() > game.width()){
			game.removeTickEvent("movimiento")
			self.desaparecer()
		}
	}
	
	method efectoColicion(){}
	
	method aparecerYMover(){
		self.aparecer()
		self.mover()
		self.efectoColicion()
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
}

class Nave inherits Elemento{
    override method efectoColicion(){
    	tableroVidas.cambiarImg()
    	game.onCollideDo(navePrincipal, {elemento => navePrincipal.efectoChoqueResta()})
    	game.onCollideDo(self, {elemento => self.desaparecer()})
    }
}

class Piedra inherits Elemento{
    override method efectoColicion(){
    	tableroVidas.cambiarImg()
    	game.onCollideDo(navePrincipal, {elemento => navePrincipal.efectoChoqueResta()})
    	game.onCollideDo(self, {elemento => self.desaparecer()})
    }
}

class VidaExtra inherits Elemento{
     override method efectoColicion(){
     	tableroVidas.cambiarImg()
    	game.onCollideDo(navePrincipal, {elemento => navePrincipal.efectoChoqueSuma()})
    	game.onCollideDo(self, {elemento => self.desaparecer()})
    }
}

class Disparo inherits Elemento{
	override method avanzarSiNoHayObstaculo(){
		position = position.up(1)
		if(position.x() > game.width()){
			game.removeTickEvent("elemento")
			self.desaparecer()
		}
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

object disparoImg{
	method imagen() = "icons8-bala-16.png"
}