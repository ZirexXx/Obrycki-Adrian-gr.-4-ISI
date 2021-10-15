import java.util.Scanner;

public class Zad1d {
    public static void main(String[] args){
        Scanner scan_number = new Scanner(System.in);
        System.out.println("Podaj liczbe stanowiaca ilosc wartosci: ");
        int amount = scan_number.nextInt();
        int sum = 0;
        for(int i=1; i<=amount; i++){
            System.out.println("Podaj "+ i +" wartosc: ");
            int a = scan_number.nextInt();
            sum += Math.sqrt(Math.abs(a));
        }
        scan_number.close();
        System.out.println("Suma pierwiastkow kwadratowych z wartosci bezwzglednych podanych liczb: "+ sum);
    }
}
