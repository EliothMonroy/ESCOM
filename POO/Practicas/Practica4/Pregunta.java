public class Pregunta{
    private String pre;
    private String[] respuesta;
    private int respuestaCorrecta;
    public Pregunta(String pre, String[] respuesta, int correcta){
        this.pre=pre;
        this.respuesta=new String[4];
        /*for (String res : respuesta) {
            System.out.println(res);
        }*/
        this.respuesta=respuesta;
        respuestaCorrecta=correcta;
    }
    public String getPregunta(){
        return this.pre;
    }
    public String[] getRespuesta(){
        return this.respuesta;
    }
    public String getCorrecta(){
        return this.respuesta[respuestaCorrecta];
    }
}
