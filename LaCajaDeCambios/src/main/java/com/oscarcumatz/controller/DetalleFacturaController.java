package com.oscarcumatz.controller;

import com.oscarcumatz.dominio.DetalleFactura;

import javax.persistence.*;
import java.util.List;
import java.util.Scanner;

public class DetalleFacturaController {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("dominio");
    private static final Scanner leer = new Scanner(System.in);

    public static void menuDetalleFactura() {
        int opcion;
        do {
            System.out.println("  MENÚ DE DETALLES DE FACTURA  ");
            System.out.println("--------------------------------");
            System.out.println("1. Agregar Detalle");
            System.out.println("2. Listar Detalles");
            System.out.println("3. Buscar Detalle");
            System.out.println("4. Editar Detalle");
            System.out.println("5. Eliminar Detalle");
            System.out.println("6. Salir");
            opcion = leer.nextInt();
            leer.nextLine();

            switch (opcion) {
                case 1: agregarDetalleFactura();
                    break;
                case 2: listarDetallesFactura();
                    break;
                case 3: buscarDetalleFactura();
                    break;
                case 4: editarDetalleFactura();
                    break;
                case 5: eliminarDetalleFactura();
                    break;
                case 6:
                    System.out.println("Regresando al menú principal");
                    break;
                default:
                    System.out.println("*******Opción no válida*******");
                    break;
            }
        } while (opcion != 6);
    }

    // Agregar Detalle
    public static void agregarDetalleFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Código de Factura: ");
        int codigoFactura = leer.nextInt();
        leer.nextLine();
        System.out.print("Tipo de Gasto (Servicio/Reparacion/Llanta/Repuesto/Accesorio): ");
        String tipoGastoStr = leer.nextLine();
        DetalleFactura.TipoGasto tipoGasto = DetalleFactura.TipoGasto.valueOf(tipoGastoStr);
        System.out.print("Código de Gasto: ");
        int codigoGasto = leer.nextInt();
        System.out.print("Cantidad: ");
        int cantidad = leer.nextInt();

        try {
            tx.begin();
            DetalleFactura detalle = new DetalleFactura(0, codigoFactura, tipoGasto, codigoGasto, cantidad);
            em.persist(detalle); // Agregar el detalle
            tx.commit();
            System.out.println("Detalle de factura agregado correctamente.");
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al agregar detalle: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Listar todos los Detalles de Factura
    public static void listarDetallesFactura() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DetalleFactura> query = em.createQuery("SELECT d FROM DetalleFactura d", DetalleFactura.class);
            List<DetalleFactura> detalles = query.getResultList();
            System.out.println("\n*** Lista de Detalles de Factura ***");
            for (DetalleFactura detalle : detalles) {
                System.out.println(detalle);
            }
        } finally {
            em.close();
        }
    }

    // Buscar un Detalle por código
    public static void buscarDetalleFactura() {
        EntityManager em = emf.createEntityManager();
        System.out.print("Ingrese el código del detalle a buscar: ");
        int codigoDetalle = leer.nextInt();

        try {
            DetalleFactura detalle = em.find(DetalleFactura.class, codigoDetalle);
            if (detalle == null) {
                System.out.println("Detalle no encontrado.");
            } else {
                System.out.println(detalle);
            }
        } finally {
            em.close();
        }
    }

    // Editar un Detalle
    public static void editarDetalleFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código del detalle a editar: ");
        int codigoDetalle = leer.nextInt();
        System.out.print("Nuevo código de factura: ");
        int codigoFactura = leer.nextInt();
        leer.nextLine();
        System.out.print("Nuevo tipo de gasto (Servicio/Reparacion/Llanta/Repuesto/Accesorio): ");
        String tipoGastoStr = leer.nextLine();
        DetalleFactura.TipoGasto tipoGasto = DetalleFactura.TipoGasto.valueOf(tipoGastoStr);
        System.out.print("Nuevo código de gasto: ");
        int codigoGasto = leer.nextInt();
        System.out.print("Nueva cantidad: ");
        int cantidad = leer.nextInt();

        try {
            tx.begin();
            DetalleFactura detalle = em.find(DetalleFactura.class, codigoDetalle);
            if (detalle != null) {
                detalle.setCodigoFactura(codigoFactura);
                detalle.setTipoGasto(tipoGasto);
                detalle.setCodigoGasto(codigoGasto);
                detalle.setCantidad(cantidad);
                em.merge(detalle); // Editar el detalle
                tx.commit();
                System.out.println("Detalle de factura editado correctamente.");
            } else {
                System.out.println("Detalle no encontrado.");
            }
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al editar detalle: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Eliminar un Detalle
    public static void eliminarDetalleFactura() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código del detalle a eliminar: ");
        int codigoDetalle = leer.nextInt();

        try {
            tx.begin();
            DetalleFactura detalle = em.find(DetalleFactura.class, codigoDetalle);
            if (detalle != null) {
                em.remove(detalle); // Eliminar el detalle
                tx.commit();
                System.out.println("Detalle eliminado correctamente.");
            } else {
                System.out.println("Detalle no encontrado.");
            }
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al eliminar detalle: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        menuDetalleFactura();
    }
}
