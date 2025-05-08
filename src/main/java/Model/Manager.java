package Model;

public class Manager {
    private int managerId;
    private String name;
    private String email;
    private String password;
    private int locationId;

    // Getters and Setters
    public int getManagerId() {
        return managerId;
    }
    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
    private String location;

    public String getLocationName() {
        return location;
    }

    public void setLocationName(String locationName) {
        this.location = locationName;
    }

    
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public int getLocationId() {
        return locationId;
    }
    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }
}
