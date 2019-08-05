package com.example.devicelist;

public class Sensor {
    String value;
    String title;
    String type;
    int img;

    public Sensor(String value, String title, String type, int img) {
        this.value = value;
        this.title = title;
        this.type = type;
        this.img = img;
    }

    public String getValue() {
        return value;
    }

    public String getTitle() {
        return title;
    }

    public String getType() {
        return type;
    }

    public int getImg() {
        return img;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setImg(int img) {
        this.img = img;
    }
}
