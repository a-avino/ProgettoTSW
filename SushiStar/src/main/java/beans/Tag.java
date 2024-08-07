package beans;

public class Tag {

    private int id;
    private String nome;

    public Tag(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public Tag(){

    }
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

    @Override
    public String toString() {
        return "Tag{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                '}';
    }

}
