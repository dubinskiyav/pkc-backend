package biz.gelicon.core.view.admin;

import biz.gelicon.core.model.admin.Proguser;
import io.swagger.v3.oas.annotations.media.Schema;
import javax.persistence.Column;

/* Объект сгенерирован 27.04.2021 09:20 */
@Schema(description = "Представление объекта \"Пользователь\"")
public class ProguserView {

    @Schema(description = "Идентификатор \"Пользователь\"")
    @Column(name="proguser_id")
    public Integer proguserId;

    @Schema(description = "Идентификатор статуса")
    @Column(name="proguser_status_id")
    private Integer statusId;

    @Schema(description = "Статус")
    @Column(name="proguser_status_display",table = "capcode")
    private String statusDisplay;

    @Schema(description = "Имя")
    @Column(name="proguser_name")
    private String proguserName;

    @Schema(description = "Полное имя")
    @Column(name="proguser_fullname")
    private String proguserFullname;

    @Schema(description = "WEB пароль")
    @Column(name="proguser_webpassword")
    private String proguserWebpassword;

    public ProguserView() {}

    public ProguserView(
            Integer proguserId,
            Integer progusergroupId,
            Integer statusId,
            Integer proguserType,
            String proguserName,
            String proguserFullname,
            String progusergroupName,
            String proguserWebpassword) {
        this.proguserId = proguserId;
        this.statusId = statusId;
        this.proguserName = proguserName;
        this.proguserFullname = proguserFullname;
        this.proguserWebpassword = proguserWebpassword;
    }

    public ProguserView(Proguser entity) {
        this.proguserId = entity.getProguserId();
        this.statusId = entity.getStatusId();
        this.proguserName = entity.getProguserName();
        this.proguserFullname = entity.getProguserFullName();
        this.proguserWebpassword = entity.getProguserWebPassword();

    }

    public Integer getProguserId() {
        return proguserId;
    }

    public void setProguserId(Integer value) {
        this.proguserId = value;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer value) {
        this.statusId = value;
    }


    public String getProguserName() {
        return proguserName;
    }

    public void setProguserName(String value) {
        this.proguserName = value;
    }

    public String getProguserFullname() {
        return proguserFullname;
    }

    public void setProguserFullname(String value) {
        this.proguserFullname = value;
    }

    public String getProguserWebpassword() {
        return proguserWebpassword;
    }

    public void setProguserWebpassword(String proguserWebpassword) {
        this.proguserWebpassword = proguserWebpassword;
    }

    public String getStatusDisplay() {
        return statusDisplay;
    }

    public void setStatusDisplay(String statusDisplay) {
        this.statusDisplay = statusDisplay;
    }
}

