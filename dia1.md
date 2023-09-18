# Paradigmas de programación

## Imperativo
## Procedural
## Funcional
## OO

Cuando el lenguaje me permite definir mis propios tipos de datos, con sus propiedades y funciones particulares.
Esos tipos de datos, reflejan objetos del mundo real (o no).

    Tipo de dato        Propiedades que lo caracterizan             Funciones
    Texto (String)      secuencia de caracteres                     .toUpperCase() .trim()
    LocalDate           día / mes / año                             .enQueDiaSeLaSemanaCaes()
    List                secuencia de datos                          .size() .get(i)
    Usuario             nombre/email/fecha de nacimiento            .eresMayorDeEdad()

## Declarativo

# Librería

Un conjunto de código reutilizable, que alguien distribuye, para que otros puedan hacer uso de él.

# Framework

Es un conjunto de 1 más librerías... pero además nos impone una forma de utilizarlas.

# Inversión de control

Patrón de desarrollo de software por el cuál:
Delegamos el control del flujo de la app a un framework, en contraposición con los métodos tradicionales de desarrollo en los que el desarrollador implementa y controla el flujo de la app.

Para qué quiero ésto en mi proyecto? Para conseguir respetar el principio de Inversión de dependencias.

# Inversión de dependencias

Uno de los 5 grandes principios de desarrollo de software que utilizamos hoy en día.
El objetivo de esos 5 principio de software es conseguir facilitar el mantenimiento y evolución de un software.
En este sentido nos hemos dado cuenta que la forma en la que estábamos montando apps web (sistemas monolíticos)
y por ello hoy en día vamos a otro tipo de arquitecturas... donde buscamos descomponer un sistema en módulos/componentes con un nivel de acoplamiento muy bajo entre ellos. Esto da lugar por ejemplo a las arquitecturas de microservicios.

SOLID: Tío bob (Robert Cecil Martin)

## Principio de la Inversión de dependencias

Un módulo/componente de alto nivel de un sistema no debería nunca depender de implementación concretas de un módulo de bajo nivel, sino de abstracciones (interfaces/API).
Una de las estrategias que utilizamos para conseguir respetar el ppo de Inversión de dependencias es la INYECCIÓN DE DEPENDENCIAS

# Inyección de dependencias

Patrón de diseño de software (en POO) por el cual una clase, en lugar de crear instancias de los objetos que necesita, le son suministradas.

# Spring

Framework de Java para crear apps, que implementa INVERSION DE CONTROL.
Dentro del framework encontramos más de 200 librerías:
- Core
- MVC
- Web
- Persistencia
- Comunicaciones
- Seguridad
- SpringBatch... para montar procesos batch (que no son ni web, ni de escritorio)

Springboot es un extensión del framework, que nos ofrece una configuración más sencilla que la clásica necesaria para una aplicación Spring.

---

# Testing 

## Requisitos:

Funcionales:
- Contemplar los distintos casos de uso de un sistema/componente
No funcionales: 
- Seguridad
- Rendimiento
- Alta disponibilidad
- Escalabilidad
- UX

## Vocabulario en el mundo del testing

- Error         Los humanos cometemos errores (por estar cansados, distraídos, falta de conocimiento...)
- Defecto       Al cometer un error, introducimos un DEFECTO en un sistema
- Fallo         Defecto que en un momento dado puede manifestarse en forma de FALLO

## Para qué sirven las Pruebas de software

Sirven para:
- Asegurar el cumplimiento de unos requisitos
  - Problemas de seguridad
- Identificar FALLOS
  Cuando un fallo es identificado (por una prueba) qué tengo que hacer? Subsanar el defecto
  Para ello, tengo previamente que identificarlo (el defecto): Depuración (debugging)
- Otro objetivo de las pruebas es proveer toda la información posible para la rápida identificación de un DEFECTO al encontrar un fallo.
- Haciendo un análisis de causas RAICES, puedo llegar a identificar los ERRORES y tomar acciones PREVENTIVAS, que eviten nuevos errores en el futuro (y sus correspondientes defectos y fallos)
- Identificar DEFECTOS (para ésto no es necesario ejecutar un programa)
  - Sonarqube (ésto es lo que antes hacía un desarrollador SENIOR)
  - Revisión de un modelo de datos
  - Revisión de los requisitos
        REQUISITO: El sistema debe dar unos tiempos de respuesta aceptables. RUINA ENORME. Totalmente ambiguo
        REQUISITO: El sistema debe responder en menos de 150ms.              IGUAL DE RUINA!
        REQUISITO: Tal operación (detallada) en el sistema instalado en un entorno (detallado), y sometido a tal carga de trabajo (detallada)
                   debe tener un percentil 95% inferior a 150ms, cuando se realiza la operación 500 veces. GUAY 
- Para saber qué tal voy en un proyecto

## Tipos de pruebas

Cualquier prueba se debe centrar en un aspecto UNICO del sistema.
Las pruebas se clasifican en base a diferentes taxonomías, paralelas entre si:

## Tipos de pruebas en base al nivel de la prueba:

- Pruebas unitarias                 Prueba en la que me centro en una aspecto de un componente AISLADO del resto del sistema
  - Medir la latencia de red. 80 ms

                    TREN
                    Motor       Ruedas      Freno       Engranajes  

- Pruebas de integración            Pruebas que se centran en LA COMUNICACION entre componentes

                    Motor <- Le meto corriente y miro gira y la potencia que entrega
                    Pero puede ser que tenga un componente que intrisnecamente dependa de otro componente

                    - Servicio que da de alta un usuario en una BBDD

                        ----> Programa - (Alta de un usuario) --->   Servicio Alta Usuario  ->  BBDD
                                                                     Backend API REST
                                                                     POST https://miapp.miempresa.com/apis/v1/usuarios

                        El problema es cómo aislo al servicio de la BBDD? Test Double

- Pruebas de sistema (end2end)      Prueba que se centra en el COMPORTAMIENTO del sistema en su conjunto: El sistema se comporta como debe?
  - Pruebas de aceptación 

## Metodologías de desarrollo

- TDD: Test Driven Development: Desarrollo dirigido por pruebas
        Donde lo primero que hago es escribir las pruebas unitarias, y luego escribo el código que hace que la prueba pase. 
        Después ejecuto la prueba y veo que pasa.

        COCHE -> Antes de hacer el coche, ya existe definido el test EuroNCAP
                 Que mide la seguridad del coche
                 Y me dicen... le voy a coger tu coche y lo voy a estrellar contra una pared a 50km/h
                    Y si no pasa la prueba... te quito estrellas
        TORNILLO -> Si voy a fabricar un tornillo según una norma DIN o ISO
                 Me dicen. te voy a coger el tornillo y lo voy a poner en una máquina que lo va a apretar hasta que se rompa
                    Y si no pasa la prueba... te quito la certificación
        SOFA DE IKEA---> Tengo unos test ya definidos por IKEA ... y por el ministerio de consumo de cada pais
                    Y me dicen ... te voy a coger tu sofá y lo voy a poner en una máquina que lo va a apretar hasta que se rompa
                    O le meto fuego... tiene que no propagar ese fuego

- BDD: Behaviour Driven Development (Partimos no de pruebas unitarias), sino de sistema (comportamiento)
- ATDD: Acceptance Test Driven Development (Partimos no de pruebas unitarias, ni de sistema), sino de aceptación

## Test Doubles

Objetos que nos ayudan con las pruebas
- Stub
- Fake
- Spy
- Mock
- Dummy

                        Servicio Alta Usuario  --- parámetros de la función --->  BBDD
                                               <-- return ----------------------

                            STUB de la BBDD: Que siempre responde 33, le pase los datos que le pase
                                    boolean doLogin(String usuario, String password){
                                        return true;
                                    }
                            FAKE de la BBDD: Lo que éste responde, depende de los parámetros de entrada
                                FAKE de la función login
                                    boolean doLogin(String usuario, String password)
                                        if (usuario == "admin" && password == "admin") {
                                            return true;
                                        } else {
                                            return false;
                                        }
                                    }
                                Un fake es más inteligente que un Stub
                                En el extremo... un fake se convertiría en EL COMPONENTE REAL
                            El fake y el stub se centran en lo que la función devuelve.
                            Por contra un SPY y un MOCK se centra en lo que la función recibe
                            El SPY me permite asegurar que se llamó a la función con los parámetros que yo esperaba

                                PRUEBA de que con datos incorrectos hago login

                                    boolean doLogin(String usuario, String password)
                                       // Llama a una BBDD para ver si el usuario y la contraseña son correctos
                                       // O al menos eso debería hacer
                                       return false;
                                    }
                                    Imaginad que conozco de antemano que el usuario "admin" con la contraseña "felipe" no es correcto
                                    Imaginad que conozco de antemano que el usuario "admin" con la contraseña "admin" es correcto
                                    Y llamo a doLogin("admin", "felipe")... espero que devuelva: false
                                    Y llamo a doLogin("admin", "admin")... espero que devuelva: true

                                    En la prueba de la función doLogin, me quiero asegurar que la función llama a la función correspondiente de la BBDD con los parámetros que yo espero

                            El mock me asegura que se llamó a la función con los parámetros que yo esperaba.
                            Ya que el mock es más inteligente que el spy... y lleva lógica que permite hacer la comprobación por si mismo.

## Tipos de pruebas en base al objeto de pruebas

- Pruebas funcionales
- Pruebas no funcionales
  - Pruebas de seguridad
  - Pruebas de rendimiento
  - Pruebas de carga
  - Pruebas de estrés
  - Pruebas de UX

## Tipos de pruebas en base al procedimiento de ejecución

- Pruebas dinámicas. Las que necesitan poner el código en marcha: JUnit, TestNG, Mockito, Selenium, Cucumber, JMeter, Gatling
- Pruebas estáticas. Las que no necesitan poner el código en marcha: SONARQUBE... o una revisión de requisitosç

Cualquiera de ellas las puedo hacer manualmente o en automático.

## Pruebas de regresión

Cualquier prueba que hago otra vez se convierte en una prueba de regresión.
Para ver que todo sigue funcionando como antes.

# JUnit

Framework de JAVA que nos permite hacer pruebas.

---
# Metodologías de Gestión de Proyectos

Antiguamente usábamos metodologías en cascada (tradicionales)... y sus variantes: V, en espiral

    Dividir el proyecto en fases secuenciales: Ésto está en desuso... ya no
        TOMA DE REQUISITOS
            ANALISIS / PLAN
                DESARROLLO (6 meses)
                    PRUEBAS
                        IMPLANTACION
                            MNTO

Teníamos muchos problemas.
El principal problema de las met. tradicionales era la falta de retro-alimentación por parte del cliente.

# Metodologías ágiles: SCRUM, Extreme programming, Kanban

Entregar mi producto de forma incremental al cliente:

A los 30 días de empezar el proyecto -> ENTREGA 1 en producción
Y doy un sistema 100% funcional.

    Entrega 1 - 30 días -> 5% de la funcionalidad... pero 100% funcional
        Pruebas a nivel de producción 5%
        Instalación en producción
    Entrega 2 - 45 días -> +10% de la funcionalidad
        Pruebas a nivel de producción 10% + 5%
        Instalación en producción
    ...
    Entrega N - 300 días -> + 5% de la funcionalidad... (y completo el 100% ... si es que ésto si quiera tiene sentido hablar de ello)
        Instalación en producción

Al usar una met. ágil, las pruebas se multiplican.. me crecen como enanos.
De dónde saco la pasta? recursos? tiempo? No lo hay, ni pasta, ni recursos, ni tiempo.
Y entonces? cuál es la solución a este problema? AUTOMATIZAR ( y aquí es donde entra el mundo DEVOPS )

## Dev-->ops

Es una cultura, una filosofía, un movimiento en pro de (en defensa de) LA AUTOMATIZACION de todos los procesos que hay entre el DESarrollo y la OPeración de un sistema
Desarrollo ágil, Integración continua, Entrega continua (CD), Despliegue continuo (CD)

            Automatizable?      HERRAMIENTAS
PLAN                x
CODE                ~(x)                                                    ----> Lo que hace desarrollo se deja en un REPO de un SCM (git)
BUILD               √
                                JAVA: maven, gradle, sbt
                                JS:   npm, yarn, webpack, angular cli
                                .net: msbuild, dotnet, nuget
----> Desarrollo ágil
TEST
    Definición de la prueba
                    x
    Ejecución de la prueba
                    √
                                Sonarqube
                                Frameworks de pruebas: JUnit, TestNG, Mockito
                                JS: Mocha, Jasmine, Jest
                                .net: nunit, xunit, moq
                                Pruebas de rendimiento: jmter, gatling, loadrunner

    Y estas pruebas dónde las hago? En la máquina del desarrollador? NO. Por qué? Esta maleao el entorno del desarrollador
                                    En la máquina del tester? NO. Por qué? Esta maleao el entorno del tester
                                    En la máquina de producción? NO
                                    En un entorno de pruebas o integración? SI
    Que es INTEGRACION CONTINUA? Tener siempre (continuamente) la última versión que dejan los desarrolladores en su REPO (git) en el entorno de integración, sometida a pruebas automatizadas, que generan automáticamente un INFORME DE RESULTADOS.
    Para qué?                                     
        - Identificar Fallos
        - Identificar defectos
        - Saber qué tal va mi proyecto
        ... lo antes posible 

DELIVER  Poner en manos de mi cliente el producto listo para su instalación
-----> Entrega continua
DEPLOY  Instalar el producto en el entorno de producción
-----> Despliegue continuo
OPERATE
MONITOR


### Integración continua (CI)

Automatizar 

## Principios del manifiesto ágil:

> El método más eficiente y efectivo de comunicar información al equipo de desarrollo y entre sus miembros es la conversación cara a cara.

> El software funcionando es la medida principal de progreso.

La medida principal del grado de avance del progreso que tengo en un proyecto es el "software funcionando".

Me habla de cómo medir el grado de avance que tengo en un proyecto.

¿Cómo medíamos hace 20 años que tal iba un proyecto? El jefe de proyecto qué hacía?
- Preguntando a los desarrolladores. NO ES BUENA FORMA
- Contar las lineas que había escrito un desarrollador a la semana.

Hoy en día he aprendido que la mejor forma de saber qué tal va mi proyecto es: EL SOFTWARE FUNCIONANDO

Qué significa "Software funcionando"? Software que funciona.
Quién dice que un software funciona? LAS PRUEBAS

> La simplicidad, o el arte de maximizar la cantidad de trabajo no realizado, es esencial.

Antiguamente estaba considerado una buena practica el POR SI ACASO!
Hoy en día se considera una MUY MALA PRACTICA.
No escribas ni una sola linea de código que no estés usando o no sea necesaria.

---

# Maven

Herramienta de automatización de tareas rutinarias en un proyecto (JAVA):
- compilación
- compilación de las pruebas
- ejecución de pruebas
- empaquetado
- Mandar el código a SonarQube
- Generar una imagen de contenedor con mi código
- ...

Para algunas de ellas es necesario Gestionar dependencias

---

Spring es un framework... que va evolucionando con el tiempo.
En paralelo a JAVA, que es un lenguaje que va evolucionando con el tiempo.
Junto con unas metodologías de desarrollo que van evolucionando con el tiempo.
Además de unas arquitecturas de software que van evolucionando con el tiempo.
Igual que los principios y patrones de diseño de software que van evolucionando con el tiempo.

Todo ESTO EVOLUCIONA EN PARALELO, pero de forma compatible.

Y si vas a montar un sistema monolítico, mejor usa una metodología tradicional.... que se usaban cuando montábamos sistemas monolíticos.
Y aquí usa JEE ^

Pero si quieres montar un sistema con componentes desacoplados, que se comunican entre si, y que se despliegan de forma independiente... mejor usa una metodología ágil.
Y aquí usa Spring ^
