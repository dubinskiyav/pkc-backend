package biz.gelicon.core.maintenance;

import biz.gelicon.core.artifacts.ArtifactKinds;
import biz.gelicon.core.artifacts.ArtifactManagerImpl;
import biz.gelicon.core.controllers.admin.IntergatedTest;
import biz.gelicon.core.reports.ReportManagerImpl;
import biz.gelicon.core.utils.GridDataOption;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.not;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class MaintenanceSystemServiceTest extends IntergatedTest {

    @BeforeAll
    public static void setup() {
        token = "e9b3c034-fdd5-456f-825b-4c632f2053ac"; //root
    }

    private static final String CONTOURE = "admin";
    private static final String MODULE = "credential";

    @Autowired
    MaintenanceSystemService maintenanceSystemService;

    /**
     * префикс пакетов системы
     */
    @Value("${gelicon.core.prefix:biz.gelicon.core}")
    private String geliconCorePrefix;

    @Autowired
    ReportManagerImpl manager;

    @Autowired
    ReportManagerImpl reportManager;



}
