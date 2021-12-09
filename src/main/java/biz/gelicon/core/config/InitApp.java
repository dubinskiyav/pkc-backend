package biz.gelicon.core.config;

import biz.gelicon.core.MainApplication;
import biz.gelicon.core.artifacts.ArtifactManagerImpl;
import biz.gelicon.core.maintenance.MaintenanceSystemService;
import biz.gelicon.core.reports.ReportManagerImpl;
import biz.gelicon.core.utils.TableMetadata;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

/**
 * Запускается при запуске Spring и инициализирует все что надо
 */
@Component
public class InitApp implements ApplicationRunner {

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    ReportManagerImpl reportManager;

    @Autowired
    ArtifactManagerImpl artifactManager;

    @Autowired
    MaintenanceSystemService maintenanceSystemService;

    @Value("${gelicon.run-as-test:false}")
    private Boolean runAsTest;

    /**
     * Для пересмоздания базы данных установить
     * recreatedatabase=true
     * в application.properties
     */
    @Value("${gelicon.orm.recreatedatabase:false}")
    private Boolean recreatedatabase;

    @Value("${gelicon.report.restcrictOverlapping:false}")
    private Boolean restcrictOverlappingReport;
    @Value("${gelicon.artifact.restcrictOverlapping:false}")
    private Boolean restcrictOverlappingArtifact;
    /** префикс пакетов системы */
    @Value("${gelicon.core.prefix:biz.gelicon.core}")
    private String geliconCorePrefix;

    @Value("${spring.datasource.url}")
    private String dataBaseUrl;

    private static final Logger logger = LoggerFactory.getLogger(InitApp.class);

    public void run(ApplicationArguments args) {
        logger.info("");
        logger.info("=================================================");
        logger.info("=================================================");
        logger.info("InitApp running...");
        logger.info("Database connection string: " + dataBaseUrl);
        MainApplication.setApplicationContext(applicationContext);
        // Считаем все аннотации @Table
        TableMetadata.readTableMetadataAnnotation(geliconCorePrefix);

        if(!runAsTest) { // Все, что необходимо запускать, но не в тесте - сюда!
            // загрузка печатных форм
            reportManager.setOverlappingReportFlag(!restcrictOverlappingReport);
            reportManager.loadReports();
            // загрузка артефактов
            artifactManager.setOverlappingFlag(!restcrictOverlappingArtifact);
            artifactManager.loadArtifacts();

            reportManager.testJNDI();

        }

        logger.info("InitApp running...Ok");
        logger.info("=================================================");
        logger.info("=================================================");

    }

}