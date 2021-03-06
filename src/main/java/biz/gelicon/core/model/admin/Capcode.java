package biz.gelicon.core.model.admin;

import biz.gelicon.core.annotations.OrderBy;
import biz.gelicon.core.annotations.TableDescription;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/* Сущность сгенерирована 30.04.2021 10:29 */
@Table(
        name = "capcode",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"capcodetype_id", "capcode_code"}),
                @UniqueConstraint(columnNames = {"capcodetype_id", "capcode_name"})
        }
)
@TableDescription("Кодификатор")
@OrderBy("capcode_sortcode")
public class Capcode {
    // Активный пользователь
    public final static int USER_IS_ACTIVE = 1301;
    // Заблокированный пользователь
    public final static int USER_IS_BLOCKED = 1302;
    // В архиве
    public final static int USER_ARCHIVE = 1303;
    // Канал электронной почты
    public final static int CHANNEL_EMAIL = 9001;
    // аутентификация по паролю
    public final static int AUTH_BYPASSWORD = 21481;
    // Типы атрибутов: 400 - 411
    // Тип атрибута: ОАУ
    public final static int TYPEATTR_SUBJECT = 408;
    // Тип атрибута: Справочники
    public final static int TYPEATTR_REFBOOK = 411;
    // Оповещение об изменении документа
    public final static int EVNOT_DEF_DOCUMENT = 8901;
    // Тип периодического задания
    public final static int CAPJOB_TYPE = 136;
    // Периодичность повторения задания
    public final static int CAPJOB_INTERVAL = 99;
    // Состояние задания
    public final static int CAPJOB_STATE = 100;

    @Id
    @Column(name = "capcode_id",nullable = false)
    public Integer capcodeId;

    @ManyToOne(targetEntity = Capcodetype.class)
    @Column(name = "capcodetype_id", nullable = false)
    private Integer capcodetypeId;

    @Column(name = "capcode_code", nullable = false)
    @Size(max = 10, message = "Поле \"capcode_code\" должно содержать не более {max} символов")
    @NotBlank(message = "Поле \"capcode_code\" не может быть пустым")
    private String capcodeCode;

    @Column(name = "capcode_name", nullable = false)
    @Size(max = 50, message = "Поле \"capcode_name\" должно содержать не более {max} символов")
    @NotBlank(message = "Поле \"capcode_name\" не может быть пустым")
    private String capcodeName;

    @Column(name = "capcode_sortcode", nullable = true)
    @Size(max = 10, message = "Поле \"capcode_sortcode\" должно содержать не более {max} символов")
    private String capcodeSortcode;

    @Column(name = "capcode_text", nullable = true)
    private byte[] capCodeText;

    public Integer getCapcodeId() {
        return capcodeId;
    }

    public void setCapcodeId(Integer value) {
        this.capcodeId = value;
    }

    public Integer getCapcodetypeId() {
        return capcodetypeId;
    }

    public void setCapcodetypeId(Integer value) {
        this.capcodetypeId = value;
    }

    public String getCapcodeCode() {
        return capcodeCode;
    }

    public void setCapcodeCode(String value) {
        this.capcodeCode = value;
    }

    public String getCapcodeName() {
        return capcodeName;
    }

    public void setCapcodeName(String value) {
        this.capcodeName = value;
    }

    public String getCapcodeSortcode() {
        return capcodeSortcode;
    }

    public void setCapcodeSortcode(String value) {
        this.capcodeSortcode = value;
    }

    public byte[] getCapCodeText() {
        return capCodeText;
    }

    public void setCapCodeText(byte[] value) {
        this.capCodeText = value;
    }


    public Capcode() {}

    public Capcode(
            Integer capcodeId,
            Integer capcodetypeId,
            String capcodeCode,
            String capcodeName,
            String capcodeSortcode,
            byte[] capCodeText) {
        this.capcodeId = capcodeId;
        this.capcodetypeId = capcodetypeId;
        this.capcodeCode = capcodeCode;
        this.capcodeName = capcodeName;
        this.capcodeSortcode = capcodeSortcode;
        this.capCodeText = capCodeText;
    }

}
