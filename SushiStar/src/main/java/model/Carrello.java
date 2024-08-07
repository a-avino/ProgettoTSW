package model;

import beans.ProdottoCarrello;
import beans.ProdottoCatalogo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Carrello implements Serializable {

    private static final long serialVersionUID = 1L;

    List<ProdottoCarrello> prodotti;

    public Carrello() {
        prodotti = new ArrayList<>();
    }

    public void aggiungiProdotto(ProdottoCatalogo product, int quantità) {
        ProdottoCarrello cartProd = new ProdottoCarrello(product);
        if (prodotti.contains(cartProd)) {
            var prod = prodotti.get(prodotti.indexOf(cartProd));
            prod.setQuantità(prod.getQuantità() + quantità);
        } else {
            cartProd.setQuantità(quantità);
            prodotti.add(cartProd);
        }
    }

    public void rimuoviProdotto(ProdottoCatalogo product) {
        ProdottoCarrello cartProd = new ProdottoCarrello(product);
        for (ProdottoCarrello prod : prodotti) {
            if (prod.equals(cartProd)) {
                prodotti.remove(prod);
                break;
            }
        }
    }

    public boolean isEmpty() {
        return prodotti.isEmpty();
    }

    public List<ProdottoCarrello> getProdotti() {
        return prodotti;
    }

    public int getQuantitàTotaleProdotti() {
        var sum = 0;
        for (ProdottoCarrello prod : prodotti) {
            sum += prod.getQuantità();
        }
        return sum;
    }

    public double getPrezzoTotaleProdotti() {
        double sum = 0;
        for (ProdottoCarrello prod : prodotti) {
            sum += prod.getPrezzoTotale();
        }
        return sum;
    }

    public void rimuoviTutti() {
        prodotti = new ArrayList<>();
    }

    public void aggiornaProdotti(ProdottoCatalogo prodotto, int quantità) {
        ProdottoCarrello cartProd = new ProdottoCarrello(prodotto);
        if (prodotti.contains(cartProd)) {
            var prod = prodotti.get(prodotti.indexOf(cartProd));
            prod.setQuantità(quantità);
        }
    }
}
