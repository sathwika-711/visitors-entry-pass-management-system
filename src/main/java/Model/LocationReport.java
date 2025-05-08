package Model;


public class LocationReport {
    private String locationName;
    private int totalVisitors;
    private double totalRevenue;
    private double averageRevenue;

    // Getters and Setters
    public String getLocationName() {
        return locationName;
    }
    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }
    public int getTotalVisitors() {
        return totalVisitors;
    }
    public void setTotalVisitors(int totalVisitors) {
        this.totalVisitors = totalVisitors;
    }
    public double getTotalRevenue() {
        return totalRevenue;
    }
    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
    public double getAverageRevenue() {
        return averageRevenue;
    }
    public void setAverageRevenue(double averageRevenue) {
        this.averageRevenue = averageRevenue;
    }
    @Override
    public String toString() {
        return "LocationReport [locationName=" + locationName + ", totalVisitors=" + totalVisitors + ", totalRevenue="
                + totalRevenue + ", averageRevenue=" + averageRevenue + "]";
    }

}
