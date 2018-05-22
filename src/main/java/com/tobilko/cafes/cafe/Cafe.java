package com.tobilko.cafes.cafe;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Objects;

/**
 * Created by Andrew Tobilko on 5/21/18.
 */
@Entity
public class Cafe {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    private Double latitude;
    private Double longitude;

    private String title;
    private String site;
    private String phone;
    private String schedule;

    public Cafe() {
    }

    public Cafe(Double latitude, Double longitude, String title, String site, String phone, String schedule) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.title = title;
        this.site = site;
        this.phone = phone;
        this.schedule = schedule;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cafe cafe = (Cafe) o;
        return Objects.equals(id, cafe.id);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id);
    }
}
