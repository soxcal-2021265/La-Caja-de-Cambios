/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.oscarcumatz.system;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import com.oscarcumatz.dominio.Cliente;
import java.util.List;
import javax.persistence.TypedQuery;

public class Principal {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("dominio"); //Unidad de persistencia creada dominio
        EntityManager em = emf.createEntityManager(); //Fabrica los objetos del EntityManager, 
        
        Cliente c = em.find(Cliente.class, 6); //Valor de la clase persona (find) encuentra (el valor e: es el codigo a buscar)
        System.out.println(c); //muestra la persona (p)
        
        /*System.out.println("Lista de todas las persaonas");
        TypedQuery<Persona> query = em.createQuery("SELECT p FROM Persona p", Persona.class);
        List<Persona> personas = query.getResultList();
        
        for(Persona persona : personas) {
            System.out.println(persona);
        }
        */
        emf.close(); //Cierra el EntityManagerFactory
        /*em.clear(); //Cierra el EntityManager*/
    }
}