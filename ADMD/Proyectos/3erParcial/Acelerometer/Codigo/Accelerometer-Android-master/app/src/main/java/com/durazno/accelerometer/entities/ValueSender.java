package com.durazno.accelerometer.entities;

public class ValueSender {
    String value;

    public ValueSender(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
