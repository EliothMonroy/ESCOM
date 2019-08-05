package com.example.kotlinexample
import android.content.Context
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*
class MainActivity : AppCompatActivity() {
    //Variable que no aceptará nulos
    var username:String=""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        boton.text = "Hola mundo!"
        //Variable nula
        var ejemplo : String? = null
        //Verificación nulo
        Log.d("tag:",""+ejemplo?.length)
        //Lambda
        boton.setOnClickListener{
            toast("Botón presionado")
            //Operador elvis
            if(entrada.text!!.toString().equals("")){
                setName(null)
            }else{
                setName(entrada.text.toString())
            }
        }
        //Invocando al singleton
        KotlinSingleton.myFunction(this,"Objeto singleton",Toast.LENGTH_LONG)
    }
    fun setName(name:String?){
        this.username =name?:"N/A"
        salida.text="Salida: "+this.username
    }
    fun AppCompatActivity.toast(msg:String){
        Toast.makeText(this,msg,Toast.LENGTH_LONG).show()
    }
}
//Objetos singleton
object KotlinSingleton{
    fun myFunction(context:Context, msg:String, int: Int){
        Toast.makeText(context,msg,int).show()
    }
}