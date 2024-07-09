package beans;

import java.util.Date;

public class Ordine {
    private int id;
    private Date dataOrdine;
    private String tipoOrdine;

    // Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDataOrdine() {
        return dataOrdine;
    }

    public void setDataOrdine(Date dataOrdine) {
        this.dataOrdine = dataOrdine;
    }

    public String getTipoOrdine() {
        return tipoOrdine;
    }

    public void setTipoOrdine(String tipoOrdine) {
        this.tipoOrdine = tipoOrdine;
    }
}
