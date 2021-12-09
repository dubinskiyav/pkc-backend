package biz.gelicon.core.repository.admin;


import biz.gelicon.core.model.admin.Capcode;
import biz.gelicon.core.model.admin.Proguser;
import biz.gelicon.core.repository.TableRepository;
import biz.gelicon.core.utils.DatabaseUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;

@Repository
public class ProguserRepository implements TableRepository<Proguser> {

    private static final Logger logger = LoggerFactory.getLogger(ProguserRepository.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Proguser findByUserName(String name) {
        List<Proguser> users = findWhere("m0.proguser_name=:proguser_name", "proguser_name", name);
        return !users.isEmpty()?users.get(0):null;
    }

    @Override
    public void create() {
        Resource resource = new ClassPathResource("sql/400210-proguser.sql");
        ResourceDatabasePopulator databasePopulator = new ResourceDatabasePopulator(resource);
        databasePopulator.setSqlScriptEncoding("UTF-8");
        databasePopulator.execute(jdbcTemplate.getDataSource());
        logger.info("proguser created");
    }

    @Override
    public void dropForTest() {
        String[] dropTableBefore = new String[]{
        };
        TableRepository.super.drop(dropTableBefore);

        TableRepository.super.dropForTest();

        String[] dropTableAfter = new String[]{
        };
        TableRepository.super.drop(dropTableAfter);
    }

    @Override
    public int load() {
        Proguser[] data =  new Proguser[] {
                new Proguser(1, Capcode.USER_IS_ACTIVE,"root","Администратор"),
                new Proguser(2, Capcode.USER_IS_ACTIVE,"test1","Тестовый 1"),
                new Proguser(3, Capcode.USER_IS_BLOCKED,"test2","Тестовый 2"),
                new Proguser(4, Capcode.USER_IS_ACTIVE,"test3","Тестовый 3")
        };
        insert(Arrays.asList(data));
        logger.info(String.format("%d proguser loaded", data.length));
        DatabaseUtils.setSequence("proguser_id_gen", data.length+1);
        return data.length;
    }

}
