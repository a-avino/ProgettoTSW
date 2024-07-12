package beans;

public class ProdottoOrdine {
    private int id;
    private String nome;
    private float prezzo;
    private int quantita;
    private int ordineID;

    // Costruttore vuoto
    public ProdottoOrdine() {}

    // Costruttore con parametri
    public ProdottoOrdine(int id, String nome, float prezzo, int quantita, int ordineID) {
        this.id = id;
        this.nome = nome;
        this.prezzo = prezzo;
        this.quantita = quantita;
        this.ordineID = ordineID;
    }

    // Getter e setter
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

    public float getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }

    public int getOrdineID() {
        return ordineID;
    }

    public void setOrdineID(int ordineID) {
        this.ordineID = ordineID;
    }

    @Override
    public String toString() {
        return "ProdottoOrdine{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", prezzo=" + prezzo +
                ", quantita=" + quantita +
                ", ordineID=" + ordineID +
                '}';
    }
}
