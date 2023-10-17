import wollok.game.*

object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	
	// Pegar acá todo lo que tenían de Toni en la etapa 1
	
	method moverArriba(){
		position = position.up(1)
	}
	
	method moverAbajo(){
		position = position.down(1)
	}
	
	method moverDer(){
		if(position.x() <= game.width() - 1){
			position = position.right(1)
		} else {
			self.position(game.at(0,position.y()))
		}

	}
	method moverIzq(){
		position = position.left(1)
	}
}