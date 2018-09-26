package com.wd.backend.model;

/**
 * Created by DimonHo on 2018/1/2.
 */
public class CoreExpansion {

    private int id;
    private String category;
    private String categorySystem;
    private String core;
    private String cssn;
    private String issn;
    private String jguid;
    private String rangeyear;
    private boolean status;
    private String title;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategorySystem() {
        return categorySystem;
    }

    public void setCategorySystem(String categorySystem) {
        this.categorySystem = categorySystem;
    }

    public String getCore() {
        return core;
    }

    public void setCore(String core) {
        this.core = core;
    }

    public String getCssn() {
        return cssn;
    }

    public void setCssn(String cssn) {
        this.cssn = cssn;
    }

    public String getIssn() {
        return issn;
    }

    public void setIssn(String issn) {
        this.issn = issn;
    }

    public String getJguid() {
        return jguid;
    }

    public void setJguid(String jguid) {
        this.jguid = jguid;
    }

    public String getRangeyear() {
        return rangeyear;
    }

    public void setRangeyear(String rangeyear) {
        this.rangeyear = rangeyear;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
