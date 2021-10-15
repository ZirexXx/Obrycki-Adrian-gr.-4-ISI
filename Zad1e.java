import java.util.Scanner;

public class Zad1e {
    public static void main(String[] args){
        Scanner scan_number = new Scanner(System.in);
        System.out.println("Podaj liczbe stanowiaca ilosc wartosci: ");
        int amount = scan_number.nextInt();
        int product = 1;
        for(int i=1; i<=amount; i++){
            System.out.println("Podaj "+ i +" wartosc: ");
            int a = scan_number.nextInt();
            product *= Math.abs(a);
        }
        scan_number.close();
        System.out.println("Iloczyn wartosci bezwzglednych podanych liczb: "+ product);
    }
}
