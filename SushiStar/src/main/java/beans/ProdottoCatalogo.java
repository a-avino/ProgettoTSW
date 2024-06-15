package beans;

public class ProdottoCatalogo {

    //Variabili d'istanza
    private int id;
    private String nome;
    private String descrizione;
    private String nomeFoto;
    private int pezziPorzione;
    private float prezzo;

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

    public String getNomeFoto() {
        return nomeFoto;
    }

    public void setNomeFoto(String nomeFoto) {
        this.nomeFoto = nomeFoto;
    }

    public int getPezziPorzione() {
        return pezziPorzione;
    }

    public void setPezziPorzione(int pezziPorzione) {
        this.pezziPorzione = pezziPorzione;
    }

    public float getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }

    public int getCategoriaID() {
        return categoriaID;
    }

    public void setCategoriaID(int categoriaID) {
        this.categoriaID = categoriaID;
    }

    private int categoriaID;

    public ProdottoCatalogo(int id, String nome, String descrizione, String nomeFoto, int pezziPorzione, float prezzo, int categoriaID) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.nomeFoto = nomeFoto;
        this.pezziPorzione = pezziPorzione;
        this.prezzo = prezzo;
        this.categoriaID = categoriaID;
    }

    public  ProdottoCatalogo (){

    }

    @Override
    public String toString() {
        return "ProdottoCatalogo{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", nomeFoto='" + nomeFoto + '\'' +
                ", pezziPorzione=" + pezziPorzione +
                ", prezzo=" + prezzo +
                ", categoriaID=" + categoriaID +
                '}';
    }
}