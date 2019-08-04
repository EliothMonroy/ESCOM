/*
	Referencias para los tamaños/traslación/rotación planetas
	*http://www.batanga.com/curiosidades/4233/a-que-velocidad-se-mueven-los-planetas
	*http://www.sistesolar.com.ar/datos.php
*/
import com.sun.j3d.utils.geometry.*;
import com.sun.j3d.utils.image.TextureLoader;
import com.sun.j3d.utils.universe.*;
import javax.media.j3d.*;
import javax.vecmath.*;
import java.awt.*;
import javax.swing.*;
import java.util.*;
public class SolarSis {
	public SolarSis(){
		//Definimos los elementos, los planetas y el grupo
		BranchGroup group = new BranchGroup();
		Appearance appsol = new Appearance();
		Appearance appearth = new Appearance();
		Appearance appmercurio = new Appearance();
		Appearance appvenus = new Appearance();
		Appearance appmarte = new Appearance();
		Appearance appjupiter = new Appearance();
		Appearance appsaturno = new Appearance();
		Appearance appurano = new Appearance();
		Appearance appneptuno = new Appearance();
		Appearance apppluton = new Appearance();
		//Ahora cargamos las texturas
		TextureLoader tex=new TextureLoader("TIERRA.JPG", null);
		appearth.setTexture(tex.getTexture());
		tex=new TextureLoader("SOL.JPG", null);
		appsol.setTexture(tex.getTexture());
		tex=new TextureLoader("MERCURIO.JPG", null);
		appmercurio.setTexture(tex.getTexture());
		tex=new TextureLoader("VENUS.JPG", null);
		appvenus.setTexture(tex.getTexture());
		tex=new TextureLoader("MARTE.JPG", null);
		appmarte.setTexture(tex.getTexture());
		tex=new TextureLoader("JUPITER.JPG", null);
		appjupiter.setTexture(tex.getTexture());
		tex=new TextureLoader("SATURNO.JPG", null);
		appsaturno.setTexture(tex.getTexture());
		tex=new TextureLoader("URANO.JPG", null);
		appurano.setTexture(tex.getTexture());
		tex=new TextureLoader("NEPTUNO.JPG", null);
		appneptuno.setTexture(tex.getTexture());
		tex=new TextureLoader("PLUTON.JPG", null);
		apppluton.setTexture(tex.getTexture());
		//Creamos los planetas
		Sphere earth = new Sphere(0.006f, Primitive.GENERATE_NORMALS |Primitive.GENERATE_TEXTURE_COORDS, 32, appearth);
		Sphere sol = new Sphere(.35f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appsol);
		Sphere mercurio = new Sphere(0.002f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appmercurio);
		Sphere venus = new Sphere(0.005f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appvenus);
		Sphere marte = new Sphere(0.0025f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appmarte);
		Sphere jupiter = new Sphere(0.07f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appjupiter);
		Sphere saturno = new Sphere(0.05f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appsaturno);
		Sphere urano = new Sphere(0.025f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appurano);
		Sphere neptuno = new Sphere(0.024f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, appneptuno);
		Sphere pluton = new Sphere(0.001f, Primitive.GENERATE_NORMALS | Primitive.GENERATE_TEXTURE_COORDS, 32, apppluton);
		//Ahora les agregamos su movimiento de rotación
		TransformGroup earthRotXformGroup = Posi.rotate(earth, new Alpha(-1, 16));
		TransformGroup solRotXformGroup = Posi.rotate(sol, new Alpha(-1, 1674));
		TransformGroup mercurioRotXformGroup = Posi.rotate(mercurio, new Alpha(-1, 108));
		TransformGroup venusRotXformGroup = Posi.rotate(venus, new Alpha(-1, 60));
		TransformGroup marteRotXformGroup = Posi.rotate(marte, new Alpha(-1, 866));
		TransformGroup jupiterRotXformGroup = Posi.rotate(jupiter, new Alpha(-1, 45583));
		TransformGroup saturnoRotXformGroup = Posi.rotate(saturno, new Alpha(-1, 36840));
		TransformGroup uranoRotXformGroup = Posi.rotate(urano, new Alpha(-1, 14794));
		TransformGroup neptunoRotXformGroup = Posi.rotate(neptuno, new Alpha(-1, 9719));
		TransformGroup plutonRotXformGroup = Posi.rotate(pluton, new Alpha(-1, 5000));
		//El de translación
		TransformGroup earthTransXformGroup = Posi.translate(earthRotXformGroup, new Vector3f(0.0f, 0.0f, .7f));
		TransformGroup earthRotGroupXformGroup = Posi.rotate(earthTransXformGroup, new Alpha(-1, 5000));
		TransformGroup mercurioTransXformGroup = Posi.translate(mercurioRotXformGroup, new Vector3f(0.0f, 0.0f, .4f));
		TransformGroup mercurioRotGroupXformGroup = Posi.rotate(mercurioTransXformGroup, new Alpha(-1, 3460));
		TransformGroup venusTransXformGroup = Posi.translate(venusRotXformGroup, new Vector3f(0.0f, 0.0f, .55f));
		TransformGroup venusRotGroupXformGroup = Posi.rotate(venusTransXformGroup, new Alpha(-1, 4400));
		TransformGroup marteTransXformGroup = Posi.translate(marteRotXformGroup, new Vector3f(0.0f, 0.0f, .85f));
		TransformGroup marteRotGroupXformGroup = Posi.rotate(marteTransXformGroup, new Alpha(-1, 5600));
		TransformGroup jupiterTransXformGroup = Posi.translate(jupiterRotXformGroup, new Vector3f(0.0f, 0.0f, 1f));
		TransformGroup jupiterRotGroupXformGroup = Posi.rotate(jupiterTransXformGroup, new Alpha(-1, 10000));
		TransformGroup saturnoTransXformGroup = Posi.translate(saturnoRotXformGroup, new Vector3f(0.0f, 0.0f, 1.15f));
		TransformGroup saturnoRotGroupXformGroup = Posi.rotate(saturnoTransXformGroup, new Alpha(-1, 12000));
		TransformGroup uranoTransXformGroup = Posi.translate(uranoRotXformGroup, new Vector3f(0.0f, 0.0f, 1.3f));
		TransformGroup uranoRotGroupXformGroup = Posi.rotate(uranoTransXformGroup, new Alpha(-1, 14000));
		TransformGroup neptunoTransXformGroup = Posi.translate(neptunoRotXformGroup, new Vector3f(0.0f, 0.0f, 1.45f));
		TransformGroup neptunoRotGroupXformGroup = Posi.rotate(neptunoTransXformGroup, new Alpha(-1, 15000));
		TransformGroup plutonTransXformGroup = Posi.translate(plutonRotXformGroup, new Vector3f(0.0f, 0.0f, 1.6f));
		TransformGroup plutonRotGroupXformGroup = Posi.rotate(plutonTransXformGroup, new Alpha(-1, 16000));
		//Los agregamos al grupo
		group.addChild(earthRotGroupXformGroup);
		group.addChild(solRotXformGroup);
		group.addChild(mercurioRotGroupXformGroup);
		group.addChild(venusRotGroupXformGroup);
		group.addChild(marteRotGroupXformGroup);
		group.addChild(jupiterRotGroupXformGroup);
		group.addChild(saturnoRotGroupXformGroup);
		group.addChild(uranoRotGroupXformGroup);
		group.addChild(neptunoRotGroupXformGroup);
		group.addChild(plutonRotGroupXformGroup);
		//Configuración de la ventana
		GraphicsConfiguration config = SimpleUniverse.getPreferredConfiguration();
		Canvas3D canvas = new Canvas3D(config);
		canvas.setSize(1400, 850);
		SimpleUniverse universe = new SimpleUniverse(canvas);
		universe.getViewingPlatform().setNominalViewingTransform();
		universe.addBranchGraph(group);  
		JFrame f = new JFrame("Planetario");
		f.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		f.add(canvas);
		f.pack();
		f.setVisible(true);
	}
	public static void main(String a[]) {
		new SolarSis();
	}
}
