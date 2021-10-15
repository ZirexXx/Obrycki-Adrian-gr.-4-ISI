import java.util.Scanner;

public class Zad1i {
    public static int factorial(int number){
        for(int i=number-1; i>0; i--){
            number *= i;
        }
        return number;
    }
    public static void main(String[] args){
        Scanner scan_number = new Scanner(System.in);
        System.out.println("Podaj liczbe stanowiaca ilosc wartosci: ");
        int amount = scan_number.nextInt();
        double sum = 0.0;
        for(int i=1; i<=amount; i++){
            System.out.println("Podaj "+ i +" wartosc: ");
            int a = scan_number.nextInt();
            sum += (Math.pow((-1), i) * a)/factorial(a);
        }
        scan_number.close();
        System.out.println("Wynik sumy dzialania ((-1)^n*a_n)/n! : " + sum);
    }
}
