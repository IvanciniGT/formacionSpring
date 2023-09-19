#language:es

# Esto es un fichero Gherkin, que lo vamos a procesar con Cucumber
# Esto es un fichero Pepinillo, que lo vamos a procesar con el Pepino

# Tendremos un fichero con los requisitos, que a su vez son las pruebas de SISTEMA (comportamiento)
# Y es lo primero que vamos a hacer.... para darnos luz... para guiarnos... BDD

# Este fichero está escrito en Gherkin... pero Gherkin tan solo es un conjunto de restricciones sobre un idioma natural

Característica: Servicio REST de alta de animalitos v1

    Esquema del escenario: Cuando se solicita el alta de un animalito con datos ok, el animalito se carga en la BBDD y recibo el ID
        Dado que tengo un objeto JSON,                                  
           Y ese objeto JSON tiene por "nombre": "<nombre>"
           Y ese objeto JSON tiene por "tipo": "<tipo>"
           Y ese objeto JSON tiene por "color": "<color>"
           Y ese objeto JSON tiene por "edad": <edad>
        Cuando hacemos una petición por método "POST" al servicio "/api/v1/animalitos"
           Y le mandamos el objeto JSON en el cuerpo de la petición
        Entonces el servicio nos devuelve un código de estado "200"
           Y el servicio nos devuelve un objeto JSON,
           Y el objeto JSON tiene por "nombre": "<nombre>"
           Y el objeto JSON tiene por "tipo": "<tipo>"
           Y el objeto JSON tiene por "color": "<color>"
           Y el objeto JSON tiene por "edad": <edad>
           Y el objeto JSON tiene un "id" de tipo "numerico"
           Y debe haberse creado una entrada en la BBDD dentro de la tabla "animalitos"
           Y con el "id" del animalito igual al "id" que nos ha devuelto el servicio
           Y con el "nombre" del animalito "<nombre>"
           Y con el "tipo" del animalito "<tipo>"
           Y con el "color" del animalito "<color>"
           Y con la "edad" del animalito <edad>
           Y tiene que mandar un email a "altas@animalitosfermin.com"
           Y en el asunto tiene que poner "Alta de animalito"
           Y en el cuerpo del email tiene que aparecer el texto "<nombre>"

        Ejemplos:
            | nombre  | tipo  | color    | edad |
            | Pepito  | Perro | Marrón   | 2    |
            | Manolo  | Gato  | Blanco   | 3    |
            | Pepita  | Tigre | Amarillo | 4    |
            | Manola  | León  | Amarillo | 5    |
    # Acabo de definir un requisito... pero he definido algo más: una prueba de sistema

    Esquema del escenario: Cuando se solicita el alta de un animalito sin nombre, obtengo un error
        Dado que tengo un objeto JSON,
           Y ese objeto JSON tiene por "tipo": "<tipo>"
           Y ese objeto JSON tiene por "color": "<color>"
           Y ese objeto JSON tiene por "edad": <edad>
        Cuando hacemos una petición por método "POST" al servicio "/api/v1/animalitos"
           Y le mandamos el objeto JSON en el cuerpo de la petición
        Entonces el servicio nos devuelve un código de estado "400"
           Y el servicio nos devuelve un objeto JSON,
           Y el objeto JSON tiene por "error": "El nombre es obligatorio"
           Y no debe haberse creado una entrada en la BBDD dentro de la tabla "animalitos"

        Ejemplos:
            | tipo  | color    | edad |
            | Perro | Marrón   | 2    |
            | Gato  | Blanco   | 3    |
            | Tigre | Amarillo | 4    |
            | León  | Amarillo | 5    |

    Esquema del escenario: Cuando se solicita el alta de un animalito sin tipo, obtengo un error
        Dado que tengo un objeto JSON,
           Y ese objeto JSON tiene por "nombre": "<nombre>"
           Y ese objeto JSON tiene por "color": "<color>"
           Y ese objeto JSON tiene por "edad": <edad>
        Cuando hacemos una petición por método "POST" al servicio "/api/v1/animalitos"
           Y le mandamos el objeto JSON en el cuerpo de la petición
        Entonces el servicio nos devuelve un código de estado "400"
           Y el servicio nos devuelve un objeto JSON,
           Y el objeto JSON tiene por "error": "El tipo es obligatorio"
           Y no debe haberse creado una entrada en la BBDD dentro de la tabla "animalitos"

        Ejemplos:
            | nombre  | color    | edad |
            | Pepito  | Marrón   | 2    |
            | Manolo  | Blanco   | 3    |
            | Pepita  | Amarillo | 4    |
            | Manola  | Amarillo | 5    |

    Esquema del escenario: Cuando se solicita el alta de un animalito sin color, obtengo un error
           Dado que tengo un objeto JSON,
           Y ese objeto JSON tiene por "nombre": "<nombre>"
           Y ese objeto JSON tiene por "tipo": "<tipo>"
           Y ese objeto JSON tiene por "edad": <edad>
        Cuando hacemos una petición por método "POST" al servicio "/api/v1/animalitos"
           Y le mandamos el objeto JSON en el cuerpo de la petición
        Entonces el servicio nos devuelve un código de estado "400"
           Y el servicio nos devuelve un objeto JSON,
           Y el objeto JSON tiene por "error": "El tipo es obligatorio"
           Y no debe haberse creado una entrada en la BBDD dentro de la tabla "animalitos"

        Ejemplos:
            | tipo  | nombre    | edad |
            | Perro | Pepito    | 2    |
            | Gato  | Manolo    | 3    |
            | Tigre | Pepita    | 4    |
            | León  | Manola    | 5    |

    Esquema del escenario: Cuando se solicita el alta de un animalito sin edad, obtengo un error
        Dado que tengo un objeto JSON,
           Y ese objeto JSON tiene por "nombre": "<nombre>"
           Y ese objeto JSON tiene por "tipo": "<tipo>"
           Y ese objeto JSON tiene por "color": "<color>"
        Cuando hacemos una petición por método "POST" al servicio "/api/v1/animalitos"
           Y le mandamos el objeto JSON en el cuerpo de la petición
        Entonces el servicio nos devuelve un código de estado "400"
           Y el servicio nos devuelve un objeto JSON,
           Y el objeto JSON tiene por "error": "La edad es obligatoria"
           Y no debe haberse creado una entrada en la BBDD dentro de la tabla "animalitos"

        Ejemplos:
            | nombre  | tipo  | color    |
            | Pepito  | Perro | Marrón   |
            | Manolo  | Gato  | Blanco   |
            | Pepita  | Tigre | Amarillo |
            | Manola  | León  | Amarillo |
