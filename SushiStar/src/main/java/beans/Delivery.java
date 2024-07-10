package beans;

public class Delivery {
    private int id;
    private String indirizzoConsegna;
    private int ordineID;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIndirizzoConsegna() {
        return indirizzoConsegna;
    }

    public void setIndirizzoConsegna(String indirizzoConsegna) {
        this.indirizzoConsegna = indirizzoConsegna;
    }

    public int getOrdineID() {
        return ordineID;
    }

    public void setOrdineID(int ordineID) {
        this.ordineID = ordineID;
    }
}
