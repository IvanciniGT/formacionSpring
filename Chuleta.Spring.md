# Spring

Es un framework que nos ofrece inversión de control, para ayudarnos con la inyección de dependencias para conseguir Inversión de dependencias.

## Solicitar que un objeto me sea inyectado

### Opción 1: Escribirlo como argumento en una función que sea invocada por Spring 

```java
public class MiClase {

    public void miFuncion(TipoDeObjeto1 objeto1, TipoDeObjeto2 objeto2) {
        // ... Aquí meto el código que necesite, haciendo uso de los objetos objeto1 y objeto2
    }

}
```

Si Spring llama a esta función, Spring será automáticamente quien me suministre las instancias adecuadas (que hayan sido configuradas previamente).
Otro tema, será cómo conseguir que Spring llame a esta función.... que ya veremos más adelante.

### Opción 2: Mediante la anotación @Autowired

```java
import org.springframework.beans.factory.annotation.Autowired;

public class MiClase {

    @Autowired
    private TipoDeObjeto1 objeto1;

    @Autowired
    private TipoDeObjeto2 objeto2;

    public MiClase() {
        // Aquí podría tener mi propio código, que no podría hacer uso de los objetos objeto1 y objeto2. No están disponibles en este momento
    }

    public void miFuncion() {
        // ... Aquí meto el código que necesite, haciendo uso de los objetos objeto1 y objeto2
    }

}
```

Si Spring es quien crea una instancia de esa clase... es decir, quien ejecuta: new MiClase()... Spring será automáticamente quien me suministre las instancias adecuadas (que hayan sido configuradas previamente).
Otro tema, será cómo conseguir que Spring cree una instancia de esta clase.... que ya veremos más adelante.

Esto es una mala práctica a día de hoy.
Cómo están declaradas las propiedades? PRIVATE
Y una variable... propiedades de una clase... privadas pueden ser asignadas desde fuera de la clase? NO
JAVA tiene sus trucos para poder hacerlo: el paquete REFLECTIONS...
Ahora esto no es muy efiiciente... 
Y en concreto, en Spring no da muy buen rendimiento. porque cada vez que se crea una instancia de esta clase, se tiene que hacer uso de REFLECTIONS para asignar los valores a las propiedades.

Además, esta forma de trabajar tiene otro problema... y es: Las propiedades no son asignadas por Spring, hasta que el objeto ha sido creado, es decir: hasta que se ha terminado de ejecutar el constructor de la clase.

SonarQube os marca esta opción como un smell code, es decir, como un código que no es muy recomendable.

Ahora bien... puedo usar la opción 1... para conseguir algo parecido a la opción 2... pero sin los problemas de la opción 2.

```java
public class MiClase {

    private TipoDeObjeto1 objeto1;
    private TipoDeObjeto2 objeto2;

    public MiClase(TipoDeObjeto1 objeto1, TipoDeObjeto2 objeto2) {
        this.objeto1 = objeto1;
        this.objeto2 = objeto2;
        // Aquí podría tener mi propio código, que si podría hacer uso de los objetos objeto1 y objeto2
    }

    public void miFuncion() {
        // ... Aquí meto el código que necesite, haciendo uso de los objetos objeto1 y objeto2
    }

}
```

Siempre y cuando me asegure que Spring es quién crea una instancia de esta clase... es decir, quien ejecuta: new MiClase()... Spring será automáticamente quien me suministre las instancias adecuadas (que hayan sido configuradas previamente).

Otra cosa es cómo conseguir que Spring cree una instancia de esta clase.... es decir, que llame a mi constructor... que ya veremos más adelante.

## Configurar Spring, indicándole que objetos debe inyectar cuando se solicite un objeto de un tipo concreto

Esos objetos que Spring inyecta ... las instancias de una clase concreta ... se llaman BEANS.

Antiguamente en Spring, se configuraban los beans en un fichero XML.
Donde decíamos... cuando alguien te pida un bean llamado: "nombreDelBean"... se le inyecta una instancia de la clase: "com.empresa.paquete.Clase"

```xml
<bean id="nombreDelBean" class="com.empresa.paquete.Clase" />
<!-- 
Esto es una ruina y ya no lo usamos 
Nos la estamos cogiendo con papel de fumar.. Si alguien cambia el nombre de una variable, ya no funciona. = DELICADO
Además, el andar escribiendo ficheros XML ... es muy laborioso y propenso a errores.
-->
```

Hoy en día, esas configuraciones se las damos a SPRING mediante anotaciones.

### Anotación @Component y derivados

```java
public class MiClase {
    public void miFuncion(TipoDeObjeto objeto) { // Aquí he configurado una inyección de dependencias
                                                   // Siempre y cuando Spring sea quien llame a esta función
                                                   // el dato objeto1 será inyectado automáticamente
        // ... Aquí meto el código que necesite, haciendo uso del objeto objeto
    }
}

public class MiClase2 {
    private TipoDeObjeto objeto;
                  ////////////// < Esto es lo que vincula con la instancia
    public MiClase2(TipoDeObjeto objeto) { // Aqui he configurado una inyección de dependencias
                                            // Siempre y cuando Spring sea quien llame a este constructor
                                            // el dato objeto será inyectado automáticamente
        this.objeto = objeto;
    }
    public void miFuncion() {
        // ... Aquí meto el código que necesite, haciendo uso de los objetos objeto
    }
}
////////////////
public interface TipoDeObjeto {
    // ... Aquí meto el código que necesite
}
/////////////////
// Lo que quiero conseguir es que cuando alguien me solicite una instancia de un TipoDeObjeto, se le entregue una instancia de TipoDeObjeto1
import org.springframework.stereotype.Component;

@Component // @Service                           //////////// < Esto es lo que vincula con la instancia
public class TipoDeObjeto1 implements TipoDeObjeto {
    // ... Aquí meto el código que necesite
}
// Esta forma es muy bonita... El propio tipo de objeto se define a si mismo como la IMPLEMENTACION QUE HAY QUE USAR
```

En tiempo de ejecución... si le pido a Spring que lea esta clase (en byte-code... dentro de un jar) y ve que tiene la anotación @Component... Spring genera una instancia de esta clase y la guarda en un contenedor de objetos de Spring.

En automático, cuando anoto una clase con @Component, Spring genera UNA y SOLO UNA (por defecto) instancia de esa clase, y la guarda en un contenedor de objetos de Spring. Cuando alguien solicite una instancia de cualquier interfaz que esa clase implemente, se le entregará la instancia que Spring ha creado.

Es más.. tango en MiClase, como en MiClase2, Spring va a inyectar la misma instancia de TipoDeObjeto1.

De alguna forma, hemos convertido la clase TipoDeObjeto1 en un SINGLETON.

Singleton: es un patrón de diseño, que nos permite asegurarnos que solo existe una instancia de una clase concreta.

```java
public class MiSingleton {
    private static volatile MiSingleton instancia;
    private MiSingleton() {
        // ... Aquí meto el código que necesite
    }
    public static MiSingleton getInstancia() {
        if (instancia == null) {
            synchronized(MiSingleton.class) {
                if (instancia == null) {
                    instancia = new MiSingleton();
                }
            }

        }
        return instancia;
    }
}
```

Si tengo 2 clases que implementan la misma interfaz y las dos tienen la anotación @ Component: Tengo un error en tiempo de ejecución.
No arranca Spring.. me dice... no se que hacer??? cuál cojo????

Tendremos opciones aquí... que ya veremos!

Dentro de Spring, tenemos muchas otras anotaciones que extienen de @Component:
- @Service
- @Controller
- @Repository (Spring-jpa)
- @RestController (Spring-web)
- Dentro de la librería SpringBatch
 - @Job
 - @Step
 - @Tasklet
 - @Chunk
 - @Reader
 - @Writer
 - @Processor
 - @Listener

## Anotación @Configuration / @Bean

NOTA: Si podemos usar la opción 1... DEJAR DE LEER... ESTA NO APLICA !

En ocasiones la opción 1 no es viable... por ejemplo:
Si quiero que se inyecte una instancia de una clase que no es mia... de una libraría externa.

En ese caso... tengo acceso al código de la clase? NO
Y entonces.. puedo ir justo encima de la linea public class.....{} para poner la anotación @Component? NO

Ejemplo:

Tengo un archivo jar llamado: libreria-diccionarios-api.jar
- interfaz Diccionario
- interfaz SuministradorDeDiccionarios

Tengo un archivo jar llamado: libreria-diccionarios-impl.jar
- clase DiccionarioImpl
- clase SuministradorDeDiccionariosImpl

Y yo estoy montando: MiAppConsola


```java
public class MiAppConsola {
    private SuministradorDeDiccionarios miSuministrador;
    public MiAppConsola(SuministradorDeDiccionarios miSuministrador) { // Inyección de dependencias. Esta función haré que sea llamada por Spring
        this.miSuministrador = miSuministrador;
    }
    public void procesarPeticion(String idioma, String palabra){    // Esta función la puedo llamar yo, y tener disponible el objeto miSuministrador
        // Y aquí el código
    }
}
```
// Necesito explicar a Spring qué clase debe ser instanciada cuando alguien solicite un objeto de tipo SuministradorDeDiccionarios
// En este escenario, donde no tengo acceso al código de la clase, soy yo quien he de crear la instancia que debe ser suministrada

```java
import SuministradorDeDiccionariosImpl;
@Configuration
public class ConfiguracionSuministradorDeDiccionarios { // Le pongo el nombre que me de la gana.. al fin y al cabo, YO NO VOY A INSTANCIARLA
                                                        // Voy a dejar que sea Spring quien la instancie
    @Bean
    // ^ Con esto, cuando alguien solicite una instancia de un SuministradorDeDiccionarios,
    //   se le entregará el new SuministradorDeDiccionariosImpl() que hemos creado
    // ** NOTA
    public SuministradorDeDiccionarios configurarSuministradorDeDiccionarios(){    // Le pongo el nombre que me de la gana.. al fin y al cabo, YO NO VOY A INVOCARLA
                                                      // Voy a dejar que sea Spring quien la invoque
        return new SuministradorDeDiccionariosImpl(); // Esta es la instancia que quiero que se utilice por Spring como BEAN
    }
}
```

NOTA**: El comportamiento de esta forma (OPCION 2) es el mismo que el de la opción 1.
Spring (por defectoÇ) solo invoca a esa función una única vez... y guarda el resultado en un contenedor de objetos de Spring.

Esto funcionará siempre y cuando Spring sea quien cree la instancia de ConfiguracionSuministradorDeDiccionarios.
Para conseguir esto, anotaré la clase como: @Configuration

Cuando arranque mi app, Spring buscará todas las clases anotadas con @Configuration, creará una instancia de ellas y ejecutará todas las funciones anotadas con @Bean que encuentre en ellas, almacenando el resultado en un contenedor de objetos de Spring.