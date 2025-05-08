package Model;

import java.time.LocalDate;

public class Visitor {
    private int id;
    private String name;
    private String email;
    private String phone;
    private LocalDate visitDate;
    private String status; // pending, approved, checked-in, cancelled

    private int totalPasses;
    private double totalPrice;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public LocalDate getVisitDate() { return visitDate; }
    public void setVisitDate(LocalDate visitDate) { this.visitDate = visitDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getTotalPasses() { return totalPasses; }
    public void setTotalPasses(int totalPasses) { this.totalPasses = totalPasses; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}
