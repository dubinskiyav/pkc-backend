package biz.gelicon.core.controllers.admin;

import biz.gelicon.core.config.Config;
import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.repository.admin.ProguserRepository;
import biz.gelicon.core.response.DataResponse;
import biz.gelicon.core.security.UserDetailsImpl;
import biz.gelicon.core.service.BaseService;
import biz.gelicon.core.service.admin.ApplicationService;
import biz.gelicon.core.view.admin.ApplicationView;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.core.Authentication;

import java.util.List;

@RestController
@Tag(name = "Доступ", description = "Контроллер системы доступа")
@RequestMapping(value = "/v" + Config.CURRENT_VERSION + "/apps/admin/credential",
        consumes = MediaType.APPLICATION_JSON_VALUE,
        produces = MediaType.APPLICATION_JSON_VALUE)
public class AccessController {
    private static final Logger logger = LoggerFactory.getLogger(AccessController.class);

    @Autowired
    private ApplicationService applicationService;

    @Operation(summary = "Список объектов 'Модуль', доступных текущему пользователю",
            description = "Возвращает список объектов 'Модуль', доступных текущему пользователю. " +
                    "Метод работает только для авторизированных пользователей")
    @RequestMapping(value = "applicationrole/accesslist", method = RequestMethod.POST)
    public DataResponse<ApplicationView> getAccessList(Authentication authentication) {
        Proguser pu = ((UserDetailsImpl) authentication.getPrincipal()).getProgUser();
        List<ApplicationView> result = applicationService.getAccessList(pu.getProguserId());
        return BaseService.buildResponse(result);
    }


}
