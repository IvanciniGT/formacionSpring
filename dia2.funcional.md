# Paradigma funcional

String texto = "hola";

- "hola"            Crea un objeto de tipo String con valor "hola" y lo guarda en RAM
- String texto      Crea una variable que puede referenciar a objetos de tipo String o derivados
- =                 Asigna la variable "texto" al dato "hola"

texto = "adios";
- "adios"           Crea un objeto de tipo String con valor "adios" y lo guarda en RAM
                        Dónde se crea? En la RAM... pero en el mismo sitio que "hola"? NO
                        Y en este momento tengo 2 objetos String en memoria: "hola" y "adios"
- texto             Coge la variable "texto" y la despega de donde estaba
- =                 Asigna la variable "texto" al dato "adios"
                        "hola" queda sin referenciar por ninguna variable y se convierte en basura (GARBAGE) 
                        Hasta que entra el recolector de basura y lo elimina de la RAM

public class Saludador {
    public static String saluda(String nombre){
        return "Hola " + nombre;
    }
}

// Esto es oo y procedural
Saludador miSaludador = new Saludador();
miSaludador.saluda("Iván");

// Ésto es lenguaje funcional

```java
    import java.util.function.Function;
    ...
    Function<String,String> miFuncion = miSaludador::saluda;
    miFuncion.apply("Iván");
    
    Function<String,String> otraFuncion = (String nombre) -> {
        return "Hola " + nombre;
    };
    Function<String,String> otraFuncion = (nombre) -> {
        return "Hola " + nombre;
    };
    Function<String,String> otraFuncion = nombre -> {
        return "Hola " + nombre;
    };
    Function<String,String> otraFuncion = nombre -> "Hola " + nombre;
    // El operador -> me permite definir expresiones lambda
    // Expresión lambda: Me permite definir una función anónima dentro de una expresión
    //     Un trozo de código que devuelve una función anónima creada en tiempo de ejecución, dentro de la expresión
    // Expresión? Un trozo de código que devuelve un valor
    String texto = "hola"; // Statement: Sentencia, Enunciado, Oración, Frase
    int numero = 7 + 5;    // Otro statement
                 ///// Eso es una expresión
```



// Desde JAVA 11 tenéis "var" en JAVA
Cuidado no es el "var" de JS
JS es un lenguaje de tipado dinámico

    var texto = "hola";
    texto = 1;              // Esto es posible en JS

Mientras que JAVA es un lenguaje de tipado estático

    var texto = "hola";     // Inferencia de tipos
    texto = 1;              // Esto no compila. La variable texto es de tipo String y no puede referenciar a un int
