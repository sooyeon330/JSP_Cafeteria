package test;

import java.util.ArrayList;

public class Cafeteria {
	String id;
	String eatdate;
	String eatday;
	ArrayList<String> breakfast;
	ArrayList<String> lunch;
	ArrayList<String> dinner;
	
	
	public Cafeteria() {
		
	}
	
	public Cafeteria(String id, String eatdate, String eatday, ArrayList<String> breakfast, ArrayList<String> lunch,
			ArrayList<String> dinner) {
		super();
		this.id = id;
		this.eatdate = eatdate;
		this.eatday = eatday;
		this.breakfast = breakfast;
		this.lunch = lunch;
		this.dinner = dinner;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEatdate() {
		return eatdate;
	}
	public void setEatdate(String eatdate) {
		this.eatdate = eatdate;
	}
	public String getEatday() {
		return eatday;
	}
	public void setEatday(String eatday) {
		this.eatday = eatday;
	}
	public ArrayList<String> getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(ArrayList<String> breakfast) {
		this.breakfast = breakfast;
	}
	public ArrayList<String> getLunch() {
		return lunch;
	}
	public void setLunch(ArrayList<String> lunch) {
		this.lunch = lunch;
	}
	public ArrayList<String> getDinner() {
		return dinner;
	}
	public void setDinner(ArrayList<String> dinner) {
		this.dinner = dinner;
	}
	
	
}
