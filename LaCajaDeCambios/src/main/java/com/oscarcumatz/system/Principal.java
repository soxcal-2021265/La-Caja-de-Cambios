package com.oscarcumatz.system;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import com.oscarcumatz.dominio.Auto;
import java.util.List;
import javax.persistence.TypedQuery;
import com.oscarcumatz.dominio.Factura;
import com.oscarcumatz.controller.FacturaController;
import java.util.Scanner;

public class Principal {
        private static final Scanner leer = new Scanner(System.in);
    
        public static void main(String[] args) {
        /*
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("dominio");
        EntityManager em = emf.createEntityManager();


        Auto a = em.find(Auto.class, 1);
        System.out.println(a);

        System.out.println("Lista de todas las personas");
        TypedQuery<Auto> query = em.createQuery("SELECT a FROM Auto a", Auto.class);
        List<Auto> autos = query.getResultList();

        for (Auto auto : autos) {
            System.out.println(auto);
        }

        em.clear();
        em.close();
        emf.close();                
        */
        FacturaController fcontroller = new FacturaController();
                int opcion;
                do {
                    System.out.println("--------------------------");
                    System.out.println("     La Caja de cambios  ");
                    System.out.println("--------------------------");
                    System.out.println("1.Clientes");
                    System.out.println("2.Autos");
                    System.out.println("3.Empleados");
                    System.out.println("4.Accesorios");
                    System.out.println("5.Repuestos");
                    System.out.println("5.Llantas");
                    System.out.println("7.Servicios");
                    System.out.println("8.Reparaciones");
                    System.out.println("9.Factura");
                    System.out.println("10. Salir");
                    opcion = leer.nextInt();
                    leer.nextLine();

                    switch (opcion) {
                        case 1:                            
                            break;
                        case 2:                         
                            break;
                        case 3:
                            break;
                        case 4:                           
                            break;
                        case 5:                             
                            break;
                        case 6:                       
                            break;
                        case 7:
                            break;
                        case 8:
                            break;
                        case 9:
                              fcontroller.menuFactura();
                            break;
                        case 10:
                            System.out.println("-- Saliendo --");
                            
                            break;
                        default : 
                            System.out.println("*******Opción no válida*******");
                            break;
                    }

                } while (opcion != 6);
            }
        

    }
