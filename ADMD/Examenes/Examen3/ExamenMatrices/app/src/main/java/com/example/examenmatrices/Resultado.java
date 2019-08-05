package com.example.examenmatrices;


import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the

 * to handle interaction events.

 * create an instance of this fragment.
 */
public class Resultado extends Fragment {

    int resultados[][];
    TableLayout tabla;
    TextView e;



    //private OnFragmentInteractionListener mListener;

    public Resultado() {
        // Required empty public constructor
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            resultados=(int[][])getArguments().getSerializable("RESULTADO");
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view= inflater.inflate(R.layout.fragment_resultado, container, false);
        tabla=view.findViewById(R.id.tabla_resultado);
        int iterar;

        Log.d("Mensaje: ",""+resultados[0].length);

        for (int i = 0; i < resultados.length; i++) {
            TableRow tableRow1=new TableRow(view.getContext());
            for (int j = 0; j < resultados[0].length; j++) {
                EditText texto = new EditText(getActivity());

                texto.setText(String.valueOf(resultados[i][j]));

                tableRow1.addView(texto);
            }
            tabla.addView(tableRow1);
        }

        return view;
    }


}