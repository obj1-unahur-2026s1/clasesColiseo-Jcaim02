class ArmaDeFilo{
  const filo
  const longitud
  method valorAtaque() =  filo * longitud
}
class ArmaContundente{
  const pesoDelArma
  method valorAtaque() = pesoDelArma
}
object casco {
  method puntosDeArmadura(unGladiador)= 20
}
object escudo{
  method puntosDeArmadura(unGladiador)= 5 + unGladiador.destreza() * 0.10
}
class Gladiador{
  var vida = 100
  method fuerza()
  method destreza()
  method defensa()
  method atacar(ungladiador){
    ungladiador.perderVida(self)
  }
  method perdervida(unGladiador){
    vida -= (unGladiador.poderDeAtaque() - self.defensa())
  }
  method pelear(unGladiador){
    self.atacar(unGladiador)
    unGladiador.atacar(self)
  }
  method curar(){
    vida = 100
  }
}
class Mirmillon inherits Gladiador{
  var armaActual
  var armaduraActual
  var fuerza
  method cambiarArmaduraActual(nuevaArmadura){
    armaduraActual = nuevaArmadura
  }
  method cambiarArmaActual(nuevaArma){
    armaActual = nuevaArma
  }
  method cambiarFuerza(cantidad){
    fuerza = cantidad
  }
  override method fuerza() = fuerza
  override method destreza() = 15
  method poderDeAtaque() = armaActual.valorAtaque() + fuerza
  override method defensa() = armaActual.puntosDeArmadura(self) + self.destreza()
  method crearGrupoCon(unGladiador){
    return
    new Grupo( 
      nombreDelGrupo = "mirmillolandia" ,
      miembrosDelGrupo = #{self,unGladiador})
  }
}
class Dimachaerus inherits Gladiador{
  const arma = []
  var destreza 
  override method fuerza() = 10
  override method destreza() = destreza
  method añadirArma(nuevaArma){
    arma.add(nuevaArma)
  }
  method dejarArma(unaArma){
    arma.remove(unaArma)
  }
  method poderDeAtaque() = self.fuerza() + arma.sum({p => p.valorAtaque()})
  override method atacar(unGladiador){
    super(unGladiador)
    destreza += 1
  }
  override method defensa() = destreza / 2
  method crearGrupoCon(unGladiador){
    return
    new Grupo( 
      nombreDelGrupo = "D-" + (self.poderDeAtaque() + unGladiador.poderDeAtaque()).toSting() ,
      miembrosDelGrupo = #{self,unGladiador})
  }
}
class Grupo {
  const property miembrosDelGrupo = #{}
  const property nombreDelGrupo 
  var cantidadDePeleas = 0
  method agregarGladiador(unGladiador){
    miembrosDelGrupo.add(unGladiador)
  }
  method quitarGladiador(unGladiador){
    miembrosDelGrupo.remove(unGladiador)
  }
  method puedeLuchar(){
    return miembrosDelGrupo.filter({p => p.vida() > 0})
  }
  method campeon(){
    return miembrosDelGrupo.puedeLuchar().max({p => p.poderDeAtaque()})
  }
  method combatirCon(unGrupo){
    self.campeon().pelear(unGrupo.campeon())
    self.campeon().pelear(unGrupo.campeon())
    self.campeon().pelear(unGrupo.campeon())
  }
}
object coliseo {
  method realizarCombate(grupo1,grupo2){
    grupo1.combatirCon(grupo2)
  }
  method gladiadorVSgrupo(unGrupo,unGladiador){
    unGrupo.miembrosDelGrupo().forEach({p => p.pelear(unGladiador)})
  }
  method curarGrupo(unGrupo){
    unGrupo.miembrosDelGrupo().forEach({p => p.curar()})
  }
  method curarGladiador(unGladiador){
        unGladiador.curar()
  }

}
