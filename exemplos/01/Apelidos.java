import java.util.ArrayList;
import static java.util.Arrays.asList;

public class Apelidos {
    public static void main(String[] args) {
        ArrayList<Integer> lista = new ArrayList<>(asList(10, 20, 30));
        int soma = 0;
        for (Integer x : lista) {
            soma += x;
            if (x == 20) {
                lista.add(1);
            }
        }
        assert soma == 61;
    }
}
