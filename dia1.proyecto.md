# Proyecto: 

App de consola que permita a un usuario introducir una palabra y un idioma y le ofrezca como salida:
- Si la palabra existe en el diccionario del idioma
- Las definiciones de esa palabra

```bash
$ consultorDePalabras ES manzana
La palabra manzana existe.
Significa:
- Fruto del manzano
```

## Diseño

En cuántos subproyectos(componentes/módulos) divido este proyecto? 3

## API (app. programming interface) de una librería (en este caso que me permite trabajar con diccionarios)

```java

// paquete: com.diccionario

public interface Diccionario {
    String getIdioma();
    boolean existe(String palabra);
    //List<String> getSignificados(String palabra) throws NoSuchWordException;
        // ESTA ES UNA MIERDA GIGANTE !!!! SonarQube? Herramienta de análisis de calidad de código -> que nos califica esta linea como SMELL CODE
        Alguien sabe decirme a la vista de esa definición, lo que devuelve la función? NPI
        Si le pregunto por la palabra ARCHILOCOCO en ES? 
        - Una lista de textos vacía \
        - null                      / Comportamiento ambiguo. NO ES EXPLICITA. O lo miro en la documentación o lo miro en el código.
                                        Al menos ofrece un comportamiento claramente diferenciado en caso de que la función no haga su cometido principal: Devolver definiciones 
        - una exception             - Si es explicita
                                        Pero esto es una ruina. Una Exception es muy cara de generar a nivel computacional (Volcado de la traza de hilos)
                                        Nunca debería usar una excepción para controlar lógica de la app.
    Optional<List<String>> getSignificados(String palabra); // ME QUITA TODA AMBIGÜEDAD
        // Caja que puede llevar dentro la lista de definiciones o NO ( y venir vacía)
}

public interface SuministradorDeDiccionarios {
    boolean tienesDiccionarioDe(String idioma);
    Optional<Dictionary> getDiccionario(String idioma);
}

```

## Gestión de las palabra (persistencia) y Idiomas <- Implementación de ese API
    Cuántas implementaciones puedo tener de ésto?
        - Teniendo las palabras y los idiomas en una BBDD (SQL)
        - Teniendo las palabras y los idiomas en una BBDD (Mongo)
        - Teniendo las palabras y los idiomas en un servicio WEB
        - Teniendo las palabras y los idiomas en un fichero ****

```java

//paquete: com.diccionario.impl;

import com.diccionario.SuministradorDeDiccionarios;
import com.diccionario.Diccionario;

public class DiccionarioDesdeFichero implements Diccionario{
    // La implementación de los métodos
}
public class SuministradorDeDiccionariosDesdeFichero implements SuministradorDeDiccionarios{
    // La implementación de los métodos
}


```

## UI: Interfaz gráfica

```java

// import com.diccionario.impl.SuministradorDeDiccionariosDesdeFichero; // PERO ESTA LINEA ES EL MAYOR DESASTRE POSIBLE EN UN PROYECTO DE SOFTWARE
    // Esto es lo típico de un sistema MONOLITO. Y hoy en día esto es una MUY MALA PRACTICA. YA NO LO QUEREMOS
    // Nos hemos MEADO en el ppo de la Inversión de Dependencia
import com.diccionario.SuministradorDeDiccionarios;
import com.diccionario.Diccionario;

public class MiAppDeConsola {

    public void procesarPeticion(String idioma, String palabra, SuministradorDeDiccionarios miSuministrador){ // Inyección de dependencias
        // Haré cositas que necesite de mi programa 
        boolean existeLaPalabra = false;
        // SuministradorDeDiccionarios miSuministrador = new SuministradorDeDiccionariosDesdeFichero();
        if(miSuministrador.tienesDiccionarioDe(idioma)){
            Diccionario miDiccionario = miSuministrador.getDiccionario(idioma).get(); // Si viene vacío el optional es que hay un 
                                                                                      // bug en la implementación
            if(miDiccionario.existe(palabra)){
                existeLaPalabra = true;
                // Y otras cositas que hiciera aquí.
            }
        }
        // Ya sabiendo si la palabra existe... hago más cositas
    }
}
```

    UI -> API <- Impl. Del API
     |              ^
     +---------------

Iván.. tio... ahí solo has llevado el problema a otro sitio.
Pues si...

Voy a usar un framework de inversión de control, para que TERMINE DE ESCRIBIR MI APP.
    Al framework, le podré decir... si tienes que llamar a la función procesarPeticion, debes suministrar un SuministradorDeDiccionarios.
    Si en algún momento debes suministrar un SuministradorDeDiccionarios, hazlo con la clase: SuministradorDeDiccionariosDesdeFicheros
        Al final... en algún sitio del código es necesario escribir: new SuministradorDeDiccionariosDesdeFichero()
        Solo que no voy a escribirlo yo... se lo pido a Spring... CONFIGURO A SPRING para que haga ese trabajo por mi.
La inversión de control nos facilita la INYECCION DE DEPENDENCIAS... para conseguir a su vez respetar el PPO DE INVERSION DE DEPENDENCIAS.

