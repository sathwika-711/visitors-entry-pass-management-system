package Model;

import java.sql.Date;

public class BookingsModel {
    private int bookingId;
    private int userId;
    private int locationId;
    private int numberOfAdults;
    private int numberOfChilds;
    private double totalPrice;
    private Date visitDate;
    private String status;

    // Constructors
    public BookingsModel() {}

    public BookingsModel(int bookingId, int userId, int locationId, int numberOfAdults, int numberOfChils,
                        double totalPrice, Date visitDate, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.locationId = locationId;
        this.numberOfAdults = numberOfAdults;
        this.numberOfChilds = numberOfChilds;
        this.totalPrice = totalPrice;
        this.visitDate = visitDate;
        this.status = status;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getNumberOfAdults() {
        return numberOfAdults;
    }

    public void setNumberOfAdults(int numberOfAdults) {
        this.numberOfAdults = numberOfAdults;
    }

    public int getNumberOfChildren() {
        return numberOfChilds;
    }

    public void setNumberOfChildren(int numberOfChildren) {
        this.numberOfChilds = numberOfChildren;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(Date visitDate) {
        this.visitDate = visitDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "BookingModel [bookingId=" + bookingId + ", userId=" + userId + ", locationId=" + locationId
                + ", numberOfAdults=" + numberOfAdults + ", numberOfChildren=" + numberOfChilds + ", totalPrice="
                + totalPrice + ", visitDate=" + visitDate + ", status=" + status + "]";
    }
}
