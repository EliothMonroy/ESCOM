/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package preguntas;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author ELITH
 */
public class Respuesta {
    Map<String, String> preguntas = new HashMap<>();
    Respuesta() {
        preguntas.put("hola?", "Hola :)");//1
        preguntas.put("cómo estas?", "Bien :)");//2
        preguntas.put("qué haces?", "Nada :)");//3
        preguntas.put("qué me cuentas?", "Números :)");//4
        preguntas.put("cómo te llamas?", "Chatbot :)");//5
        preguntas.put("de donde eres?", "De aquí :)");//6
        preguntas.put("quién eres?", "Tu amigo :)");//7
        preguntas.put("cómo eres?", "Soy chido :)");//8
        preguntas.put("neta eres chido?", "Neton :)");//9
        preguntas.put("volveremos a platicar?", "No :)");//10
        preguntas.put("default", ":)");
    }

    String getValor(String mensaje) {
        if(preguntas.containsKey(mensaje)){
            return preguntas.get(mensaje);
        }else{
            return preguntas.get("default");
        }
    }
    
}
