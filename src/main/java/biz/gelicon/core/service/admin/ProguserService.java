package biz.gelicon.core.service.admin;

import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.repository.admin.ProguserRepository;
import biz.gelicon.core.service.BaseService;
import biz.gelicon.core.utils.GridDataOption;
import biz.gelicon.core.utils.Query;
import biz.gelicon.core.validators.admin.ProguserValidator;
import biz.gelicon.core.view.admin.ProguserView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProguserService extends BaseService<Proguser> {
    private static final Logger logger = LoggerFactory.getLogger(ProguserService.class);
    public static final String ALIAS_MAIN = "PU";

    @Autowired
    private ProguserRepository proguserRepository;
    @Autowired
    private ProguserValidator proguserValidator;

    // главный запрос. используется в главной таблице
    // в контроллере используется в getlist и save
    final String mainSQL=String.format(
            "SELECT %s.*, " +
                    "CC.capcode_name proguser_status_display " +
            "FROM proguser %1$s " +
                  "INNER JOIN capcode CC ON CC.capcode_id=%1$s.proguser_status_id " +
                  "/*FROM_PLACEHOLDER*/ " +
            "WHERE 1=1 /*WHERE_PLACEHOLDER*/ " +  //WHERE_PLACEHOLDER если не пуст, всегда добавляет and, поэтому требуется 1=1
            "/*ORDERBY_PLACEHOLDER*/"
            ,ALIAS_MAIN);


    @PostConstruct
    public void init() {
        init(proguserRepository, proguserValidator);
    }

    public List<ProguserView> getMainList(GridDataOption gridDataOption) {
        Map<String, String> subsColumns = new HashMap<>();
        subsColumns.put("proguser_status_display","CC.capcode_name");

        return new Query.QueryBuilder<ProguserView>(mainSQL)
                .setMainAlias(ALIAS_MAIN)
                .setPageableAndSort(gridDataOption.buildPageRequest())
                .setFrom(gridDataOption.buildFullTextJoin("proguser",ALIAS_MAIN))
                .setPredicate(gridDataOption.buildPredicate(ProguserView.class,ALIAS_MAIN,subsColumns))
                .setParams(gridDataOption.buildQueryParams())
                .build(ProguserView.class)
                .execute();
    }

    public int getMainCount(GridDataOption gridDataOption) {
        Map<String, String> subsColumns = new HashMap<>();
        subsColumns.put("proguser_status_display","CC.capcode_name");

        return new Query.QueryBuilder<ProguserView>(mainSQL)
                .setMainAlias(ALIAS_MAIN)
                .setFrom(gridDataOption.buildFullTextJoin("proguser",ALIAS_MAIN))
                .setPredicate(gridDataOption.buildPredicate(ProguserView.class,ALIAS_MAIN,subsColumns))
                .setParams(gridDataOption.buildQueryParams())
                .build(ProguserView.class)
                .count();

    }


    public ProguserView getOne(Integer id) {
        return new Query.QueryBuilder<ProguserView>(mainSQL)
                .setPredicate(ALIAS_MAIN+".proguser_id=:proguserId")
                .build(ProguserView.class)
                .executeOne("proguserId", id);
    }

    public List<ProguserView> getListForFind(GridDataOption gridDataOption) {
        return new Query.QueryBuilder<ProguserView>(mainSQL)
                .setMainAlias(ALIAS_MAIN)
                .setPageableAndSort(gridDataOption.buildPageRequest())
                .setFrom(gridDataOption.buildFullTextJoin("proguser",ALIAS_MAIN))
                .setPredicate(gridDataOption.buildPredicate(ProguserView.class,ALIAS_MAIN,null))
                .setParams(gridDataOption.buildQueryParams())
                .build(ProguserView.class)
                .execute();

    }
}

