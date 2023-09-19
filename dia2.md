# Cómo solicito un  inyección

- Solicitando parámetros en cualquier función invocada por spring
- @Autowired: Lol podíamos poner en:
  - Propiedades de una clase
  - Constructor (No es necesario)
  Esta opción no es recomendable porque:
    - Las props no están disponibles en el constructor
    - Usa reflections: rendimiento, desde Java 1.9 (la máquina virtual de Java se convierte en un estándar y es modular), por defecto no está disponible.
  Podemos rellenar props de una clase mediante el constructor, simplemente solicitando los parámetros en el constructor.

# Cómo configuro una inyección

- @Component y derivados: @Service, @Repository, @Controller, @RestController
    Cuando es una clase mia la que quiero que se instancie y se inyecte cuando se necesite.
- @Bean / @Configuration
    Cuando es una clase de un framework o de una librería externa la que quiero que se instancie y se inyecte cuando se necesite.
    Y en este caso necesito crear yo la instancia dentro de una función que la devuelve. Esa función es la que marco con @Bean
    Y la meto en una clase con @Configuration

---

Historia de JAVA resumida

1995 - Sun microsystems - Java 1.0 - Empresa querida por todos
Tenia 2 problemas:
- La gran cantidad de cagadas en su sintaxis.
- La compra de Sun por Oracle - Empresa no tan querida 
    MySQL ---> MariaDB
    OpenOffice -> LibreOffice
    Hudson -> Jenkins

Java 1.6 sale en el 2006
Java 1.7 sale en el 2011    En 8 años salen 2 versiones
Java 1.8 sale en el 2014
    - Se introduce en soporte funcional al lenguaje: java.util.function.*, operador :: ->
    - Stream (map-reduce)
    - Optional
    - Posibilidad de implementar funciones estáticas en interfaces (publicas)
    - Paquete java.time (yoda-time)

----> Oracle dice... voy a cobrar por la licencia de Java
Java 1.9 sale en el 2017    En 3 años salen 2 versiones
    - Posibilidad de implementar funciones estáticas en interfaces (privadas)
    - El proyecto jigsaw -> Introduce el concepto de módulos en la JVM
        
        Modulo                          module "milibreria" {} -> Arquitecturas no monolíticas
            Paquetes
                Clase
                Interfaz
    - La JVM de Java pasa a ser un estándar. Y muchas empresas comienzan a crear sus propias JVM:
      - OpenJDK
      - Zulu
      - Amazon Corretto
      - Eclipse Temurin
      - Oracle JDK


js - node
kotlin


node es a JS lo que JVM es a JAVA

---

# Proyecto del curso

Backend de una tienda:
- BBDD
- API REST
- Pruebas
- Contra un Proveedor de Identidad (Keycloak)