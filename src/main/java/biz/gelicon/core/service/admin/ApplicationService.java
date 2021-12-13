package biz.gelicon.core.service.admin;

import biz.gelicon.core.model.admin.Application;
import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.repository.admin.ApplicationRepository;
import biz.gelicon.core.service.BaseService;
import biz.gelicon.core.view.admin.ApplicationView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ApplicationService extends BaseService<Application> {
    private static final Logger logger = LoggerFactory.getLogger(ApplicationService.class);
    public static final String ALIAS_MAIN = "A";

    @Autowired
    private ApplicationRepository applicationRepository;

    // главный запрос для выбра всех модулей. используется в главной таблице
    // в контроллере используется в getlist и save
    final String mainSQL=String.format(" "
                    + " SELECT %s.* "
                    + " FROM application %1$s "
                    + "    /*FROM_PLACEHOLDER*/ "
                    + " WHERE %1$s.application_type = %d /*WHERE_PLACEHOLDER*/ "
                    + " /*ORDERBY_PLACEHOLDER*/"
            ,ALIAS_MAIN,Application.TYPE_GELICON_CORE_APP);


    public List<ApplicationView> getAccessList(Integer proguserId) {
        String sql;
        List<Application> list;
        // proguser_id=1 - для sysdba все модули доступны
        if (proguserId.intValue()== Proguser.SYSDBA_PROGUSER_ID) {
            sql = "SELECT a.* " +
                    "FROM application a " +
                    "WHERE a.application_type= " + Application.TYPE_GELICON_CORE_APP;
            list = applicationRepository.findQuery(sql);
        } else {
            sql = "SELECT DISTINCT a.* " +
                    "FROM application a " +
                    "INNER JOIN applicationrole ar ON ar.application_id=a.application_id " +
                    "INNER JOIN proguserrole pur ON pur.accessrole_id=ar.accessrole_id " +
                    "WHERE a.application_type= " + Application.TYPE_GELICON_CORE_APP+
                    " AND (pur.proguser_id=:proguser_id)";
            list = applicationRepository.findQuery(sql, "proguser_id", proguserId);
        }
        return list.stream()
                .map(ApplicationView::new)
                .collect(Collectors.toList());
    }


}

