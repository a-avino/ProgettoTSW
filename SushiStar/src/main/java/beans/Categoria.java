package beans;

public class Categoria {
    private int id;

    private String descrizione;
    private String nome;

    @Override
    public String toString() {
        return "Categoria{" +
                "id=" + id +
                ", descrizione='" + descrizione + '\'' +
                ", nome='" + nome + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Categoria(int id, String descrizione, String nome) {
        this.id = id;
        this.descrizione = descrizione;
        this.nome = nome;
    }

    public Categoria() {

    }
}
