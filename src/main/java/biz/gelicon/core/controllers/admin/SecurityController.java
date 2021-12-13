package biz.gelicon.core.controllers.admin;

import biz.gelicon.core.annotations.RestrictStoreToAudit;
import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.repository.admin.ProguserRepository;
import biz.gelicon.core.response.TokenResponse;
import biz.gelicon.core.response.exceptions.IncorrectAuthenticationTypeException;
import biz.gelicon.core.response.exceptions.IncorrectUserOrPasswordException;
import biz.gelicon.core.security.UserCredential;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


//TODO  все методы контроллера должны быть защищены от brute-force
@RestController
@Tag(name = "Безопасность", description =
        "Контроллер для управления токенами и функциями, не требующими авторизации  " +
                "Контроллер находится в неавторизированной зоне.")
@RequestMapping(value = "/security",
        consumes = MediaType.APPLICATION_JSON_VALUE,
        produces = MediaType.APPLICATION_JSON_VALUE)
@Transactional
public class SecurityController {

    private static final Logger logger = LoggerFactory.getLogger(SecurityController.class);

    @Autowired
    private ProguserRepository proguserRepository;

    @Value("${gelicon.core.aeskey}")
    private String aeskey;
    @Value("${gelicon.core.frontend}")
    private String frontendBaseAddress;

    /**
     * Тип аутентификации 1 - Обычная, пароль хранится в proguser_webpassword
     */
    @Value("${gelicon.authentication_type:0}")
    private Integer authenticationType;

    protected static String token = "e9b3c034-fdd5-456f-825b-4c632f2053ac"; //SYSDBA

    @Operation(summary = "Получение токена",
            description = "Возвращает токен или ошибку авторизации. "
                    + "Если возвращается ошибка с кодом 131, то пароль правильный, но временный. " +
                    "Для входа в систему его нужно заменить на постоянный (вызов changepswd) ")
    @RequestMapping(value = "gettoken", method = RequestMethod.POST)
    public TokenResponse getToken(@RequestBody UserCredential credential) {
        // Пользователи из переданного логина
        Proguser pu = proguserRepository.findByUserName(credential.getUserName());
        if (pu == null) {
            throw new IncorrectUserOrPasswordException();
        }
        // todo - сделать
        switch (authenticationType) {
            case 0:
                // Втупую пароль проверим
                if (!pu.getProguserWebPassword().trim().equals(credential.getPassword())) {
                    throw new IncorrectUserOrPasswordException();
                }
                return new TokenResponse(
                        token,
                        pu.getProguserFullName(),
                        pu.getProguserName()
                );
            default:
                throw new IncorrectAuthenticationTypeException();
        }
    }


}
