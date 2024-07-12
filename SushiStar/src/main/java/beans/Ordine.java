package beans;

import java.util.Date;
import java.util.List;

public class Ordine {
    private int id;
    private Date dataOrdine;
    private String tipoOrdine;
    private List<ProdottoOrdine> prodottiOrdine;

    // Getter e setter per id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter e setter per dataOrdine
    public Date getDataOrdine() {
        return dataOrdine;
    }

    public void setDataOrdine(Date dataOrdine) {
        this.dataOrdine = dataOrdine;
    }

    // Getter e setter per tipoOrdine
    public String getTipoOrdine() {
        return tipoOrdine;
    }

    public void setTipoOrdine(String tipoOrdine) {
        this.tipoOrdine = tipoOrdine;
    }

    // Getter e setter per prodottiOrdine
    public List<ProdottoOrdine> getProdottiOrdine() {
        return prodottiOrdine;
    }

    public void setProdottiOrdine(List<ProdottoOrdine> prodottiOrdine) {
        this.prodottiOrdine = prodottiOrdine;
    }
}
