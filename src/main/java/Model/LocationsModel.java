package Model;

public class LocationsModel {
    private int locationId;
    private String locationName;
    private double adultPassPrice;
    private Double childPassPrice; // Use wrapper class to allow null
    private String description;
    private String timings;  // New field added
    private String imageUrl;
    private String pincode;

    // Constructors
    public LocationsModel() {}

    public LocationsModel(int locationId, String locationName, double adultPassPrice, Double childPassPrice,
                         String description, String timings, String imageUrl, String pincode) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.adultPassPrice = adultPassPrice;
        this.childPassPrice = childPassPrice;
        this.description = description;
        this.timings = timings;
        this.imageUrl = imageUrl;
        this.pincode = pincode;
    }

    // Getters and Setters
    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public double getAdultPassPrice() {
        return adultPassPrice;
    }

    public void setAdultPassPrice(double adultPassPrice) {
        this.adultPassPrice = adultPassPrice;
    }

    public Double getChildPassPrice() {
        return childPassPrice;
    }

    public void setChildPassPrice(Double childPassPrice) {
        this.childPassPrice = childPassPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTimings() {
        return timings;  // Getter for new field
    }

    public void setTimings(String timings) {
        this.timings = timings;  // Setter for new field
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    @Override
    public String toString() {
        return "LocationModel [locationId=" + locationId + ", locationName=" + locationName +
               ", adultPassPrice=" + adultPassPrice + ", childPassPrice=" + childPassPrice +
               ", description=" + description + ", timings=" + timings +  // Updated to include timings
               ", imageUrl=" + imageUrl + ", pincode=" + pincode + "]";
    }
}
