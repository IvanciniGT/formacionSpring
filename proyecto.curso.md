# Sistema de AnimalitosFermin

animalitosfermin.com

    BACKEND                                                                         CLIENTES - FRONTAL
    ------------------------------------                                            ------------------------------------
    BBDD               Servicios REST (JAVA + SP)                           Navegador - App JS (Angular, React, Vue)  v.2.0.0 (Consulta-> v2.0.0)
    animalitos          consular animalitos         ---> JSON --->          App para un teléfono Android (Kotlin)     v.1.0.0 (Consulta-> v1.0.0)
                                                                            App para un teléfono iOS (Swift)          v.1.1.0 (Consulta-> v1.1.0)
                        consultar un animalito                              App para un SmartTV (Java)                v.1.1.0 (Consulta-> v1.1.0)
                                                                            App para un asistente de voz
                        añadir animalito            <---- JSON ----             Alexa                                 v.1.1.0 (Consulta-> v1.1.0)
                                                                                Ok Google
                        CRUD                                                    Siri
                                                                            Sistema de voz interactiva TELEFONO
                                                                            App desktop para los trabajadores   (C#, vba)
                                                                             Que trabajaba con la v.1.0.0 del servicio alta
                                                                             pase a trabajar con la v1.1.0 del servicio alta

        consultar un animalito  v1.1.0                      
            [nombre, tipo, color, edad, tamaño]
        añadir animalito        v1.1.0
            [nombre, tipo, color, edad, tamaño=Desconocido] -> Quiero esto en producción YA
                                                                En el próximo sprint (en la proxima entrega de mi metodología ágil)
                                                               Mantengo esta versión en producción hasta que la gente migre
        añadir animalito        v2.0.0                         Subo ésta a producción
            [name, type, color, age, size, pics]
                                                                Necesitaré hacer que ambas versiones sean compartibles con estar funcionando en paralelo
            Aquí nos salen las herramientas de gestión de APIs (Apigee)

Quiero hacer un cambio:
    Los animalitos ahora tienen tamaño.
    v1.0.0      ->      v1.1.0


### Versiones de software

v.1.2.3
                Cuando se incrementan?
    MAJOR 1     Breaking changes
                Cambios que rompen la compatibilidad con versiones anteriores
    MINOR 2     Nueva funcionalidad
                Algo que se marca como deprecated
    PATCH 3     Bugfixes

---

# Metemos zoom al backend, que es lo que vamos a montar nosotros (sin perder de vista el resto)

    JSON
^
^   ControladorRest    ControladorDeAnimalitos                          DatosDeAnimalitoRestv1
                            v    (Exponer los servicios según un protocolo)
                                /api/v1/animalitos -> List<DatosDeAnimalitoRestv1> ControladorDeAnimalitos.getAnimalitos()
                                                                        ----------------------
^   Servicios          ServicioDeAnimalitos                             DatosDeAnilmalito
                            v    (lógica de negocio)                    DatosDeNuevoAnimalito
                                DTO getAnimalito(id)                    DatosParaModificarAnimalito
                                DTO getAnimalitos()
                                DTO deleteAnimalito(id)                 ---------------------- < BARRERAS DE CONTENCION ANTE CAMBIOS
                                DTO updateAnimalito(id, DTO2)
                                DTO createAnimalito(DTO3)
^   Persistencia       RepositorioDeAnimalitos                          Entidades/Modelos   (Objetos de negocio)
                            v     (persistencia)                           Animalito
                          BBDD

# DTO                       @Data <- Aunque esta no es de Java pelao... me la da una librería que usamos un huevo: Lombok

Conceptualmente es un objeto de transporte de datos
A nivel de implementación en JAVA, lo implemento como: POJO (plain old Java object - Objeto con getters y setters) + equals
Dos instancias de una DTO son iguales cuando todos sus datos son iguales

# ENTITY                    @Entity

Conceptualmente es un objeto de negocio
Que siempre viene identificador por un ID
Dos instancias de un mismo entity se consideran iguales cuando su ID es el mismo


    public class DatosParaModificarAnimalito{
        private int edad;
        private String tamaño;
    }

    public class DatosDeNuevoAnimalito extends DatosParaModificarAnimalito {
        private String nombre;
        private String tipo;
        private String color;
    }

    public class DatosDeAnimalito extends DatosDeNuevoAnimalito{
        private long id;
    }

    public class DatosDeAnimalitoRestv1{
        private long id;
        private String name;
        private String type;
        private String color;
        private int edad;
        private String tamaño;
    }

Voy a necesitar transformar continuamente entre objetos de tipos de datos equivalentes -> Mapper (librerías de autommaping)



    1 sola DTO? 
        SI  IIII            Si me vale. Claro que me vale.. siempre y cuando me quiera CAGAR en el PPO de segregación de la interfaz
                            Otro de los grande 5 principio de desarrollo de software SOLID
        NO  I