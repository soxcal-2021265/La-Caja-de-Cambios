package com.oscarcumatz.controller;

import com.oscarcumatz.dominio.Cliente;

import javax.persistence.*;
import java.util.List;
import java.util.Scanner;

public class ClienteController {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("dominio");
    private static final Scanner leer = new Scanner(System.in);

    public static void menuCliente() {
        int opcion;
        do {
            System.out.println("\n     MENÚ DE CLIENTES  ");
            System.out.println("-----------------------------");
            System.out.println("1. Agregar Cliente");
            System.out.println("2. Listar Clientes");
            System.out.println("3. Buscar Cliente");
            System.out.println("4. Editar Cliente");
            System.out.println("5. Eliminar Cliente");
            System.out.println("6. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = leer.nextInt();
            leer.nextLine();

            switch (opcion) {
                case 1: agregarCliente(); break;
                case 2: listarClientes(); break;
                case 3: buscarCliente(); break;
                case 4: editarCliente(); break;
                case 5: eliminarCliente(); break;
                case 6: System.out.println("Regresando al menú principal..."); break;
                default: System.out.println("*** Opción no válida ***"); break;
            }

        } while (opcion != 6);
    }

    public static void agregarCliente() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Nombre del Cliente: ");
        String nombre = leer.nextLine();
        System.out.print("Teléfono: ");
        String telefono = leer.nextLine();
        System.out.print("Correo: ");
        String correo = leer.nextLine();
        System.out.print("Dirección: ");
        String direccion = leer.nextLine();
        System.out.print("Contraseña: ");
        String contrasena = leer.nextLine();

        try {
            tx.begin();
            Cliente cliente = new Cliente();
            cliente.setNombreCliente(nombre);
            cliente.setTelefonoCliente(telefono);
            cliente.setCorreoCliente(correo);
            cliente.setDireccion(direccion);
            cliente.setContrasena(contrasena);
            em.persist(cliente);
            tx.commit();
            System.out.println("Cliente agregado correctamente.");
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al agregar cliente: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public static void listarClientes() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Cliente> query = em.createQuery("SELECT c FROM Cliente c", Cliente.class);
            List<Cliente> clientes = query.getResultList();
            System.out.println("\n** Lista de Clientes **");
            for (Cliente cliente : clientes) {
                System.out.println(cliente);
            }
        } finally {
            em.close();
        }
    }

    public static void buscarCliente() {
        EntityManager em = emf.createEntityManager();
        System.out.print("Ingrese el código del cliente a buscar: ");
        int codigo = leer.nextInt();

        try {
            Cliente cliente = em.find(Cliente.class, codigo);
            if (cliente == null) {
                System.out.println("Cliente no encontrado.");
            } else {
                System.out.println(cliente);
            }
        } finally {
            em.close();
        }
    }

    public static void editarCliente() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código del cliente a editar: ");
        int codigo = leer.nextInt();
        leer.nextLine(); // Para consumir el salto de línea

        System.out.print("Nuevo nombre: ");
        String nombre = leer.nextLine();
        System.out.print("Nuevo teléfono: ");
        String telefono = leer.nextLine();
        System.out.print("Nuevo correo: ");
        String correo = leer.nextLine();
        System.out.print("Nueva dirección: ");
        String direccion = leer.nextLine();
        System.out.print("Nueva contraseña: ");
        String contrasena = leer.nextLine();

        try {
            Cliente cliente = em.find(Cliente.class, codigo);
            if (cliente != null) {
                tx.begin();
                cliente.setNombreCliente(nombre);
                cliente.setTelefonoCliente(telefono);
                cliente.setCorreoCliente(correo);
                cliente.setDireccion(direccion);
                cliente.setContrasena(contrasena);
                em.merge(cliente);
                tx.commit();
                System.out.println("Cliente editado correctamente.");
            } else {
                System.out.println("Cliente no encontrado.");
            }
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al editar cliente: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public static void eliminarCliente() {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        System.out.print("Ingrese el código del cliente a eliminar: ");
        int codigo = leer.nextInt();

        try {
            Cliente cliente = em.find(Cliente.class, codigo);
            if (cliente != null) {
                tx.begin();
                em.remove(cliente);
                tx.commit();
                System.out.println("Cliente eliminado correctamente.");
            } else {
                System.out.println("Cliente no encontrado.");
            }
        } catch (Exception e) {
            tx.rollback();
            System.err.println("Error al eliminar cliente: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public static void main(String[] args) {
        menuCliente();
    }
}
