donatulibro
===========

Proyecto para HackForGood2014 U. Deusto


Instalar / Montar entorno de trabajo
====================================

Máquina virtual con Vagrant
---------------------------
* Instalar Vagrant y un proveedor como Virtualbox
* Instalar ssh. Si usas Windows, prueba con http://msysgit.github.io/ (asegúrate de que las herramientas como SSH se añaden al PATH).
* Entrar en la carpeta del proyecto y ejecutar `vagrant up`. Esto descargará una máquina virtual
* Entrar en la máquina virtual con `vagrant ssh`
* Arrancar la aplicación: `cd /vagrant && rails s`


Instalación manual
------------------
Vas a necesitar Ruby 2.0, Rails 4, Hobo 2.1 y sqlite. Te recomendamos usar Ubuntu 12.04 como base ;).

Para más información, puedes echar Puedes echar un vistazo a la receta de puppet en `environment/manifest.pp`.