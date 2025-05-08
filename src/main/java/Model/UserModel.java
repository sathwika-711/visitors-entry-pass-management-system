package Model;

public class UserModel {
    private int userId;
    private String name;
    private String mobile;
    private String email;
    private String address;
    private String gender;
    private String password;
    private String role;

    // Constructors
    public UserModel() {}

    public UserModel(int userId, String name, String mobile, String email, String address) {
		super();
		this.userId = userId;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.address = address;
	}

	@Override
	public String toString() {
		return "UserModel [userId=" + userId + ", name=" + name + ", mobile=" + mobile + ", email=" + email
				+ ", address=" + address + ", gender=" + gender + ", password=" + password + ", role=" + role + "]";
	}

	public UserModel(int userId, String name, String mobile, String email, String address, String gender, String password, String role) {
        this.userId = userId;
        this.name = name;
        this.mobile = mobile;
        this.email = email;
        this.address = address;
        this.gender = gender;
        this.password = password;
        this.role = role;
    }

    public UserModel(String name2, String password2, String mobile2, String email2, String gender2) {
        this.name = name2;
        this.mobile = mobile2;
        this.email = email2;
        this.gender = gender2;
        this.password = password2;
	}



	// Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
