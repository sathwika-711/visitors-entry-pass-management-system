package Model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private String visitorName;
    private Date visitDate;
    private String status;
    private int userId;  // added userId field
    private int locationId;  // added locationId field
    private int numberOfAdults;  // added number of adults field
    private int numberOfChilds;  // added number of children field
    private double totalPrice;  // added total price field

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getVisitorName() {
        return visitorName;
    }

    public void setVisitorName(String visitorName) {
        this.visitorName = visitorName;
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

    public int getNumberOfChilds() {
        return numberOfChilds;
    }

    public void setNumberOfChilds(int numberOfChilds) {
        this.numberOfChilds = numberOfChilds;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

	@Override
	public String toString() {
		return "Booking [bookingId=" + bookingId + ", visitorName=" + visitorName + ", visitDate=" + visitDate
				+ ", status=" + status + ", userId=" + userId + ", locationId=" + locationId + ", numberOfAdults="
				+ numberOfAdults + ", numberOfChildren=" + numberOfChilds + ", totalPrice=" + totalPrice + "]";
	}
}
