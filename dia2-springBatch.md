# SpringBatch 

Es una librería que me permite montar procesos Batch con Spring.

## Requisitos:

Quiero un programa que:
- Lea usuarios de un fichero csv
- Los inserte en una BBDD
- Ah... y que valide el DNI de los usuarios
- Ah... y que mande un correo cuando termina el proceso
- Ah... y que valide también el email de los usuarios
- Ah... y que mande un correo cuando arranca el proceso

## Implementación tradicional

En este código le doy instrucciones concretas a mi computadora, que debe ejecutar.
Soy yo quien define el FLUJO de ejecución del programa.

```java
public class MiProcesoBatch {
    public static void main(String[] args){ // Código imperativo
        // Aquí iría el código que manda el correo de inicio
        // Aquí iría el código que abre el fichero csv
        // Para cada linea del fichero  -> BUCLE
            // Aquí iría el código que valida el DNI -> IF
            // Aquí iría el código que valida el email -> IF
            // Aquí iría el código que inserta en la BBDD
        // Aquí iría el código que manda el correo de fin
    }
}
```

## Versión SpringBatch

```java
@SpringBootApplication // **1
// Eso es un truco que nos ofrece una extensión de Spring llamada SpringBoot
// Y que realmente nos está evita el usar las anotaciones:
// - @ComponentScan("paquetes")
// - @EnableAutoConfiguration Busca las@Configuration en mis paquetes
public class MiProcesoBatch {
    public static void main(String[] args){
        SpringApplication.run(MiProcesoBatch.class, args);  // Inversión de control
    }
}
// ACABADO MI PROGRAMA.
// Qué hace tu aplicación? (me contesta Spring)
// **1: Y yo le digo.. empápate tu!... mira por ahí que otros ficheros (clases) tengo en mis paquetes.

// Además tendré que dar las configuraciones y componentes de mi app

@JobListener // @Component
Tiene un Listaner de fin de proceso que que manda un correo

@ItemProcessor<Usuario, UsuarioValidado> // @Component
Tiene un Procesador de Usuarios que:
- valida el DNI de los usuarios
- valida también el email de los usuarios

@JobListener // @Component
Tiene un Listaner de comienzo de proceso que que manda un correo

@ItemReader<Usuario> // @Component
Tiene un lector de ficheros csv. Que lea objetos de tipo Usuario

@ItemWriter<Usuario> // @Component
Tiene un escritos de Usuarios a fichero

// YO NO DEFINO FLUJO PARA MI APP... Eso lo hace SpringBatch... Es quien monta mi app.
```
