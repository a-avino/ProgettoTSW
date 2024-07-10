package beans;

import java.sql.Time;

public class Takeaway {
    private int id;
    private Time orarioRitiro;
    private int ordineID;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Time getOrarioRitiro() {
        return orarioRitiro;
    }

    public void setOrarioRitiro(Time orarioRitiro) {
        this.orarioRitiro = orarioRitiro;
    }

    public int getOrdineID() {
        return ordineID;
    }

    public void setOrdineID(int ordineID) {
        this.ordineID = ordineID;
    }
}
