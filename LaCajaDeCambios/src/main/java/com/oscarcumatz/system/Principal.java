package com.oscarcumatz.system;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import com.oscarcumatz.dominio.Auto;
import java.util.List;
import javax.persistence.TypedQuery;

public class Principal {
    public static void main(String[] args) {
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
    }
}