import java.util.Scanner;

public class Zad1g {
    public static void main(String[] args){
        Scanner scan_number = new Scanner(System.in);
        System.out.println("Podaj liczbe stanowiaca ilosc wartosci: ");
        int amount = scan_number.nextInt();
        int sum = 0;
        int product = 1;
        for(int i=1; i<=amount; i++){
            System.out.println("Podaj "+ i +" wartosc");
            int a = scan_number.nextInt();
            sum += a;
            product *= a;
        }
        scan_number.close();
        System.out.println("Suma podanych wartosci: "+ sum);
        System.out.println("Iloczyn podanych wartosci: "+ product);
    }
}
