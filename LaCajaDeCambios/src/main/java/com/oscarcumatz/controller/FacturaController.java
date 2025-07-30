package com.oscarcumatz.controller;

import com.oscarcumatz.dominio.Factura;
import com.oscarcumatz.dominio.Factura.MetodoPago;

import javax.persistence.*;
import java.util.List;
import java.util.Scanner;

public class FacturaController {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("dominio");
    private static final Scanner leer = new Scanner(System.in);

    public static void menuFactura() {
        int opcion;
        do {
            System.out.println("     MENÚ DE FACTURAS  ");
            System.out.println("--------------------------");
            System.out.println("1. Agregar Factura");
            System.out.println("2. Listar Facturas");
            System.out.println("3. Buscar Factura");
            System.out.println("4. Editar Factura");
            System.out.println("5. Eliminar Factura");
            System.out.println("6. Salir");
            opcion = leer.nextInt();
            leer.nextLine();

            switch (opcion) {
                case 1: agregarFactura(); break;
                case 2: listarFacturas(); break;
                case 3: buscarFactura(); break;
                case 4: editarFactura(); break;
                case 5: eliminarFactura(); break;
                case 6:
                    System.out.println("Regresando al menú Inicio");
                    break;
                default:
                    System.out.println("******* Opción no válida *******");
            }

        } while (opcion != 6);
    }

    // Agregar nueva factura
    public static void agregarFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            System.out.print("Código Cliente: ");
            int codigoCliente = leer.nextInt();
            System.out.print("Código Empleado: ");
            int codigoEmpleado = leer.nextInt();
            System.out.print("Código Auto: ");
            int codigoAuto = leer.nextInt();
            System.out.print("Fecha de Emisión (yyyy-mm-dd): ");
            String fechaEmision = leer.next();
            System.out.print("Método de Pago (Efectivo/Targeta): ");
            String metodo = leer.next();

            MetodoPago metodoPago = MetodoPago.valueOf(metodo);

            Factura factura = new Factura();
            factura.setCodigoClienteFactura(codigoCliente);
            factura.setCodigoEmpleadoFactura(codigoEmpleado);
            factura.setCodigoAutoFactura(codigoAuto);
            factura.setFechaEmision(fechaEmision);
            factura.setMetodoPago(metodoPago);
            factura.setTotal(0.0); // puedes calcular o actualizar el total luego

            tx.begin();
            em.persist(factura);
            tx.commit();
            System.out.println("Factura agregada correctamente.");
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al agregar factura: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Listar todas las facturas
    public static void listarFacturas() {
        EntityManager em = emf.createEntityManager();
        try {
            List<Factura> facturas = em.createQuery("SELECT f FROM Factura f", Factura.class).getResultList();
            System.out.println("\n*** Lista de Facturas ***");
            for (Factura f : facturas) {
                System.out.println(f);
            }
        } finally {
            em.close();
        }
    }

    // Buscar factura por ID
    public static void buscarFactura() {
        EntityManager em = emf.createEntityManager();
        System.out.print("Ingrese el código de la factura a buscar: ");
        int codigo = leer.nextInt();

        try {
            Factura f = em.find(Factura.class, codigo);
            if (f == null) {
                System.out.println("Factura no encontrada.");
            } else {
                System.out.println(f);
            }
        } finally {
            em.close();
        }
    }

    // Editar factura
    public static void editarFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código de la factura a editar: ");
        int id = leer.nextInt();

        try {
            Factura factura = em.find(Factura.class, id);
            if (factura == null) {
                System.out.println("Factura no encontrada.");
                return;
            }

            System.out.print("Nuevo código de cliente: ");
            factura.setCodigoClienteFactura(leer.nextInt());
            System.out.print("Nuevo código de empleado: ");
            factura.setCodigoEmpleadoFactura(leer.nextInt());
            System.out.print("Nuevo código de auto: ");
            factura.setCodigoAutoFactura(leer.nextInt());
            System.out.print("Fecha de emisión (yyyy-mm-dd): ");
            factura.setFechaEmision(leer.next());
            System.out.print("Nuevo total: ");
            factura.setTotal(leer.nextDouble());
            System.out.print("Nuevo método de pago (Efectivo/Targeta): ");
            factura.setMetodoPago(MetodoPago.valueOf(leer.next()));

            tx.begin();
            em.merge(factura);
            tx.commit();
            System.out.println("Factura actualizada correctamente.");
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al editar factura: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Eliminar factura
    public static void eliminarFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código de la factura a eliminar: ");
        int codigo = leer.nextInt();

        try {
            Factura factura = em.find(Factura.class, codigo);
            if (factura == null) {
                System.out.println("Factura no encontrada.");
                return;
            }

            tx.begin();
            em.remove(factura);
            tx.commit();
            System.out.println("Factura eliminada correctamente.");
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al eliminar factura: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        menuFactura();
    }
}
