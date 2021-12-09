package biz.gelicon.core.controllers.admin;

import biz.gelicon.core.config.Config;
import biz.gelicon.core.dto.admin.NewProgUserPasswordDTO;
import biz.gelicon.core.dto.admin.PasswordDTO;
import biz.gelicon.core.dto.admin.ProguserDTO;
import biz.gelicon.core.model.admin.Capcode;
import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.model.admin.Progusergroup;
import biz.gelicon.core.repository.admin.ProguserRepository;
import biz.gelicon.core.response.DataResponse;
import biz.gelicon.core.response.StandardResponse;
import biz.gelicon.core.response.exceptions.NotFoundException;
import biz.gelicon.core.service.BaseService;
import biz.gelicon.core.service.admin.ProguserService;
import biz.gelicon.core.utils.ConstantForControllers;
import biz.gelicon.core.utils.GridDataOption;
import biz.gelicon.core.utils.QueryUtils;
import biz.gelicon.core.view.admin.ProguserView;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@RestController
@Tag(name = "Пользователи", description = "Контроллер для объектов \"Пользователь\" ")
@RequestMapping(value = "/v" + Config.CURRENT_VERSION + "/apps/admin/credential",
        consumes = MediaType.APPLICATION_JSON_VALUE,
        produces = MediaType.APPLICATION_JSON_VALUE)
@Transactional
public class ProguserController {

    @Autowired
    private ProguserService proguserService;
    @Autowired
    private ProguserRepository progUserRepository;

    @Operation(summary = ConstantForControllers.GETLIST_OPERATION_SUMMARY,
            description = ConstantForControllers.GETLIST_OPERATION_DESCRIPTION)
    @RequestMapping(value = "proguser/getlist", method = RequestMethod.POST)
    public DataResponse<ProguserView> getlist(@RequestBody GridDataOption gridDataOption) {
        // 1. быстрые фильтры уснанавливаются автоматически
        // 2. для именованных фильтров используется функция обратного вызова,
        // которая может добавить предикаты. Сами именнованные параметры в SQL устанавливаются также автоматически
        gridDataOption.setProcessNamedFilter(filters ->
                filters.stream()
                        .map(f -> {
                            switch (f.getName()) {
                                case "statusId":
                                    Integer status = (Integer) f.getValue();
                                    if (status != null) {
                                        return ProguserService.ALIAS_MAIN + ".proguser_status="
                                                + status;
                                    }
                                    return null;
                                default:
                                    return null;
                            }
                        })
                        .filter(Objects::nonNull)
                        .collect(Collectors.joining(" and "))
        );

        List<ProguserView> result = proguserService.getMainList(gridDataOption);

        int total = 0;
        if (gridDataOption.getPagination().getPageSize() > 0) {
            total = proguserService.getMainCount(gridDataOption);
        }
        return BaseService.buildResponse(result, gridDataOption, total);
    }

    @RequestMapping(value = "proguser/test", method = RequestMethod.POST)
    public String test(@RequestBody String s) {
        return "test Ok";
    }

    @Operation(summary = ConstantForControllers.GET_OPERATION_SUMMARY,
            description = ConstantForControllers.GET_OPERATION_DESCRIPTION)
    @RequestMapping(value = "proguser/get", method = RequestMethod.POST)
    public ProguserDTO get(@RequestBody(required = false) Integer id) {
        // для добавления
        if (id == null) {
            Proguser entity = new Proguser();
            entity.setStatusId(Capcode.USER_IS_ACTIVE);
            Capcode status = progUserRepository.getForeignKeyEntity(entity, Capcode.class);
            ProguserDTO dto = new ProguserDTO(entity);
            dto.setStatusDisplay(status.getCapcodeName());
            return dto;
        } else {
            Proguser entity = proguserService.findById(id);
            if (entity == null) {
                throw new NotFoundException(
                        String.format("Запись с идентификатором %s не найдена", id));
            }
            ProguserDTO dto = new ProguserDTO(entity);
            // для правильного отображения select
            Capcode status = progUserRepository.getForeignKeyEntity(entity, Capcode.class);
            dto.setStatusDisplay(status.getCapcodeName());

            return dto;
        }
    }

    @Operation(summary = ConstantForControllers.SAVE_OPERATION_SUMMARY,
            description = ConstantForControllers.SAVE_OPERATION_DESCRIPTION)
    @RequestMapping(value = "proguser/save", method = RequestMethod.POST)
    public ProguserView save(@RequestBody ProguserDTO proguserDTO) {
        Proguser entity = proguserDTO.toEntity();
        entity.setProguserGroupId(Progusergroup.EVERYONE); // всегда в одну группу
        Proguser result;
        if (entity.getProguserId() == null) {
            result = proguserService.add(entity);
        } else {
            result = proguserService.edit(entity);
        }
        // выбираем представление для одной записи
        return proguserService.getOne(result.getProguserId());

    }

    @Operation(summary = ConstantForControllers.DELETE_OPERATION_SUMMARY,
            description = ConstantForControllers.DELETE_OPERATION_DESCRIPTION)
    @RequestMapping(value = "proguser/delete", method = RequestMethod.POST)
    public String delete(@RequestBody int[] ids) {
        proguserService.deleteByIds(ids);
        return StandardResponse.SUCCESS;
    }


    @Operation(summary = "Список пользователей по поисковой сроке",
            description = "Возвращает список пользователей в наименовании, или логине которых встречается поисковая строка")
    @RequestMapping(value = "proguser/find", method = RequestMethod.POST)
    public List<ProguserView> find(@RequestBody SimpleSearchOption options) {
        //Защита от коротких поисковых строк
        if (options.getSearch() != null && options.getSearch().length() < 4) {
            return new ArrayList<>();
        }
        GridDataOption qopt = new GridDataOption.Builder()
                .search(options.getSearch())
                .addSort("proguserName", Sort.Direction.ASC)
                .pagination(1, QueryUtils.UNLIMIT_PAGE_SIZE)
                .build();
        return proguserService.getListForFind(qopt);
    }

    public static class SimpleSearchOption {

        private String search;

        public String getSearch() {
            return search;
        }

        public void setSearch(String search) {
            this.search = search;
        }
    }

}
