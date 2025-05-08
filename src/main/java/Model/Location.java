package Model;

public class Location {
    private int locationId;
    private String locationName;
    private double adultPassPrice;
    private Double childPassPrice;
    private String description;
    private String timings;
    private String imageUrl;
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
		return timings;
	}
	public void setTimings(String timings) {
		this.timings = timings;
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
	private String pincode;

    // Getters and Setters
    // ... (Add all fields here)
}
