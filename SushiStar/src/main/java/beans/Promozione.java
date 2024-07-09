package beans;

import java.util.Date;

public class Promozione {
    private int id;
    private String nome;
    private String descrizione;
    private float percentualeSconto;
    private Date periodoValidita;

    // Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public float getPercentualeSconto() {
        return percentualeSconto;
    }

    public void setPercentualeSconto(float percentualeSconto) {
        this.percentualeSconto = percentualeSconto;
    }

    public Date getPeriodoValidita() {
        return periodoValidita;
    }

    public void setPeriodoValidita(Date periodoValidita) {
        this.periodoValidita = periodoValidita;
    }
}
